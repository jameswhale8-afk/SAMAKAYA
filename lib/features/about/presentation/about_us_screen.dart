import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key, this.showContinue = true});

  final bool showContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Founders image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/founders.jpeg',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 28),

              // Title
              const Text(
                "Made for us. By us.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD4A017),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),

              // Story
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "We're Evangeline & Dewi — overseas workers for 10+ years from Philippines and Indonesia. We volunteer on weekends and wanted something bigger to help.",
                      style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF333333)),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "By joining KayaKita, together we can get deals, discounts, and savings they will never give us alone.",
                      style: TextStyle(fontSize: 15, height: 1.6, fontWeight: FontWeight.w600, color: Color(0xFF2D5A3D)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Mission
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D5A3D).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF2D5A3D).withOpacity(0.15)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🤝', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Our Promise',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D5A3D)),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'KAYA KITA is free always. As foreign overseas workers, we cannot earn money from KayaKita, we just want to help... The bigger we grow together the more we can help each other...',
                            style: TextStyle(fontSize: 13, height: 1.5, color: AppTheme.lightText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              if (showContinue)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const _SignUpChoice()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D5A3D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Join us', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Temporary sign-up choice screen (placeholder that navigates to dashboard)
class _SignUpChoice extends StatelessWidget {
  const _SignUpChoice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🥭', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              const Text(
                "Join your sisters",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const _TempDashboard()),
                  ),
                  icon: const Text('G', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4285F4))),
                  label: const Text('Sign up with Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const _TempDashboard()),
                  ),
                  icon: const Text('f', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1877F2))),
                  label: const Text('Sign up with Facebook'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const _TempDashboard()),
                ),
                child: const Text('Skip (Test Mode)', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TempDashboard extends StatelessWidget {
  const _TempDashboard();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Dashboard placeholder - auth working')),
    );
  }
}