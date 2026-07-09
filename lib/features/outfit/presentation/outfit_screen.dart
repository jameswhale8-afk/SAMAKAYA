import 'package:flutter/material.dart';
import '../../core/theme.dart';

class OutfitRecommenderScreen extends StatelessWidget {
  const OutfitRecommenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sunday Outfit Planner"), backgroundColor: const Color(0xFFD4A017)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFFD4A017).withOpacity(0.1), Colors.white]),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD4A017).withOpacity(0.2)),
            ),
            child: Column(
              children: [
                const Text("👗", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("Sunday Outfit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
                  child: const Row(
                    children: [
                      Text("☀️", style: TextStyle(fontSize: 24)),
                      SizedBox(width: 8),
                      Expanded(child: Text("28°C · Sunny · Perfect for a dress or light blouse", style: TextStyle(fontSize: 13))),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Suggested Outfit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFFD4A017))),
                const SizedBox(height: 8),
                _outfitItem("👚", "Light blouse or sundress"),
                _outfitItem("👟", "Comfortable walking shoes"),
                _outfitItem("🕶️", "Sunglasses"),
                _outfitItem("👜", "Small crossbody bag"),
                const SizedBox(height: 12),
                const Text("Style Tip", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 4),
                const Text("Try a floral dress with white sneakers — it's the Sunday classic!", style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.cloud),
              label: const Text("Check Weather for Next Sunday"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFD4A017),
                side: const BorderSide(color: Color(0xFFD4A017)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outfitItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}