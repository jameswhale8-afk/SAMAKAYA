import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final pages = [
    _Page("🥭", "Welcome to KAYA KITA!", "The first app built for overseas workers, by overseas workers. Everything here is free — forever.", const Color(0xFFD4A017)),
    _Page("👑", "Become a Queen", "Pageant Studio turns your selfie into a stunning portrait. Share with friends and watch them join.", AppTheme.coral),
    _Page("💰", "Send Money for Less", "Compare Wise, Remitly, and more. We find you the cheapest rate to send home.", const Color(0xFF2D5A3D)),
    _Page("🛡️", "Know Your Rights", "Check your salary, track your food allowance, and stay safe with scam alerts.", Colors.red[700]!),
    _Page("🌍", "Find Your Sisters", "Join groups, share recipes, watch K-dramas, play sports. Your community is waiting.", const Color(0xFF40E0D0)),
    _Page("🎯", "Claim Your Founder Badge", "First 10,000 users get a permanent Founder badge. Never repeated. Claim yours now!", const Color(0xFFD4A017)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(pages[i].emoji, style: const TextStyle(fontSize: 80)),
                      const SizedBox(height: 24),
                      Text(pages[i].title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: pages[i].color), textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      Text(pages[i].desc, style: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.5), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _page == i ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _page == i ? pages[i].color : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              )),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_page < pages.length - 1) {
                      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    } else {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pages[_page].color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(_page < pages.length - 1 ? "Next" : "Start KAYA KITA! 🥭"),
                ),
              ),
            ),
            if (_page < pages.length - 1)
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: const Text("Skip", style: TextStyle(color: Colors.grey)),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _Page {
  final String emoji, title, desc;
  final Color color;
  _Page(this.emoji, this.title, this.desc, this.color);
}