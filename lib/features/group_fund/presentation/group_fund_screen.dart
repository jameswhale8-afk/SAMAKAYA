import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class GroupFundScreen extends StatefulWidget {
  const GroupFundScreen({super.key});
  @override
  State<GroupFundScreen> createState() => _GroupFundScreenState();
}

class _GroupFundScreenState extends State<GroupFundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Group Fund"), backgroundColor: const Color(0xFFD4A017)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: Column(
              children: [
                const Text("🎉", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("Sunday Gathering Fund", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Rental hall + food + activities", style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(value: 0.72, minHeight: 12, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4A017))),
                ),
                const SizedBox(height: 8),
                const Text("HK\$1,200 of HK\$1,650 raised", style: TextStyle(fontWeight: FontWeight.w600)),
                const Text("12 sisters contributing", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Contributors", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _contributor("Maria", "🇵🇭", "HK\$200", Colors.green),
          _contributor("Ani", "🇮🇩", "HK\$150", Colors.blue),
          _contributor("Liza", "🇵🇭", "HK\$100", AppTheme.coral),
          _contributor("Sari", "🇮🇩", "HK\$100", Colors.purple),
          _contributor("You", "🇵🇭", "—", Colors.orange),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A017), foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("💰 Contribute Now"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contributor(String name, String flag, String amount, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Center(child: Text(flag, style: const TextStyle(fontSize: 20))),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}