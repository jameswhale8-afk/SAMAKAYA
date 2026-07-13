import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/theme.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});
  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<Map<String, String>> _articles = [];
  bool _loading = true;

  final List<Map<String, String>> _feeds = [
    {'name': 'ABS-CBN', 'url': 'https://news.abs-cbn.com/feed', 'flag': '🇵🇭'},
    {'name': 'GMA News', 'url': 'https://www.gmanetwork.com/news/rss/', 'flag': '🇵🇭'},
    {'name': 'Rappler', 'url': 'https://www.rappler.com/feed/', 'flag': '🇵🇭'},
    {'name': 'Kompas', 'url': 'https://www.kompas.com/rss/', 'flag': '🇮🇩'},
    {'name': 'Detik', 'url': 'https://www.detik.com/rss/', 'flag': '🇮🇩'},
    {'name': 'CNN Indonesia', 'url': 'https://www.cnnindonesia.com/rss/', 'flag': '🇮🇩'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() => _loading = true);
    List<Map<String, String>> all = [];
    for (final feed in _feeds) {
      try {
        final res = await http.get(Uri.parse(feed['url']!)).timeout(const Duration(seconds: 5));
        if (res.statusCode == 200) {
          // Parse RSS XML — extract title and link
          final body = res.body;
          final titles = _extractAll(body, '<title>', '</title>');
          final links = _extractAll(body, '<link>', '</link>');
          for (int i = 0; i < titles.length && i < 5; i++) {
            if (titles[i].isNotEmpty && !titles[i].contains('RSS') && !titles[i].contains('Feed')) {
              all.add({
                'title': titles[i].trim(),
                'source': '${feed['flag']} ${feed['name']}',
                'url': links.length > i ? links[i].trim() : '',
              });
            }
          }
        }
      } catch (_) {}
    }
    all.shuffle();
    setState(() {
      _articles = all.take(20).toList();
      _loading = false;
    });
  }

  List<String> _extractAll(String xml, String open, String close) {
    final results = <String>[];
    int start = 0;
    while (true) {
      final o = xml.indexOf(open, start);
      if (o == -1) break;
      final c = xml.indexOf(close, o + open.length);
      if (c == -1) break;
      results.add(xml.substring(o + open.length, c));
      start = c + close.length;
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text('Home News', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: AppTheme.darkText,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: _fetchNews,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchNews,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _articles.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Latest from your home country',
                        style: TextStyle(fontSize: 13, color: AppTheme.lightText),
                      ),
                    );
                  }
                  final a = _articles[i - 1];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(14),
                      title: Text(a['title'] ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(a['source'] ?? '', style: TextStyle(fontSize: 11, color: AppTheme.lightText)),
                      ),
                      trailing: const Icon(Icons.chevron_right, size: 16, color: Color(0xFFCCCCCC)),
                      onTap: () {
                        final url = a['url'];
                        if (url != null && url.isNotEmpty) {
                          // Open in browser
                        }
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}