import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class InterestGroupsScreen extends StatelessWidget {
  const InterestGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Groups"),
        backgroundColor: AppTheme.coral,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _groupCard("🏐", "Volleyball Club", "12 members", "HK Island", Colors.blue),
          _groupCard("🥾", "Hiking Sisters", "8 members", "Weekend hikes", Colors.green),
          _groupCard("📺", "K-Drama Fans", "24 members", "Watch parties", AppTheme.coral),
          _groupCard("🍳", "Cooking Exchange", "15 members", "Recipes from home", Colors.orange),
          _groupCard("🙏", "Prayer Group", "20 members", "Daily prayer", Colors.purple),
          _groupCard("💪", "Wellness Circle", "6 members", "Self care", Colors.teal),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Create Your Own Group"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.coral,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupCard(String emoji, String name, String members, String desc, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 56, height: 56,
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$members · $desc", style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}