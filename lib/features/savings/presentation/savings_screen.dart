import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/local_db.dart';

class SavingsTrackerScreen extends StatefulWidget {
  const SavingsTrackerScreen({super.key});
  @override
  State<SavingsTrackerScreen> createState() => _SavingsTrackerScreenState();
}

class _SavingsTrackerScreenState extends State<SavingsTrackerScreen> {
  List<Map<String, dynamic>> _goals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final goals = await LocalDB.getSavingsGoals();
    setState(() { _goals = goals; _loading = false; });
  }

  Future<void> _addGoal() async {
    final nameC = TextEditingController();
    final amountC = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Savings Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Goal name', hintText: 'e.g. Trip home')),
            const SizedBox(height: 12),
            TextField(controller: amountC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Target (HKD)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );
    if (result == true && nameC.text.isNotEmpty && amountC.text.isNotEmpty) {
      await LocalDB.saveSavingsGoal({
        'name': nameC.text,
        'target': double.parse(amountC.text),
        'saved': 0.0,
        'created': DateTime.now().toIso8601String(),
      });
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text('Savings Goals'),
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: AppTheme.darkText,
        actions: [
          IconButton(icon: const Icon(Icons.add, size: 22), onPressed: _addGoal),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _goals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('💪', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 16),
                      const Text('No savings goals yet', style: TextStyle(fontSize: 16, color: Color(0xFF999999))),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _addGoal,
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.warmGold, foregroundColor: Colors.white),
                        child: const Text('Add Your First Goal'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _goals.length,
                  itemBuilder: (ctx, i) {
                    final g = _goals[i];
                    final target = (g['target'] as num).toDouble();
                    final saved = (g['saved'] as num?)?.toDouble() ?? 0;
                    final pct = target > 0 ? (saved / target).clamp(0.0, 1.0) : 0.0;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(g['name'] ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                Text('HK\$${saved.toStringAsFixed(0)} / HK\$${target.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: AppTheme.lightText)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: pct,
                                minHeight: 8,
                                backgroundColor: AppTheme.warmGold.withOpacity(0.1),
                                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.warmGold),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('${(pct * 100).toStringAsFixed(0)}% complete', style: TextStyle(fontSize: 11, color: AppTheme.lightText)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}