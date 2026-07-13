import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class TokenBalanceScreen extends StatelessWidget {
  const TokenBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Points"), backgroundColor: const Color(0xFFD4A017)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFD4A017), Color(0xFFFF0080)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text("🥭", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text("2,450", style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                const Text("KAYA KITA Points", style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("How to Earn", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _earnRow("🎯", "Daily Check-In", "+100 / day", true),
          _earnRow("👥", "Refer a Sister", "+2,000", true),
          _earnRow("💰", "Send Money Home", "+200 bonus", true),
          _earnRow("🔥", "7-Day Streak Bonus", "+500", true),
          _earnRow("📊", "Complete Your Profile", "+300", false),
          const SizedBox(height: 24),
          const Text("Recent Activity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _activityRow("Daily Check-In", "+100", "2 hours ago"),
          _activityRow("Referral: Maria D.", "+2,000", "Yesterday"),
          _activityRow("Daily Check-In", "+100", "Yesterday"),
          _activityRow("Daily Check-In", "+100", "2 days ago"),
        ],
      ),
    );
  }

  Widget _earnRow(String icon, String action, String reward, bool available) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(action, style: const TextStyle(fontSize: 14))),
          Text(reward, style: TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF2D5A3D), fontSize: 13)),
          const SizedBox(width: 8),
          Icon(available ? Icons.add_circle : Icons.lock, size: 18, color: available ? const Color(0xFF2D5A3D) : Colors.grey),
        ],
      ),
    );
  }

  Widget _activityRow(String action, String amount, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(action, style: const TextStyle(fontSize: 13, color: Colors.grey))),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF2D5A3D), fontSize: 13)),
          const SizedBox(width: 8),
          Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[400])),
        ],
      ),
    );
  }
}