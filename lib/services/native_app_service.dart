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
}