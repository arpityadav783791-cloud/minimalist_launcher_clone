import 'package:get/get.dart';
import '../services/native_app_service.dart';

class ScreenTimeController extends GetxController {
  /// packageName -> usage in minutes
  final RxMap<String, int> appUsage = <String, int>{}.obs;

  /// Total screen time today
  final RxInt totalUsageMinutes = 0.obs;

  /// Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsageStats();
  }

  Future<void> loadUsageStats() async {
    try {
      isLoading.value = true;

      final stats = await NativeAppService.getUsageStats();

      print("====================================");
      print("USAGE STATS");
      print(stats);
      print("====================================");

      appUsage.clear();

      int total = 0;

      for (final app in stats) {
        final packageName = app["packageName"] as String;
        final usage = (app["usageTime"] as num).toInt();

        appUsage[packageName] = usage;
        total += usage;
      }

      totalUsageMinutes.value = total;
    } catch (e) {
      print("UsageStats Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int getUsage(String packageName) {
    return appUsage[packageName] ?? 0;
  }

  Future<void> refreshUsage() async {
    await loadUsageStats();
  }
}