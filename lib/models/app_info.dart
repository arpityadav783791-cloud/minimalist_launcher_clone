class AppInfo {
  final String appName;
  final String packageName;

  AppInfo({
    required this.appName,
    required this.packageName,
    
  });

  factory AppInfo.fromMap(Map<dynamic, dynamic> map) {
    return AppInfo(
      appName: map["appName"],
      packageName: map["packageName"],
      
    );
  }
}