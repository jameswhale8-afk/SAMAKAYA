import 'package:flutter/material.dart';
import '../../core/theme.dart';

class FreeEpisodesScreen extends StatelessWidget {
  const FreeEpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Free Episodes"), backgroundColor: const Color(0xFF40E0D0)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF40E0D0).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 18, color: Color(0xFF40E0D0)),
                SizedBox(width: 8),
                Expanded(child: Text("Free episodes from legal sources. We don't host any videos — we link to free content.", style: TextStyle(fontSize: 12, color: Colors.grey))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text("🔥 Free This Week", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _episodeCard("🇰🇷", "Queen of Tears - Ep 1", "Free on Viki", "⭐ 4.8", "Available until Sunday"),
          _episodeCard("🇰🇷", "True Beauty - Ep 1", "Free on YouTube", "⭐ 4.6", "Available now"),
          _episodeCard("🇵🇭", "FPJ's Batang Quiapo - Ep 1", "Free on iWantTFC", "⭐ 4.5", "Available now"),
          _episodeCard("🇰🇷", "Crash Landing on You - Ep 1", "Free on Netflix", "⭐ 4.9", "Available until Friday"),
          _episodeCard("🇮🇩", "Tukang Bubur Naik Haji - Ep 1", "Free on VIU", "⭐ 4.3", "Available now"),
          const SizedBox(height: 20),
          const Text("Weekly Picks by Sisters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF40E0D0).withOpacity(0.1), Colors.white]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Text("📺", style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Expanded(child: Text("Join Sunday Watch Party at 8pm! 24 sisters watching Queen of Tears.", style: TextStyle(fontSize: 13))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _episodeCard(String flag, String title, String platform, String rating, String availability) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: const Color(0xFF40E0D0).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text(flag, style: const TextStyle(fontSize: 24))),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text("$platform · $rating", style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(Icons.play_circle_outline, color: Color(0xFF40E0D0), size: 28),
            Text(availability, style: TextStyle(color: Colors.orange[600], fontSize: 9)),
          ],
        ),
      ),
    );
  }
}