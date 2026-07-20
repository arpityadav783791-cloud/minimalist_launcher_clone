import 'package:flutter/services.dart';

class NativeAppService {
  static const MethodChannel _channel =
      MethodChannel('minimalist_launcher/apps');

  static Future<List<dynamic>> getInstalledApps() async {
    final apps = await _channel.invokeMethod('getInstalledApps');
    return apps;
  }

  static Future<void> launchApp(String packageName) async {
    await _channel.invokeMethod(
      'launchApp',
      {
        'packageName': packageName,
      },
    );
  }

  static Future<List<dynamic>> getUsageStats() async {
    final result = await _channel.invokeMethod('getUsageStats');
    return result;
  }
}