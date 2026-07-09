import 'package:flutter/material.dart';
import '../../core/theme.dart';

class PrayerDevotionalScreen extends StatefulWidget {
  const PrayerDevotionalScreen({super.key});
  @override
  State<PrayerDevotionalScreen> createState() => _PrayerDevotionalScreenState();
}

class _PrayerDevotionalScreenState extends State<PrayerDevotionalScreen> {
  bool isMuslim = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Faith"), backgroundColor: const Color(0xFF2D5A3D)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isMuslim = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isMuslim ? Colors.grey[200] : const Color(0xFF2D5A3D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("✝️ Christian", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isMuslim = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isMuslim ? const Color(0xFF2D5A3D) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("☪️ Muslim", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (!isMuslim) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                child: Column(
                  children: [
                    const Text("📖", style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 12),
                    const Text("Verse of the Day", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D5A3D))),
                    const SizedBox(height: 12),
                    const Text("\"I can do all things through Christ who strengthens me.\"", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.grey, height: 1.5)),
                    const SizedBox(height: 8),
                    const Text("— Philippians 4:13", style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 16),
                    const Text("Pray for your family today. They are proud of you.", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                child: Column(
                  children: [
                    const Text("☪️", style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 12),
                    const Text("Prayer Times Today", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D5A3D))),
                    const SizedBox(height: 12),
                    _prayerTime("Fajr", "5:12 AM"),
                    _prayerTime("Dhuhr", "12:30 PM"),
                    _prayerTime("Asr", "3:45 PM"),
                    _prayerTime("Maghrib", "6:10 PM"),
                    _prayerTime("Isha", "7:30 PM"),
                    const SizedBox(height: 12),
                    const Text("Qibla direction: 292° NW", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _prayerTime(String name, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}