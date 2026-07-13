import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class CityClockScreen extends StatelessWidget {
  const CityClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Time"), backgroundColor: const Color(0xFF40E0D0)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text("🇭🇰", style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 8),
                        Text("Hong Kong", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        const SizedBox(height: 4),
                        const Text("8:45 PM", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFD4A017))),
                        Text("28°C · Sunny", style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                      ],
                    ),
                  ),
                  const Text("⚡", style: TextStyle(fontSize: 24)),
                  Expanded(
                    child: Column(
                      children: [
                        const Text("🇵🇭", style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 8),
                        Text("Manila", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        const SizedBox(height: 4),
                        const Text("8:45 PM", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFD4A017))),
                        Text("32°C · Cloudy", style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF40E0D0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Text("💡", style: TextStyle(fontSize: 24)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Good time to call home — it's evening there too!", style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.swap_horiz),
                label: const Text("Add Another City"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF40E0D0),
                  side: const BorderSide(color: Color(0xFF40E0D0)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}