import 'package:flutter/material.dart';
import '../../core/theme.dart';

class WellnessCalendarScreen extends StatefulWidget {
  const WellnessCalendarScreen({super.key});
  @override
  State<WellnessCalendarScreen> createState() => _WellnessCalendarScreenState();
}

class _WellnessCalendarScreenState extends State<WellnessCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wellness Calendar"), backgroundColor: const Color(0xFFD4A017)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFD4A017).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text("🌸", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("Track your cycle & wellness", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD4A017))),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statItem("📅", "Day 14", "of cycle"),
                    _statItem("📊", "28 days", "avg cycle"),
                    _statItem("🎯", "Next in", "14 days"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Log Today", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _moodButton("😊", "Great"),
          _moodButton("😐", "Okay"),
          _moodButton("😔", "Tired"),
          _moodButton("🤒", "Not well"),
          const SizedBox(height: 20),
          const Text("Symptoms", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: ["Headache", "Cramps", "Bloating", "Fatigue", "Back pain", "Nausea", "Dizziness", "None"]
              .map((s) => Chip(label: Text(s, style: const TextStyle(fontSize: 13)), 
                backgroundColor: Colors.grey[100], side: BorderSide.none))
              .toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A017), foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Save Today's Log"),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _statItem(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
  
  Widget _moodButton(String emoji, String label) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 24)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Radio(value: label, groupValue: "", onChanged: (v) {}),
      ),
    );
  }
}