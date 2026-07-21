class ProductivitySettings {
  final bool mindfulDelay;
  final bool focusMode;
  final int delaySeconds;
  final int dailyLimitMinutes;
  final int todayUsageMinutes;
  final int streak;

  const ProductivitySettings({
    this.mindfulDelay = false,
    this.focusMode = false,
    this.delaySeconds = 5,
    this.dailyLimitMinutes = 0,
    this.todayUsageMinutes = 0,
    this.streak = 0,
  });

  ProductivitySettings copyWith({
    bool? mindfulDelay,
    bool? focusMode,
    int? delaySeconds,
    int? dailyLimitMinutes,
    int? todayUsageMinutes,
    int? streak,
  }) {
    return ProductivitySettings(
      mindfulDelay: mindfulDelay ?? this.mindfulDelay,
      focusMode: focusMode ?? this.focusMode,
      delaySeconds: delaySeconds ?? this.delaySeconds,
      dailyLimitMinutes: dailyLimitMinutes ?? this.dailyLimitMinutes,
      todayUsageMinutes: todayUsageMinutes ?? this.todayUsageMinutes,
      streak: streak ?? this.streak,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mindfulDelay': mindfulDelay,
      'focusMode': focusMode,
      'delaySeconds': delaySeconds,
      'dailyLimitMinutes': dailyLimitMinutes,
      'todayUsageMinutes': todayUsageMinutes,
      'streak': streak,
    };
  }

  factory ProductivitySettings.fromJson(Map<String, dynamic> json) {
    return ProductivitySettings(
      mindfulDelay: json['mindfulDelay'] ?? false,
      focusMode: json['focusMode'] ?? false,
      delaySeconds: json['delaySeconds'] ?? 5,
      dailyLimitMinutes: json['dailyLimitMinutes'] ?? 0,
      todayUsageMinutes: json['todayUsageMinutes'] ?? 0,
      streak: json['streak'] ?? 0,
    );
  }
}