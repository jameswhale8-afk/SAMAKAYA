import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Certificates"), backgroundColor: const Color(0xFF2D5A3D)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD4A017), width: 2),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text("📜", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("Certificate of Completion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D5A3D))),
                const SizedBox(height: 4),
                const Text("First Aid Basics", style: TextStyle(fontSize: 14, color: Color(0xFFD4A017))),
                const SizedBox(height: 12),
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D5A3D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(child: Icon(Icons.check, size: 40, color: Color(0xFF2D5A3D))),
                ),
                const SizedBox(height: 12),
                const Text("Awarded to:", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const Text("Maria Santos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text("July 2026", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A017).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("🥭", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text("KAYA KITA Academy", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFD4A017), fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Available Courses", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _courseCard("🩹", "First Aid Basics", "Learn emergency response", true, "Completed"),
          _courseCard("👵", "Elder Care Certificate", "Caring for elderly family members", false, "3 of 5 lessons"),
          _courseCard("🍳", "Cooking & Nutrition", "Healthy meals on a budget", false, "1 of 4 lessons"),
          _courseCard("💪", "Mental Health Awareness", "Recognize burnout and stress", false, "Start course"),
          _courseCard("💬", "English Conversation", "Better communication at work", false, "Start course"),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D5A3D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("📚 Browse All Courses"),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text("Download Certificate as PDF"),
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

  Widget _courseCard(String icon, String title, String desc, bool completed, String status) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: completed ? const Color(0xFF2D5A3D).withOpacity(0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(icon, style: const TextStyle(fontSize: 24))),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(completed ? Icons.check_circle : Icons.play_circle_outline, color: completed ? const Color(0xFF2D5A3D) : const Color(0xFFD4A017)),
            Text(status, style: TextStyle(fontSize: 9, color: completed ? const Color(0xFF2D5A3D) : Colors.grey)),
          ],
        ),
      ),
    );
  }
}