import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class SavingsTrackerScreen extends StatefulWidget {
  const SavingsTrackerScreen({super.key});
  @override
  State<SavingsTrackerScreen> createState() => _SavingsTrackerScreenState();
}

class _SavingsTrackerScreenState extends State<SavingsTrackerScreen> {
  String goal = "HK\$50,000";
  double saved = 12500;
  double target = 50000;

  @override
  Widget build(BuildContext context) {
    double pct = saved / target;
    return Scaffold(
      appBar: AppBar(title: const Text("My Savings"), backgroundColor: const Color(0xFFD4A017)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  const Text("🎯", style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 8),
                  Text("My Goal", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(goal, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pct, minHeight: 16,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4A017)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text("HK\$${saved.toStringAsFixed(0)} / HK\$${target.toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text("${(pct * 100).toStringAsFixed(0)}% complete",
                      style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD4A017).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text("💡", style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text("Every time you send money home, we add 1% of the amount to your savings tracker.",
                        style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text("Edit Goal"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD4A017),
                  side: const BorderSide(color: Color(0xFFD4A017)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}