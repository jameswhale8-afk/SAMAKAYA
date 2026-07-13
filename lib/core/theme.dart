import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color sageGreen = Color(0xFF4A7C59);
  static const Color coral = Color(0xFFE07A5F);
  static const Color offWhite = Color(0xFFFDF8F5);
  static const Color deepSage = Color(0xFF2D5A3D);
  static const Color warmGold = Color(0xFFD4A373);
  static const Color darkText = Color(0xFF2C2C2C);
  static const Color lightText = Color(0xFF6B6B6B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: sageGreen,
        secondary: coral,
        surface: offWhite,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkText,
      ),
      scaffoldBackgroundColor: offWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: deepSage,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: coral,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: sageGreen.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: sageGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: deepSage,
        unselectedItemColor: lightText,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}