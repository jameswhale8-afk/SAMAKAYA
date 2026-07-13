import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/local_db.dart';

class WellnessCalendarScreen extends StatefulWidget {
  const WellnessCalendarScreen({super.key});
  @override
  State<WellnessCalendarScreen> createState() => _WellnessCalendarScreenState();
}

class _WellnessCalendarScreenState extends State<WellnessCalendarScreen> {
  List<Map<String, dynamic>> _logs = [];
  bool _loading = true;
  int _selectedMood = 3;
  String? _selectedSymptoms;
  final _noteC = TextEditingController();

  final List<String> _symptoms = ['Cramps', 'Headache', 'Fatigue', 'Bloating', 'Back pain', 'None'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final logs = await LocalDB.getWellnessLogs();
    setState(() { _logs = logs; _loading = false; });
  }

  Future<void> _saveLog() async {
    await LocalDB.saveWellnessLog({
      'date': DateTime.now().toIso8601String().substring(0, 10),
      'mood': _selectedMood,
      'symptoms': _selectedSymptoms,
      'notes': _noteC.text,
    });
    _noteC.clear();
    _load();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged for today'), duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text('Wellness'),
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: AppTheme.darkText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
            ),
            child: Column(
              children: [
                const Text('How are you feeling today?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (i) {
                    final emojis = ['😢', '😟', '😐', '😊', '🥰'];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedMood = i + 1),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _selectedMood == i + 1 ? AppTheme.coral.withOpacity(0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(emojis[i], style: TextStyle(fontSize: _selectedMood == i + 1 ? 32 : 24)),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedSymptoms,
                  decoration: const InputDecoration(labelText: 'Symptoms (optional)', border: OutlineInputBorder()),
                  items: _symptoms.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (v) => setState(() => _selectedSymptoms = v),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _noteC,
                  decoration: const InputDecoration(labelText: 'Notes (optional)', hintText: 'How was your day?', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveLog,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.sageGreen, foregroundColor: Colors.white),
                    child: const Text('Log Today'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (_logs.isNotEmpty) ...[
            const Text('Recent Logs', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ..._logs.reversed.take(7).map((log) => Card(
              margin: const EdgeInsets.only(bottom: 6),
              child: ListTile(
                leading: Text(['😢', '😟', '😐', '😊', '🥰'][(log['mood'] as int? ?? 3) - 1], style: const TextStyle(fontSize: 20)),
                title: Text(log['date'] ?? '', style: const TextStyle(fontSize: 13)),
                subtitle: log['notes'] != null && (log['notes'] as String).isNotEmpty
                    ? Text(log['notes'], style: const TextStyle(fontSize: 12, color: Colors.grey))
                    : null,
              ),
            )),
          ],
        ],
      ),
    );
  }
}