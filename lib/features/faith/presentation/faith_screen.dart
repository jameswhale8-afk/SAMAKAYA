import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/theme.dart';
import '../../../core/local_db.dart';

class PrayerDevotionalScreen extends StatefulWidget {
  const PrayerDevotionalScreen({super.key});
  @override
  State<PrayerDevotionalScreen> createState() => _PrayerDevotionalScreenState();
}

class _PrayerDevotionalScreenState extends State<PrayerDevotionalScreen> {
  bool isMuslim = false;
  Map<String, dynamic>? _prayerTimes;
  Map<String, dynamic>? _bibleVerse;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      // Fetch prayer times (Aladhan API)
      final prayerRes = await http.get(
        Uri.parse('https://api.aladhan.com/v1/timingsByCity?city=Hong+Kong&country=HK&method=2'),
      ).timeout(const Duration(seconds: 5));
      if (prayerRes.statusCode == 200) {
        _prayerTimes = jsonDecode(prayerRes.body)['data']['timings'];
      }

      // Fetch Bible verse (bible-api.com)
      final bibleRes = await http.get(
        Uri.parse('https://bible-api.com/?random=1&translation=web'),
      ).timeout(const Duration(seconds: 5));
      if (bibleRes.statusCode == 200) {
        _bibleVerse = jsonDecode(bibleRes.body);
      }
    } catch (_) {}
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text('Faith'),
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: AppTheme.darkText,
        actions: [
          GestureDetector(
            onTap: () => setState(() => isMuslim = !isMuslim),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isMuslim ? AppTheme.sageGreen.withOpacity(0.1) : AppTheme.coral.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(isMuslim ? '🕌' : '⛪', style: const TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (isMuslim && _prayerTimes != null) ...[
                    _sectionHeader('Prayer Times — Hong Kong'),
                    const SizedBox(height: 12),
                    _prayerCard('Fajr', _prayerTimes!['Fajr'] ?? '--', Icons.wb_twilight),
                    _prayerCard('Dhuhr', _prayerTimes!['Dhuhr'] ?? '--', Icons.wb_sunny),
                    _prayerCard('Asr', _prayerTimes!['Asr'] ?? '--', Icons.cloud),
                    _prayerCard('Maghrib', _prayerTimes!['Maghrib'] ?? '--', Icons.sunset),
                    _prayerCard('Isha', _prayerTimes!['Isha'] ?? '--', Icons.nights_stay),
                  ],
                  if (!isMuslim && _bibleVerse != null) ...[
                    _sectionHeader('Daily Verse'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.coral.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          const Text('📖', style: TextStyle(fontSize: 36)),
                          const SizedBox(height: 16),
                          Text(
                            _bibleVerse!['text'] ?? '',
                            style: TextStyle(fontSize: 16, height: 1.6, color: AppTheme.darkText, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '— ${_bibleVerse!['reference'] ?? ''}',
                            style: TextStyle(fontSize: 14, color: AppTheme.warmGold, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (_loading == false)
                    Center(
                      child: TextButton(
                        onPressed: _fetchData,
                        child: Text('Refresh', style: TextStyle(color: AppTheme.lightText, fontSize: 13)),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _sectionHeader(String text) {
    return Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget _prayerCard(String name, String time, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.sageGreen, size: 22),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.sageGreen)),
      ),
    );
  }
}