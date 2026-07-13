import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Badges"), backgroundColor: const Color(0xFFD4A017)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFD4A017), Color(0xFFFF0080)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text("⭐", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("GENESIS FOUNDER", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const Text("#8,247 / 10,000 claimed", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: 0.175, minHeight: 8, backgroundColor: Colors.white24, valueColor: const AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Your Badges", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _badgeCard("🥭", "Genesis Founder", "One of the first 10,000 sisters to join KAYA KITA", true),
          _badgeCard("🔥", "7-Day Streak", "Checked in for 7 days in a row", true),
          _badgeCard("🏆", "Referral Queen", "Invited 5+ sisters to KAYA KITA", true),
          _badgeCard("💎", "30-Day Streak", "Checked in every day for a month", false),
          _badgeCard("👑", "Ambassador", "Invited 20+ sisters to KAYA KITA", false),
        ],
      ),
    );
  }

  Widget _badgeCard(String icon, String name, String desc, bool unlocked) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: unlocked ? const Color(0xFFD4A017).withOpacity(0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Opacity(opacity: unlocked ? 1.0 : 0.3, child: Text(icon, style: const TextStyle(fontSize: 24))),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.w600, color: unlocked ? Colors.black : Colors.grey)),
        subtitle: Text(desc, style: TextStyle(color: unlocked ? Colors.grey : Colors.grey[300], fontSize: 12)),
        trailing: Icon(unlocked ? Icons.check_circle : Icons.lock, color: unlocked ? const Color(0xFF2D5A3D) : Colors.grey[300]),
      ),
    );
  }
}