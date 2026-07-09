import 'package:flutter/material.dart';
import '../../core/theme.dart';

class FamilyHealthScreen extends StatelessWidget {
  const FamilyHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Family Health"), backgroundColor: const Color(0xFF2D5A3D)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Column(
              children: [
                const Text("👨‍👩‍👧‍👦", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("Family Health Records", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D5A3D))),
                const SizedBox(height: 4),
                const Text("Keep your family's medical info safe and accessible", style: TextStyle(color: Colors.grey, fontSize: 13, textAlign: TextAlign.center)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _personCard("👩", "Mom", "Manila", [
            "Blood Type: O+", "Allergies: Penicillin", "Medication: Blood pressure daily", "Emergency: +63 912 345 6789"
          ]),
          _personCard("👨", "Dad", "Manila", [
            "Blood Type: A+", "Allergies: None", "Medication: Diabetes medication", "Emergency: +63 912 345 6790"
          ]),
          _personCard("👧", "Daughter", "Manila", [
            "Blood Type: B+", "Allergies: Peanuts", "Medication: None", "School: Manila Elementary"
          ]),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add Family Member"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2D5A3D),
                side: const BorderSide(color: Color(0xFF2D5A3D)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text("Export as PDF"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _personCard(String emoji, String name, String location, List<String> info) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: const Color(0xFF2D5A3D).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 8),
                  ...info.map((i) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text("• $i", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  )),
                ],
              ),
            ),
            const Icon(Icons.edit, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}