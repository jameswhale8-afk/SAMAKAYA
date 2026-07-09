import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final String _referralCode = 'SAMA${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Refer a Sister')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Stats card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statColumn('Your Referrals', '3', AppTheme.coral),
                    _statColumn('Tokens Earned', '6,000', AppTheme.warmGold),
                    _statColumn('Your Rank', '#12', AppTheme.sageGreen),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Referral code
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Your Referral Code',
                      style: TextStyle(color: AppTheme.lightText, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.deepSage.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.deepSage.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        _referralCode,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: AppTheme.deepSage,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _actionChip(Icons.share, 'Share', AppTheme.sageGreen, () {}),
                        const SizedBox(width: 12),
                        _actionChip(Icons.copy, 'Copy', AppTheme.coral, () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'How it works',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepSage,
              ),
            ),
            const SizedBox(height: 12),
            _stepRow('1', 'Share your code with a friend'),
            _stepRow('2', 'They download KayaKita and use your code'),
            _stepRow('3', 'You both earn 2,000 tokens each!'),
            const SizedBox(height: 24),
            // Leaderboard preview
            Text(
              'Weekly Leaderboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepSage,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  _leaderboardRow('👑', 'Maria', 47, 1),
                  _leaderboardRow('2', 'Siti', 32, 2),
                  _leaderboardRow('3', 'Rose', 28, 3),
                  _leaderboardRow('4', 'Lily', 21, 4),
                  _leaderboardRow('5', 'Grace', 18, 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: AppTheme.lightText, fontSize: 12),
        ),
      ],
    );
  }

  Widget _actionChip(IconData icon, String label, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _stepRow(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTheme.sageGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 14, color: AppTheme.darkText)),
        ],
      ),
    );
  }

  Widget _leaderboardRow(String rank, String name, int referrals, int position) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: position <= 3 ? AppTheme.warmGold.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
          child: Text(
            rank,
            style: TextStyle(
              fontSize: rank == '👑' ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.deepSage,
            ),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(
          '$referrals referrals',
          style: TextStyle(
            color: AppTheme.sageGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}