import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'utils/notification_helper.dart';
import 'app.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await NotificationHelper().initNotifications();

  runApp(MyApp(
    navigatorKey: globalKey,
  ));
}
