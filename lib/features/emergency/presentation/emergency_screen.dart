import 'package:flutter/material.dart';
import '../../../../../../../core/theme.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency & Help"), backgroundColor: Colors.red[700]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Column(
              children: [
                const Text("🚨", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                const Text("In an emergency, call 999", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(height: 4),
                const Text("If you can't speak, press the button below to send an SMS", style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                    label: const Text("📱 Text 999 — I need help"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Consulates & Support", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _contactCard("🇵🇭", "PH Consulate HK", "+852 2543 8000", "phconsulate.hk"),
          _contactCard("🇮🇩", "ID Consulate HK", "+852 2890 4421", "kemlu.go.id/hongkong"),
          _contactCard("🇵🇭", "PH Consulate SG", "+65 6737 3977", "philippine-embassy.org.sg"),
          _contactCard("🇮🇩", "ID Consulate SG", "+65 6737 7422", "kbrisingapura.kemlu.go.id"),
          const SizedBox(height: 20),
          const Text("NGO Support", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _contactCard("🧡", "Enrich HK", "+852 2381 1212", "enrichhk.org"),
          _contactCard("🧡", "HELP for Domestic Workers", "+852 2523 7178", "helpfordomesticworkers.org"),
          _contactCard("🧡", "MFMW (Mission for Migrants)", "+852 2723 1312", "migrants.net"),
          _contactCard("🧡", "Bethune House", "+852 2723 1312", "bethunehouse.org.hk"),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red[700],
                side: BorderSide(color: Colors.red[300]!),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Add Your Country's Consulate"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(String flag, String name, String phone, String website) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Text(flag, style: const TextStyle(fontSize: 28)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("$phone\n$website", style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.call_outlined, color: Colors.green),
        onTap: () {},
      ),
    );
  }
}