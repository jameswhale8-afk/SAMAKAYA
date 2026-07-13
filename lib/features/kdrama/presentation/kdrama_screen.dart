import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class KdramaWatchlistScreen extends StatelessWidget {
  const KdramaWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drama Watchlist"), backgroundColor: AppTheme.coral),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("What sisters are watching this week", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _dramaCard("Crash Landing on You", "❤️ 24 watching", "⭐ 4.8", "Netflix", "🇰🇷"),
          _dramaCard("Queen of Tears", "❤️ 18 watching", "⭐ 4.7", "Netflix", "🇰🇷"),
          _dramaCard("Marry My Husband", "❤️ 12 watching", "⭐ 4.6", "Amazon Prime", "🇰🇷"),
          _dramaCard("Lovely Runner", "❤️ 9 watching", "⭐ 4.5", "VIU", "🇰🇷"),
          _dramaCard("Pulang Araw", "❤️ 15 watching", "⭐ 4.4", "Netflix", "🇵🇭"),
          const SizedBox(height: 16),
          Center(
            child: Text("Add what you're watching →", style: TextStyle(color: AppTheme.coral, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _dramaCard(String title, String watching, String rating, String platform, String flag) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: AppTheme.coral.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(flag, style: const TextStyle(fontSize: 24))),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$watching · $rating · $platform", style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.add_circle_outline, color: AppTheme.coral),
      ),
    );
  }
}