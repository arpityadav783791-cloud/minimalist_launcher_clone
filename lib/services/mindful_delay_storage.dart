import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/mindful_delay_rule.dart';

class MindfulDelayStorage {
  static const String _storageKey = 'mindful_delay_rules';

  /// Load all saved rules
  static Future<Map<String, MindfulDelayRule>> loadRules() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString(_storageKey);

    if (raw == null || raw.isEmpty) {
      return {};
    }

    final decoded = jsonDecode(raw) as Map<String, dynamic>;

    return decoded.map(
      (key, value) => MapEntry(
        key,
        MindfulDelayRule.fromJson(
          Map<String, dynamic>.from(value),
        ),
      ),
    );
  }

  /// Save all rules
  static Future<void> saveRules(
    Map<String, MindfulDelayRule> rules,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final json = rules.map(
      (key, value) => MapEntry(
        key,
        value.toJson(),
      ),
    );

    await prefs.setString(
      _storageKey,
      jsonEncode(json),
    );
  }

  /// Remove every rule
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_storageKey);
  }
}