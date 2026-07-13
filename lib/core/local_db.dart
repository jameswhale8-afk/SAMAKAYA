import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Local storage for all on-device data.
/// No backend needed for personal features (savings, wellness, watchlist, etc.)
class LocalDB {
  static Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  // --- SAVINGS GOALS ---
  static Future<List<Map<String, dynamic>>> getSavingsGoals() async {
    final p = await _prefs;
    final data = p.getString('savings_goals');
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> saveSavingsGoal(Map<String, dynamic> goal) async {
    final goals = await getSavingsGoals();
    goals.add(goal);
    final p = await _prefs;
    await p.setString('savings_goals', jsonEncode(goals));
  }

  static Future<void> updateSavingsGoal(int index, Map<String, dynamic> goal) async {
    final goals = await getSavingsGoals();
    if (index < goals.length) {
      goals[index] = goal;
      final p = await _prefs;
      await p.setString('savings_goals', jsonEncode(goals));
    }
  }

  // --- WELLNESS LOGS ---
  static Future<List<Map<String, dynamic>>> getWellnessLogs() async {
    final p = await _prefs;
    final data = p.getString('wellness_logs');
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> saveWellnessLog(Map<String, dynamic> log) async {
    final logs = await getWellnessLogs();
    logs.add(log);
    final p = await _prefs;
    await p.setString('wellness_logs', jsonEncode(logs));
  }

  // --- MEDICATION REMINDERS ---
  static Future<List<Map<String, dynamic>>> getMedications() async {
    final p = await _prefs;
    final data = p.getString('medications');
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> saveMedication(Map<String, dynamic> med) async {
    final meds = await getMedications();
    meds.add(med);
    final p = await _prefs;
    await p.setString('medications', jsonEncode(meds));
  }

  static Future<void> deleteMedication(int index) async {
    final meds = await getMedications();
    if (index < meds.length) {
      meds.removeAt(index);
      final p = await _prefs;
      await p.setString('medications', jsonEncode(meds));
    }
  }

  // --- K-DRAMA WATCHLIST ---
  static Future<List<Map<String, dynamic>>> getWatchlist() async {
    final p = await _prefs;
    final data = p.getString('watchlist');
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> saveToWatchlist(Map<String, dynamic> item) async {
    final list = await getWatchlist();
    list.add(item);
    final p = await _prefs;
    await p.setString('watchlist', jsonEncode(list));
  }

  static Future<void> updateWatchlist(int index, Map<String, dynamic> item) async {
    final list = await getWatchlist();
    if (index < list.length) {
      list[index] = item;
      final p = await _prefs;
      await p.setString('watchlist', jsonEncode(list));
    }
  }

  // --- TOKENS ---
  static Future<int> getTokens() async {
    final p = await _prefs;
    return p.getInt('tokens') ?? 0;
  }

  static Future<void> addTokens(int amount) async {
    final p = await _prefs;
    final current = p.getInt('tokens') ?? 0;
    await p.setInt('tokens', current + amount);
  }

  // --- DAILY STREAK ---
  static Future<int> getStreak() async {
    final p = await _prefs;
    return p.getInt('streak') ?? 0;
  }

  static Future<String?> getLastClaimDate() async {
    final p = await _prefs;
    return p.getString('last_claim_date');
  }

  static Future<bool> claimDaily() async {
    final p = await _prefs;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final last = p.getString('last_claim_date');

    if (last == today) return false; // Already claimed today

    int streak = p.getInt('streak') ?? 0;
    final yesterday = DateTime.now().subtract(const Duration(days: 1)).toIso8601String().substring(0, 10);

    if (last == yesterday) {
      streak += 1; // Consecutive day
    } else {
      streak = 1; // Reset streak
    }

    await p.setInt('streak', streak);
    await p.setString('last_claim_date', today);
    await addTokens(100);
    return true;
  }

  // --- REFERRAL CODE ---
  static Future<String> getReferralCode() async {
    final p = await _prefs;
    String? code = p.getString('referral_code');
    if (code == null) {
      code = 'KAYA${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      await p.setString('referral_code', code);
    }
    return code;
  }

  // --- SETTINGS ---
  static Future<bool> getLightweightMode() async {
    final p = await _prefs;
    return p.getBool('lightweight_mode') ?? false;
  }

  static Future<void> setLightweightMode(bool value) async {
    final p = await _prefs;
    await p.setBool('lightweight_mode', value);
  }
}