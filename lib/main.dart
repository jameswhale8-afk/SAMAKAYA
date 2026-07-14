import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme.dart';
import 'features/auth/presentation/auth_screen.dart';
import 'modern_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ztrakkilzrjolxgxayzu.supabase.co',
    anonKey: 'sb_publishable_tH-9cebXQxvcI38XxvbYJg_aq9SZpmn',
  );

  runApp(const KayaKitaApp());
}

class KayaKitaApp extends StatelessWidget {
  const KayaKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kayakita',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.session != null) {
          return const ModernDashboard();
        }
        return const AuthScreen();
      },
    );
  }
}