import 'package:flutter/material.dart';
import 'app.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    navigatorKey: globalKey,
  ));
}
