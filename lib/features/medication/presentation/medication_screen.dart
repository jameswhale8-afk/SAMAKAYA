import 'package:flutter/material.dart';
import '../../core/theme.dart';

class MedicationReminderScreen extends StatefulWidget {
  const MedicationReminderScreen({super.key});
  @override
  State<MedicationReminderScreen> createState() => _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  final List<Map<String, String>> meds = [
    {"name": "Blood pressure", "time": "8:00 AM", "days": "Daily", "icon": "💊"},
    {"name": "Vitamins", "time": "8:00 AM", "days": "Daily", "icon": "💚"},
    {"name": "Omega 3", "time": "8:00 PM", "days": "Daily", "icon": "🐟"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medication Reminder"), backgroundColor: const Color(0xFF40E0D0)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF40E0D0), Color(0xFF2D5A3D)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text("⏰", style: TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                const Text("Next reminder in 2 hours", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("Blood pressure medication at 8:00 PM", style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Your Medications", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...meds.map((m) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: const Color(0xFF40E0D0).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(m["icon"]!, style: const TextStyle(fontSize: 24))),
              ),
              title: Text(m["name"]!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text("${m["time"]} · ${m["days"]}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              trailing: Switch(value: true, onChanged: (v) {}, activeColor: const Color(0xFF40E0D0)),
            ),
          )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add Medication"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF40E0D0),
                side: const BorderSide(color: Color(0xFF40E0D0)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}