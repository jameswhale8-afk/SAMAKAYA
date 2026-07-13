import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'core/modern_buttons.dart';

/// KAYA KITA Modern Dashboard
/// CupertinoIcons (Apple SF Symbols) — clean, thin line icons, zero emojis.
class ModernDashboard extends StatelessWidget {
  const ModernDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "kayakita",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFD4A017),
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.gear, color: Color(0xFF999999), size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel("Discover"),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ModernFeatureButton(icon: CupertinoIcons.star_fill, label: "Pageant", brandColor: AppTheme.coral),
                  ModernFeatureButton(icon: CupertinoIcons.hand_draw, label: "Claim", brandColor: AppTheme.warmGold),
                  ModernFeatureButton(icon: CupertinoIcons.money_dollar, label: "Send", brandColor: AppTheme.sageGreen),
                  ModernFeatureButton(icon: CupertinoIcons.shield_fill, label: "Safety", brandColor: AppTheme.deepSage),
                ],
              ),
              const SizedBox(height: 28),

              _sectionLabel("Explore"),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ModernFeatureButton(icon: CupertinoIcons.person_3_fill, label: "Groups", brandColor: AppTheme.coral),
                  ModernFeatureButton(icon: CupertinoIcons.cart_fill, label: "Eats", brandColor: AppTheme.warmGold),
                  ModernFeatureButton(icon: CupertinoIcons.wifi, label: "Data", brandColor: AppTheme.sageGreen),
                  ModernFeatureButton(icon: CupertinoIcons.play_circle_fill, label: "Dramas", brandColor: AppTheme.coral),
                ],
              ),
              const SizedBox(height: 28),

              _sectionLabel("Your Routine"),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ModernFeatureButton(icon: CupertinoIcons.heart_fill, label: "Wellness", brandColor: AppTheme.sageGreen),
                  ModernFeatureButton(icon: CupertinoIcons.chart_pie_fill, label: "Savings", brandColor: AppTheme.warmGold),
                  ModernFeatureButton(icon: CupertinoIcons.clock_fill, label: "Home Time", brandColor: AppTheme.deepSage),
                  ModernFeatureButton(icon: CupertinoIcons.sun_max_fill, label: "Faith", brandColor: AppTheme.coral),
                ],
              ),
              const SizedBox(height: 32),

              _sectionLabel("Partner Deals"),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ModernSmallButton(icon: CupertinoIcons.airplane, label: "Flights", brandColor: AppTheme.warmGold),
                  ModernSmallButton(icon: CupertinoIcons.umbrella_fill, label: "Insure", brandColor: AppTheme.sageGreen),
                  ModernSmallButton(icon: CupertinoIcons.square_grid_2x2, label: "Box", brandColor: AppTheme.coral),
                  ModernSmallButton(icon: CupertinoIcons.capsule_fill, label: "Pharmacy", brandColor: AppTheme.sageGreen),
                ],
              ),
              const SizedBox(height: 40),

              // Genesis counter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.warmGold.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.warmGold.withOpacity(0.15), width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Founder badges remaining",
                            style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "8,247 / 10,000",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.warmGold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(CupertinoIcons.flag_fill, color: AppTheme.warmGold, size: 32),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFFBBBBBB),
        letterSpacing: 1,
      ),
    );
  }
}