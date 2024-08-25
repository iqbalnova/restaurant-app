import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:myresto/config/api_client.dart';
import 'package:myresto/data/models/received_notification.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
// import 'package:timezone/timezone.dart' as tz;

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";
  static NotificationHelper? _instance;

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
        iOS: DarwinNotificationDetails());
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final ApiClient _apiClient = ApiClient();

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          log('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  void requestIOSPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void configureDidReceiveLocalNotificationSubject(
      BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, route,
                    arguments: receivedNotification);
              },
            )
          ],
        ),
      );
    });
  }

  Future<void> showNotification() async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      _notificationDetails(),
      payload: 'plain notification',
    );
  }

  Future<void> showNotificationWithNoBody() async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      null,
      _notificationDetails(),
      payload: 'item x',
    );
  }

  // Future<void> scheduleNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payLoad,
  //   required DateTime scheduledNotificationDateTime,
  // }) async {
  //   log('running');
  //   return _flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
  //     _notificationDetails(),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     payload: payLoad,
  //   );
  // }

  Future<void> showGroupedNotifications() async {
    var groupKey = 'com.android.example.WORK_EMAIL';

    var firstNotificationAndroidSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
    );

    var firstNotificationPlatformSpecifics =
        NotificationDetails(android: firstNotificationAndroidSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      1,
      'Alex Faarborg',
      'You will not believe...',
      firstNotificationPlatformSpecifics,
    );

    var secondNotificationAndroidSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
    );

    var secondNotificationPlatformSpecifics =
        NotificationDetails(android: secondNotificationAndroidSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      2,
      'Jeff Chang',
      'Please join us to celebrate the...',
      secondNotificationPlatformSpecifics,
    );

    var lines = <String>[];
    lines.add('Alex Faarborg  Check this out');
    lines.add('Jeff Chang    Launch Party');

    var inboxStyleInformation = InboxStyleInformation(
      lines,
      contentTitle: '2 messages',
      summaryText: 'janedoe@example.com',
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      styleInformation: inboxStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      3,
      'Attention',
      'Two messages',
      platformChannelSpecifics,
    );
  }

  Future<void> showProgressNotification() async {
    var maxProgress = 5;
    for (var i = 0; i <= maxProgress; i++) {
      await Future.delayed(const Duration(seconds: 1), () async {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: maxProgress,
          progress: i,
        );

        var platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await _flutterLocalNotificationsPlugin.show(
          0,
          'progress notification title',
          'progress notification body',
          platformChannelSpecifics,
          payload: 'item x',
        );
      });
    }
  }

  // Future<String> _downloadAndSaveFile(String url, String fileName) async {
  //   var directory = await getApplicationDocumentsDirectory();
  //   var filePath = '${directory.path}/$fileName';
  //   var response = await _apiClient.get(url);
  //   var file = File(filePath);
  //   await file.writeAsBytes(response.data);
  //   return filePath;
  // }

  // Future<void> showBigPictureNotification() async {
  //   var largeIconPath = await _downloadAndSaveFile(
  //       'http://via.placeholder.com/48x48', 'largeIcon');
  //   var bigPicturePath = await _downloadAndSaveFile(
  //       'http://via.placeholder.com/400x800', 'bigPicture');

  //   var bigPictureStyleInformation = BigPictureStyleInformation(
  //     FilePathAndroidBitmap(bigPicturePath),
  //     largeIcon: FilePathAndroidBitmap(largeIconPath),
  //     contentTitle: 'overridden <b>big</b> content title',
  //     htmlFormatContentTitle: true,
  //     summaryText: 'summary <i>text</i>',
  //     htmlFormatSummaryText: true,
  //   );

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     _channelId,
  //     _channelName,
  //     channelDescription: _channelDesc,
  //     styleInformation: bigPictureStyleInformation,
  //   );

  //   var platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     'big text title',
  //     'silent body',
  //     platformChannelSpecifics,
  //   );
  // }

  // Future<void> showNotificationWithAttachment() async {
  //   var bigPicturePath = await _downloadAndSaveFile(
  //       'http://via.placeholder.com/600x200', 'bigPicture.jpg');

  //   var bigPictureAndroidStyle =
  //       BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     _channelId,
  //     _channelName,
  //     channelDescription: _channelDesc,
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     styleInformation: bigPictureAndroidStyle,
  //   );

  //   var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
  //       attachments: [DarwinNotificationAttachment(bigPicturePath)]);

  //   var notificationDetails = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );

  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     'notification with attachment title',
  //     'notification with attachment body',
  //     notificationDetails,
  //   );
  // }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, route,
          arguments: ReceivedNotification(payload: payload));
    });
  }
}
