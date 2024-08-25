import 'package:workmanager/workmanager.dart';

class BackgroundService {
  static final BackgroundService _instance = BackgroundService._internal();
  factory BackgroundService() => _instance;
  BackgroundService._internal();

  void scheduleDailyNotification() {
    // Menghitung initial delay agar notifikasi selalu muncul jam 11 pagi
    final initialDelay = _calculateInitialDelay();

    Workmanager().registerPeriodicTask(
      'daily_task',
      'daily_notification_task',
      frequency: const Duration(days: 1),
      initialDelay: initialDelay,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    final targetTime =
        DateTime(now.year, now.month, now.day, 11, 0); // 11:00 AM today

    if (now.isAfter(targetTime)) {
      // Jika sudah lewat jam 11:00 hari ini, hitung untuk besok
      return targetTime.add(const Duration(days: 1)).difference(now);
    } else {
      // Hitung selisih waktu sampai jam 11:00 hari ini
      return targetTime.difference(now);
    }
  }
}
