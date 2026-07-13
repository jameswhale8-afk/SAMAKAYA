import 'package:flutter/material.dart';
import '../../../../../core/theme.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _categoryCard(Icons.restaurant, 'Culinary Phrases', 'Kitchen, ingredients, cooking instructions'),
          _categoryCard(Icons.home_repair_service, 'Appliance Help', 'Washing machine, AC, stove, water heater'),
          _categoryCard(Icons.health_and_safety, 'Emergency Phrases', 'Doctor, hospital, fire, police'),
          _categoryCard(Icons.meeting_room, 'Daily Conversation', 'Greetings, requests, schedules'),
        ],
      ),
    );
  }

  Widget _categoryCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.sageGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.sageGreen),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sports League')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _leagueCard('🏐', 'Volleyball League', '8 teams · Active', AppTheme.sageGreen),
            const SizedBox(height: 12),
            _leagueCard('🏸', 'Badminton Tournament', '16 players · Sign up open', AppTheme.coral),
            const SizedBox(height: 12),
            _leagueCard('💃', 'Dance Competition', '6 groups · This Sunday', AppTheme.warmGold),
            const SizedBox(height: 12),
            _leagueCard('🥾', 'Hiking Club', 'Sunday 7am · Peak Trail', AppTheme.deepSage),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create League'),
        backgroundColor: AppTheme.coral,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _leagueCard(String emoji, String title, String subtitle, Color color) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toko Map')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: AppTheme.lightText),
            SizedBox(height: 16),
            Text(
              'Map loading...',
              style: TextStyle(color: AppTheme.lightText, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Find Filipino and Indonesian shops near you',
              style: TextStyle(color: AppTheme.lightText, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ScamShieldScreen extends StatelessWidget {
  const ScamShieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scam Shield')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _alertCard(Icons.warning, 'Bank Card Rental Scam', 'Do NOT rent your bank account. Imprisonment up to 14 years.', Colors.red),
          const SizedBox(height: 12),
          _alertCard(Icons.phone_android, 'Loan Shark Apps', 'These apps steal your contacts and blackmail your employer.', Colors.orange),
          const SizedBox(height: 12),
          _alertCard(Icons.elderly, 'Senior Scam Check', 'Your employer being asked to wire money? Check it here.', AppTheme.deepSage),
          const SizedBox(height: 12),
          _alertCard(Icons.location_on, 'Raid Warning Map', 'Active enforcement areas this week.', AppTheme.coral),
        ],
      ),
    );
  }

  Widget _alertCard(IconData icon, String title, String description, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(color: AppTheme.lightText, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Wishlist')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'We\'ve reached 35,000 users!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'We can lock in ONE massive discount this week. Choose your prize:',
              style: TextStyle(color: AppTheme.lightText),
            ),
            const SizedBox(height: 24),
            _dealCard('📱', 'SmarTone 10GB Data', '40% off', 64, AppTheme.sageGreen),
            const SizedBox(height: 12),
            _dealCard('💸', 'Remittance Fee Waiver', 'Free send up to HK\$5,000', 36, AppTheme.coral),
            const SizedBox(height: 12),
            _dealCard('🏪', 'Toko Voucher', 'HK\$50 off at partner stores', 0, AppTheme.warmGold),
          ],
        ),
      ),
    );
  }

  Widget _dealCard(String emoji, String title, String deal, int percentage, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(deal, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (percentage > 0)
              Column(
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('of voters', style: TextStyle(fontSize: 11, color: AppTheme.lightText)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class BedspaceScreen extends StatelessWidget {
  const BedspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bedspace Guide')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tipCard(Icons.visibility_off, 'Privacy Dividers', 'Use tension rods and curtains to create private space without drilling.'),
          _tipCard(Icons.air, 'Ventilation Tips', 'Keep a small fan near the window. Use moisture absorber bags in corners.'),
          _tipCard(Icons.inventory_2, 'Under-Bed Storage', 'Use vacuum bags for clothes. Slide shallow containers underneath.'),
          _tipCard(Icons.dark_mode, 'Blackout Solutions', 'Layer a dark sheet behind your curtain. Sleep mask is essential.'),
          _tipCard(Icons.self_improvement, 'Mental Well-being', '5-minute daily check-in. Connect with peer support circles below.'),
        ],
      ),
    );
  }

  Widget _tipCard(IconData icon, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.sageGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.sageGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(color: AppTheme.lightText, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}