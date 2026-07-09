import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/theme.dart';
import '../../core/localization.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  bool _loading = false;
  String _selectedLang = 'en';

  Future<void> _sendOtp() async {
    setState(() => _loading = true);
    try {
      // Use phone auth with HK prefix
      String phone = _phoneController.text.trim();
      if (!phone.startsWith('+')) {
        phone = '+852$phone';
      }
      await Supabase.instance.client.auth.signInWithOtp(phone: phone);
      setState(() => _otpSent = true);
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

  Future<void> _verifyOtp() async {
    setState(() => _loading = true);
    try {
      String phone = _phoneController.text.trim();
      if (!phone.startsWith('+')) {
        phone = '+852$phone';
      }
      await Supabase.instance.client.auth.verifyOTP(
        phone: phone,
        token: _otpController.text.trim(),
        type: OtpType.sms,
      );
      await LocalizationService.load(_selectedLang);
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
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                // App logo area
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.deepSage,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'K',
                      style: TextStyle(
                        color: AppTheme.coral,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'KayaKita',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepSage,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'My Sister',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.coral,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 48),
                // Language selector
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'en', label: Text('EN')),
                    ButtonSegment(value: 'id', label: Text('ID')),
                    ButtonSegment(value: 'tl', label: Text('TL')),
                  ],
                  selected: {_selectedLang},
                  onSelectionChanged: (val) {
                    setState(() => _selectedLang = val.first);
                  },
                ),
                const SizedBox(height: 32),
                if (!_otpSent) ...[
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '+852 1234 5678',
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _sendOtp,
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text('Send OTP'),
                    ),
                  ),
                ] else ...[
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      hintText: '6-digit code',
                      prefixIcon: const Icon(Icons.sms),
                    ),
                    maxLength: 6,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _verifyOtp,
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text('Verify'),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                Text(
                  'First 10,000 get 🔱 Founder badge',
                  style: TextStyle(
                    color: AppTheme.lightText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}