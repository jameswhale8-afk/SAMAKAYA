import 'package:flutter/material.dart';
import '../../core/theme.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home News"), backgroundColor: const Color(0xFF2D5A3D)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF2D5A3D).withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.swap_horiz, color: Color(0xFF2D5A3D), size: 20),
                SizedBox(width: 8),
                Text("🇵🇭 Philippines", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D5A3D))),
                Spacer(),
                Text("🇮🇩 Indonesia", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _newsCard("🇵🇭", "OFW remittances hit record high", "Remittances from overseas Filipino workers reached a new high this quarter, supporting families back home.", "2h ago"),
          _newsCard("🇮🇩", "New protections for PMI workers in UAE", "Indonesia and UAE sign new agreement strengthening protections for Indonesian domestic workers.", "5h ago"),
          _newsCard("🇵🇭", "SSS contributions now payable online", "OFWs can now pay SSS contributions through GCash and other digital platforms.", "1d ago"),
          _newsCard("🇮🇩", "BPJS Kesehatan expanded for overseas workers", "Indonesian workers abroad can now maintain health insurance coverage while overseas.", "2d ago"),
          _newsCard("🇵🇭", "Free webinars for returning OFWs", "POEA offers free entrepreneurship training for returning overseas workers.", "3d ago"),
        ],
      ),
    );
  }

  Widget _newsCard(String flag, String title, String snippet, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(flag, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(snippet, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}