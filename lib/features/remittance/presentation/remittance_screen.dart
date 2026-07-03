import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';

class RemittanceScreen extends StatelessWidget {
  const RemittanceScreen({super.key});

  Future<void> _launchPartner(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compare rates and send money to your family',
                      style: TextStyle(color: AppTheme.lightText, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Earn 200 bonus tokens per transaction',
                      style: TextStyle(
                        color: AppTheme.coral,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Wise option
            _PartnerCard(
              name: 'Wise',
              description: 'Real exchange rate. Low fees. Fast transfer.',
              fee: 'HK$12',
              rate: '1 HKD = 7.12 PHP',
              color: const Color(0xFF00D9B5),
              onTap: () => _launchPartner('https://wise.com/invite/u/jameswhale8'),
            ),
            const SizedBox(height: 12),
            // Remitly option
            _PartnerCard(
              name: 'Remitly',
              description: 'First transfer free. Promo rates available.',
              fee: 'HK$8',
              rate: '1 HKD = 7.20 PHP',
              color: const Color(0xFF1499DA),
              onTap: () => _launchPartner('https://remitly.com'),
            ),
            const SizedBox(height: 12),
            // TNG option
            _PartnerCard(
              name: 'TNG Wallet',
              description: 'Popular with helpers. Cash pickup available.',
              fee: 'HK$18',
              rate: '1 HKD = 7.05 PHP',
              color: const Color(0xFF00A36C),
              onTap: () => _launchPartner('https://tngwallet.com'),
            ),
            const Spacer(),
            // Token bonus info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.monetization_on, color: AppTheme.warmGold, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Send HK$4,000 or more and earn 200 bonus tokens automatically',
                        style: TextStyle(fontSize: 13, color: AppTheme.lightText),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  final String name;
  final String description;
  final String fee;
  final String rate;
  final Color color;
  final VoidCallback onTap;

  const _PartnerCard({
    required this.name,
    required this.description,
    required this.fee,
    required this.rate,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        color: AppTheme.lightText,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Fee: $fee',
                          style: TextStyle(
                            color: AppTheme.sageGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          rate,
                          style: TextStyle(
                            color: AppTheme.darkText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppTheme.lightText),
            ],
          ),
        ),
      ),
    );
  }
}