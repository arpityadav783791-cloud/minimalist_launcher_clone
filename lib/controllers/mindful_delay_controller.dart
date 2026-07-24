import 'package:get/get.dart';

import '../models/mindful_delay_rule.dart';
import '../services/mindful_delay_storage.dart';

class MindfulDelayController extends GetxController {
  /// packageName -> Rule
  final RxMap<String, MindfulDelayRule> rules =
      <String, MindfulDelayRule>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadRules();
  }

  Future<void> loadRules() async {
    final loaded = await MindfulDelayStorage.loadRules();

    rules.assignAll(loaded);

    _applyScheduledDisables();
  }

  Future<void> _save() async {
    await MindfulDelayStorage.saveRules(rules);
  }

  /// Returns rule for an app if it exists
  MindfulDelayRule? getRule(String packageName) {
    return rules[packageName];
  }

  /// True if this app should show mindful delay
  bool shouldShowDelay(String packageName) {
    final rule = rules[packageName];

    if (rule == null) return false;

    if (!rule.enabled) return false;

    if (rule.shouldDisableNow) {
      disableImmediately(packageName);
      return false;
    }

    return true;
  }

  /// Create or update delay
  Future<void> setDelay({
    required String packageName,
    required int delaySeconds,
  }) async {
    final existing = rules[packageName];

    if (existing != null) {
      existing.enabled = true;
      existing.delaySeconds = delaySeconds;
      existing.scheduledDisableAt = null;
    } else {
      rules[packageName] = MindfulDelayRule(
        packageName: packageName,
        enabled: true,
        delaySeconds: delaySeconds,
      );
    }

    rules.refresh();

    await _save();
  }

  /// Schedule disable after 48 hours
  Future<void> scheduleDisable(
    String packageName,
  ) async {
    final rule = rules[packageName];

    if (rule == null) return;

    rule.scheduledDisableAt =
        DateTime.now().add(const Duration(hours: 48));

    rules.refresh();

    await _save();
  }

  /// Cancel scheduled disable
  Future<void> cancelScheduledDisable(
    String packageName,
  ) async {
    final rule = rules[packageName];

    if (rule == null) return;

    rule.scheduledDisableAt = null;

    rules.refresh();

    await _save();
  }

  /// Disable immediately
  Future<void> disableImmediately(
    String packageName,
  ) async {
    final rule = rules[packageName];

    if (rule == null) return;

    rule.enabled = false;
    rule.scheduledDisableAt = null;

    rules.refresh();

    await _save();
  }

  /// Enable again
  Future<void> enable(
    String packageName,
  ) async {
    final rule = rules[packageName];

    if (rule == null) return;

    rule.enabled = true;
    rule.scheduledDisableAt = null;

    rules.refresh();

    await _save();
  }

  /// Remove expired scheduled disables
  Future<void> _applyScheduledDisables() async {
    bool changed = false;

    for (final rule in rules.values) {
      if (rule.shouldDisableNow) {
        rule.enabled = false;
        rule.scheduledDisableAt = null;
        changed = true;
      }
    }

    if (changed) {
      rules.refresh();
      await _save();
    }
  }
}