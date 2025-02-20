import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/boss.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(initializationSettings);
  }

  static Future<bool> requestPermission() async {
    final android = await _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final result = await android?.requestNotificationsPermission();
    return result ?? false;
  }

  static Future<void> showBossNotification(Boss boss) async {
    await _notifications.show(
      0,
      'Nouveau Boss',
      'Découvrez ${boss.name} du secteur ${boss.sector}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'bossdex_channel',
          'BossDex Notifications',
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
} 