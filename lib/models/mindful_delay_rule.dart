class MindfulDelayRule {
  final String packageName;

  bool enabled;

  /// Delay stored in seconds.
  int delaySeconds;

  /// If not null, the delay remains active until this time,
  /// after which it will automatically be disabled.
  DateTime? scheduledDisableAt;

  MindfulDelayRule({
    required this.packageName,
    required this.enabled,
    required this.delaySeconds,
    this.scheduledDisableAt,
  });

  bool get isDisableScheduled => scheduledDisableAt != null;

  bool get shouldDisableNow {
    if (scheduledDisableAt == null) return false;

    return DateTime.now().isAfter(scheduledDisableAt!);
  }

  Map<String, dynamic> toJson() {
    return {
      'packageName': packageName,
      'enabled': enabled,
      'delaySeconds': delaySeconds,
      'scheduledDisableAt': scheduledDisableAt?.toIso8601String(),
    };
  }

  factory MindfulDelayRule.fromJson(Map<String, dynamic> json) {
    return MindfulDelayRule(
      packageName: json['packageName'],
      enabled: json['enabled'] ?? false,
      delaySeconds: json['delaySeconds'] ?? 0,
      scheduledDisableAt: json['scheduledDisableAt'] != null
          ? DateTime.parse(json['scheduledDisableAt'])
          : null,
    );
  }

  MindfulDelayRule copyWith({
    String? packageName,
    bool? enabled,
    int? delaySeconds,
    DateTime? scheduledDisableAt,
  }) {
    return MindfulDelayRule(
      packageName: packageName ?? this.packageName,
      enabled: enabled ?? this.enabled,
      delaySeconds: delaySeconds ?? this.delaySeconds,
      scheduledDisableAt:
          scheduledDisableAt ?? this.scheduledDisableAt,
    );
  }
}