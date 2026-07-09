import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme.dart';
import '../../core/localization.dart';
import '../remittance/presentation/remittance_screen.dart';
import '../translation/presentation/translation_screen.dart';
import '../sports/presentation/sports_screen.dart';
import '../map/presentation/map_screen.dart';
import '../scam_shield/presentation/scam_shield_screen.dart';
import '../wishlist/presentation/wishlist_screen.dart';
import '../badge/presentation/badge_widget.dart';
import '../referral/presentation/referral_screen.dart';
import '../bedspace/presentation/bedspace_screen.dart';
import 'daily_claim_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _tokenBalance = 0;
  int _streak = 0;
  bool _isFounder = false;
  bool _showClaimDialog = false;
  String _userName = '';

  final List<Widget> _pages = [
    const _DashboardPage(),
    const _SendPage(),
    const _CommunityPage(),
    const _ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _checkDailyClaim();
  }

  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final response = await Supabase.instance.client
          .from('profiles')
          .select('display_name, token_balance, streak, is_founder')
          .eq('id', user.id)
          .single();
      setState(() {
        _tokenBalance = response['token_balance'] ?? 0;
        _streak = response['streak'] ?? 0;
        _isFounder = response['is_founder'] ?? false;
        _userName = response['display_name'] ?? '';
      });
    }
  }

  Future<void> _checkDailyClaim() async {
    final prefs = await SharedPreferences.getInstance();
    final lastClaim = prefs.getString('last_claim_date');
    final today = DateTime.now().toIso8601String().split('T')[0];
    if (lastClaim != today) {
      setState(() => _showClaimDialog = true);
    }
  }

  Future<void> _claimDaily() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    await prefs.setString('last_claim_date', today);

    // Update streak and tokens
    await Supabase.instance.client.rpc('claim_daily', params: {
      'p_user_id': user.id,
    });

    // Record timestamp for legal ledger
    await Supabase.instance.client.from('daily_claims').insert({
      'user_id': user.id,
      'claimed_at': DateTime.now().toIso8601String(),
      'timezone_offset': DateTime.now().timeZoneOffset.inMinutes.toString(),
    });

    await _loadUserData();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocalizationService.get('daily_claim_success')),
          backgroundColor: AppTheme.sageGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (_showClaimDialog)
            DailyClaimDialog(
              onClaim: () {
                _claimDaily();
                setState(() => _showClaimDialog = false);
              },
              onDismiss: () => setState(() => _showClaimDialog = false),
              streak: _streak,
              isFounder: _isFounder,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_outlined),
            activeIcon: Icon(Icons.send),
            label: 'Send',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            activeIcon: Icon(Icons.groups),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Token balance bar
            _buildTokenBar(context),
            const SizedBox(height: 20),
            // Quick actions grid
            _buildQuickActions(context),
            const SizedBox(height: 20),
            // Genesis badge section
            _buildGenesisSection(context),
            const SizedBox(height: 20),
            // Referral section
            _buildReferralSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenBar(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.deepSage,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.monetization_on, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Tokens',
                  style: TextStyle(color: AppTheme.lightText, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '1,250',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepSage,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '🔥 7-day streak',
              style: TextStyle(color: AppTheme.coral, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _ActionItem(Icons.send, 'Send Money', AppTheme.sageGreen, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const RemittanceScreen()));
      }),
      _ActionItem(Icons.translate, 'Translation', AppTheme.coral, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TranslationScreen()));
      }),
      _ActionItem(Icons.sports_volleyball, 'Sports League', AppTheme.deepSage, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SportsScreen()));
      }),
      _ActionItem(Icons.store, 'Toko Map', AppTheme.warmGold, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()));
      }),
      _ActionItem(Icons.shield, 'Scam Shield', AppTheme.coral, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ScamShieldScreen()));
      }),
      _ActionItem(Icons.workspace_premium, 'Wishlist', AppTheme.sageGreen, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen()));
      }),
      _ActionItem(Icons.bed, 'Bedspace Guide', AppTheme.warmGold, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const BedspaceScreen()));
      }),
      _ActionItem(Icons.photo_camera, 'Glamour Studio', AppTheme.coral, () {
        // Open PWA in browser
      }),
      _ActionItem(Icons.gavel, 'Safety Center', AppTheme.deepSage, () {
        // Open PWA in browser
      }),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'My Sister',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.deepSage,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return _ActionCard(
              icon: action.icon,
              label: action.label,
              color: action.color,
              onTap: action.onTap,
            );
          },
        ),
      ],
    );
  }

  Widget _buildGenesisSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.warmGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('🔱', style: TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Genesis Drop',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.deepSage,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Only 8,247 of 10,000 spots remaining!',
                    style: TextStyle(color: AppTheme.coral, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.coral,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Claim',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralSection(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.coral.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.people, color: AppTheme.coral),
        ),
        title: Text('Refer a Sister', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Earn 2,000 tokens per referral'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferralScreen()));
        },
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  _ActionItem(this.icon, this.label, this.color, this.onTap);
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendPage extends StatelessWidget {
  const _SendPage();

  @override
  Widget build(BuildContext context) {
    return const RemittanceScreen();
  }
}

class _CommunityPage extends StatelessWidget {
  const _CommunityPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Community',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Sports league card
            _communityCard(
              context,
              icon: Icons.sports_volleyball,
              title: 'Sunday Sports League',
              subtitle: 'Volleyball · Badminton · Dance · Hiking',
              color: AppTheme.sageGreen,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SportsScreen())),
            ),
            const SizedBox(height: 12),
            // Toko map card
            _communityCard(
              context,
              icon: Icons.store,
              title: 'Toko & Sari-Sari Map',
              subtitle: 'Find grocers, eateries, and rest zones',
              color: AppTheme.warmGold,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen())),
            ),
            const SizedBox(height: 12),
            // Wishlist card
            _communityCard(
              context,
              icon: Icons.workspace_premium,
              title: 'Community Wishlist',
              subtitle: 'Vote on deals with your tokens',
              color: AppTheme.coral,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _communityCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Avatar placeholder
            CircleAvatar(
              radius: 48,
              backgroundColor: AppTheme.deepSage,
              child: Text(
                'S',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sister',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepSage,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.warmGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '🔱 Founder',
                style: TextStyle(color: AppTheme.warmGold, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 32),
            // Settings items
            _settingsItem(Icons.language, 'Language', () {}),
            _settingsItem(Icons.badge, 'My Badges', () {}),
            _settingsItem(Icons.share, 'Referral Link', () {}),
            _settingsItem(Icons.help, 'Help & FAQ', () {}),
            _settingsItem(Icons.info, 'About KayaKita', () {}),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem(IconData icon, String label, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppTheme.sageGreen),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}