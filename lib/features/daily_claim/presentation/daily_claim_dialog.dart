import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/localization.dart';

class DailyClaimDialog extends StatelessWidget {
  final VoidCallback onClaim;
  final VoidCallback onDismiss;
  final int streak;
  final bool isFounder;

  const DailyClaimDialog({
    super.key,
    required this.onClaim,
    required this.onDismiss,
    required this.streak,
    required this.isFounder,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Maya bird mascot area
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.deepSage,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Bird emoji as placeholder for mascot
                    const Text('🐦', style: TextStyle(fontSize: 48)),
                    // Points box the mascot is "holding"
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.coral,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '+100',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  LocalizationService.get('daily_claim_greeting'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepSage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  LocalizationService.get('daily_claim_title'),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.lightText,
                  ),
                ),
              ),
              if (streak > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '🔥 $streak-day streak!',
                    style: TextStyle(
                      color: AppTheme.coral,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              // Claim button
              GestureDetector(
                onTap: onClaim,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.coral, AppTheme.deepSage],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Claim Your Points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              if (isFounder)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '🔱 Founder Bonus Active',
                    style: TextStyle(color: AppTheme.warmGold, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onDismiss,
                child: Text(
                  'I\'ll claim later',
                  style: TextStyle(color: AppTheme.lightText),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}