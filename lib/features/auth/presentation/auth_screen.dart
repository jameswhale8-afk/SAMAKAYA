import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme.dart';
import '../../../core/localization.dart';
import '../../../modern_dashboard.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _step = 0; // 0 = flags, 1 = sign-up, 2 = email form
  String _selectedLang = 'en';
  String _selectedLocation = 'HK';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  final List<_Location> _locations = [
    _Location('HK', 'Hong Kong', '🇭🇰'),
    _Location('MO', 'Macao', '🇲🇴'),
    _Location('SG', 'Singapore', '🇸🇬'),
    _Location('TW', 'Taiwan', '🇹🇼'),
    _Location('AE', 'UAE', '🇦🇪'),
    _Location('SA', 'Saudi Arabia', '🇸🇦'),
  ];

  final List<_Language> _languages = [
    _Language('en', 'English', '🇺🇸'),
    _Language('tl', 'Tagalog', '🇵🇭'),
    _Language('id', 'Bahasa Indonesia', '🇮🇩'),
  ];

  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://ztrakkilzrjolxgxayzu.supabase.co/auth/v1/callback',
      );
      await LocalizationService.load(_selectedLang);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ModernDashboard()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not sign in: $e')),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _signInWithFacebook() async {
    setState(() => _loading = true);
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'https://ztrakkilzrjolxgxayzu.supabase.co/auth/v1/callback',
      );
      await LocalizationService.load(_selectedLang);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ModernDashboard()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not sign in: $e')),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _signInWithEmail() async {
    setState(() => _loading = true);
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Please fill in email and password');
      }
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      await LocalizationService.load(_selectedLang);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ModernDashboard()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${LocalizationService.get('error')}: $e')),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppTheme.deepSage,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                  child: Text(
                    'K',
                    style: TextStyle(
                      color: Color(0xFFD4A017),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "kayakita",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD4A017),
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'For overseas workers, by overseas workers',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.lightText,
                ),
              ),
              const Spacer(flex: 2),

              // Step 0: Flags for language + location
              if (_step == 0) ...[
                Text(
                  'Where are you?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.darkText),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: _locations.map((loc) {
                    final selected = _selectedLocation == loc.code;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedLocation = loc.code),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: selected ? AppTheme.sageGreen.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected ? AppTheme.sageGreen : const Color(0xFFE8E8E8),
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(loc.flag, style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 10),
                            Text(
                              loc.name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                                color: selected ? AppTheme.sageGreen : const Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your language?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.darkText),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _languages.map((lang) {
                    final selected = _selectedLang == lang.code;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedLang = lang.code),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            color: selected ? AppTheme.coral.withOpacity(0.1) : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected ? AppTheme.coral : const Color(0xFFE8E8E8),
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(lang.flag, style: const TextStyle(fontSize: 22)),
                              const SizedBox(width: 8),
                              Text(
                                lang.name,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                                  color: selected ? AppTheme.coral : const Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _step = 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.sageGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],

              // Step 1: Sign-up options
              if (_step == 1) ...[
                Text(
                  'Join your sisters',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.darkText),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _loading ? null : _signInWithGoogle,
                    icon: const Text('G', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4285F4))),
                    label: Text('Sign up with Google', style: TextStyle(color: AppTheme.darkText)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      side: const BorderSide(color: Color(0xFFE8E8E8)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _loading ? null : _signInWithFacebook,
                    icon: const Text('f', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1877F2))),
                    label: Text('Sign up with Facebook', style: TextStyle(color: AppTheme.darkText)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      side: const BorderSide(color: Color(0xFFE8E8E8)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFFE8E8E8))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('or', style: TextStyle(color: AppTheme.lightText, fontSize: 13)),
                    ),
                    const Expanded(child: Divider(color: Color(0xFFE8E8E8))),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => setState(() => _step = 2),
                  child: Text(
                    'Sign up with email',
                    style: TextStyle(color: AppTheme.lightText, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ModernDashboard()),
                    );
                  },
                  child: Text(
                    'Skip (Test Mode)',
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  ),
                ),
              ],

              // Step 2: Email sign-up form
              if (_step == 2) ...[
                Text(
                  'Sign up with email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.darkText),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'your.email@example.com',
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'At least 6 characters',
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _signInWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.sageGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: _loading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Create account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => setState(() => _step = 1),
                  child: Text('Back', style: TextStyle(color: AppTheme.lightText, fontSize: 13)),
                ),
              ],

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class _Location {
  final String code;
  final String name;
  final String flag;
  _Location(this.code, this.name, this.flag);
}

class _Language {
  final String code;
  final String name;
  final String flag;
  _Language(this.code, this.name, this.flag);
}