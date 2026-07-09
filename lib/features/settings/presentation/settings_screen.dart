import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/app_core.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool lightMode = AppCore().lightweightMode;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), backgroundColor: const Color(0xFFD4A017)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("DISPLAY", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Easier on eyes at night"),
            value: darkMode, activeColor: const Color(0xFFD4A017),
            onChanged: (v) => setState(() => darkMode = v),
          ),
          const SizedBox(height: 16),
          const Text("DATA & STORAGE", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text("🪶 Lightweight Mode"),
            subtitle: const Text("Saves data. Reduces image quality, disables animations, compresses shared photos. Best for limited data plans or slow internet."),
            value: lightMode, activeColor: const Color(0xFFD4A017),
            onChanged: (v) {
              setState(() => lightMode = v);
              AppCore().toggleLightweight();
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text("Clear Cache"),
            subtitle: const Text("Free up storage space. Your points and data are safe."),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cache cleared!"))),
          ),
          ListTile(
            title: const Text("App Size: 12 MB"),
            subtitle: const Text("Optimized for low-storage phones"),
            trailing: const Icon(Icons.info_outline, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text("NOTIFICATIONS", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text("Push Notifications"),
            subtitle: const Text("Daily check-in, scam alerts, watch parties"),
            value: notifications, activeColor: const Color(0xFFD4A017),
            onChanged: (v) => setState(() => notifications = v),
          ),
          const SizedBox(height: 16),
          const Text("ACCOUNT", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          ListTile(
            title: const Text("Language"),
            subtitle: const Text("English · Tagalog · Bahasa Indonesia"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Delete Account"),
            subtitle: const Text("Permanently remove your data"),
            trailing: const Icon(Icons.chevron_right, color: Colors.red),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Center(
            child: Text("KAYA KITA v1.0.0", style: TextStyle(color: Colors.grey[300], fontSize: 12)),
          ),
        ],
      ),
    );
  }
}