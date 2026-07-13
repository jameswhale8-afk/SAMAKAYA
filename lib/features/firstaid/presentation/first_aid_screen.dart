import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class FirstAidScreen extends StatelessWidget {
  const FirstAidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First Aid Guide"), backgroundColor: Colors.red[700]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: const Text(
              "This guide provides basic first aid information. In an emergency, call 999 immediately.",
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          _section("🤕", "Headache", "Rest in a quiet room. Drink water. Apply a cold cloth to your forehead. If severe or persistent, see a doctor."),
          _section("🤒", "Fever", "Rest, drink plenty of fluids, take paracetamol if available. See a doctor if fever lasts more than 3 days or exceeds 39°C."),
          _section("🤧", "Cold & Flu", "Rest, drink warm fluids, honey with lemon. Over-the-counter cold medicine at Watsons/Guardian."),
          _section("🤢", "Stomach Ache", "Drink clear fluids. Eat plain food (rice, toast, banana). Avoid spicy food. See a doctor if severe or persistent."),
          _section("🩹", "Cuts & Scrapes", "Clean with water, apply antiseptic, cover with bandage. Keep dry. Watch for signs of infection (redness, swelling, pus)."),
          _section("🔥", "Burns (Minor)", "Cool under running water for 10 minutes. Do not apply ice, butter, or toothpaste. Cover with clean cloth. See a doctor if blistered."),
          _section("🦶", "Foot Pain", "Rest, elevate feet, soak in warm water with salt. Wear comfortable shoes. If working on your feet, take breaks."),
          _section("😰", "Anxiety / Panic Attack", "Breathe slowly (4 seconds in, 4 seconds hold, 4 seconds out). Sit down, drink water. Call a friend or the Enrich HK helpline: +852 2381 1212."),
          _section("💊", "Medication Safety", "Always check expiry dates. Take medication exactly as directed. Ask a pharmacist at Watsons/Guardian for advice. Never share prescription medication."),
        ],
      ),
    );
  }

  Widget _section(String emoji, String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(content, style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}