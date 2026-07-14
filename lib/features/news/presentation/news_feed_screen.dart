import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../core/theme.dart';
import '../../../core/local_db.dart';

class NewsFeedScreen extends StatefulWidget {
  final String country; // 'PH' or 'ID'
  final String province;
  final String hostCountry;

  const NewsFeedScreen({
    super.key,
    required this.country,
    required this.province,
    required this.hostCountry,
  });

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<Map<String, String>> _articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    setState(() => _loading = true);
    final all = <Map<String, String>>[];

    // PH national feeds
    if (widget.country == 'PH') {
      all.addAll(await _fetchFeed('https://news.abs-cbn.com/feed', 'ABS-CBN', '🇵🇭 National'));
      all.addAll(await _fetchFeed('https://www.gmanetwork.com/news/rss/', 'GMA News', '🇵🇭 National'));
      all.addAll(await _fetchFeed('https://www.rappler.com/feed/', 'Rappler', '🇵🇭 National'));
    }

    // ID national feeds
    if (widget.country == 'ID') {
      all.addAll(await _fetchFeed('https://www.kompas.com/rss/', 'Kompas', '🇮🇩 National'));
      all.addAll(await _fetchFeed('https://www.detik.com/rss/', 'Detik', '🇮🇩 National'));
      all.addAll(await _fetchFeed('https://www.cnnindonesia.com/rss/', 'CNN Indonesia', '🇮🇩 National'));
    }

    // Host country helper news (search for helper-related articles)
    all.addAll(await _fetchFeed(
      'https://www.scmp.com/rss/91/feed',
      'SCMP',
      '🇭🇰 Hong Kong',
    ));

    setState(() {
      _articles = all;
      _loading = false;
    });
  }

  Future<List<Map<String, String>>> _fetchFeed(String url, String source, String tag) async {
    try {
      final res = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (res.statusCode != 200) return [];
      final body = res.body;
      final titles = _extractAll(body, '<title>', '</title>');
      final links = _extractAll(body, '<link>', '</link>');
      final descs = _extractAll(body, '<description>', '</description>');
      final results = <Map<String, String>>[];
      for (int i = 1; i < titles.length && results.length < 5; i++) {
        if (titles[i].isNotEmpty && !titles[i].contains('RSS') && !titles[i].contains('Feed')) {
          results.add({
            'title': titles[i].trim(),
            'source': source,
            'tag': tag,
            'url': links.length > i ? links[i].trim() : '',
            'desc': descs.length > i ? descs[i].trim() : '',
          });
        }
      }
      return results;
    } catch (_) {
      return [];
    }
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
        title: Text(
          widget.country == 'PH' ? 'Balita' : 'Berita',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.darkText,
        actions: [
          IconButton(icon: const Icon(Icons.refresh, size: 20), onPressed: _fetchAll),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchAll,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _articles.length,
                itemBuilder: (context, i) {
                  final a = _articles[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _showArticle(context, a),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppTheme.sageGreen.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    a['tag'] ?? '',
                                    style: TextStyle(fontSize: 10, color: AppTheme.sageGreen, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  a['source'] ?? '',
                                  style: TextStyle(fontSize: 10, color: AppTheme.lightText),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              a['title'] ?? '',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if ((a['desc'] ?? '').isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                a['desc']!,
                                style: TextStyle(fontSize: 12, color: AppTheme.lightText, height: 1.4),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showArticle(BuildContext context, Map<String, String> article) {
    final url = article['url'] ?? '';
    if (url.isEmpty) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollController) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  article['title'] ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['desc'] ?? '',
                        style: TextStyle(fontSize: 14, height: 1.7, color: AppTheme.darkText),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Open in external browser
                          },
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Read full article'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}