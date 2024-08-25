import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../config/background_service.dart';
import '../../../../utils/styles.dart';
import '../../../core/presentation/widgets/custom_scaffold.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isNotificationEnabled = false;
  final BackgroundService _backgroundService = BackgroundService();

  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
  }

  void _loadNotificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationEnabled = prefs.getBool('notificationEnabled') ?? false;
    });
  }

  void _saveNotificationStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationEnabled', value);
  }

  void _onToggleChanged(bool value) {
    setState(() {
      _isNotificationEnabled = value;
      _saveNotificationStatus(value);
      if (_isNotificationEnabled) {
        _backgroundService.scheduleDailyNotification();
      } else {
        Workmanager().cancelAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Scheduler', style: titleTextStyle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text(
                'Restaurant Notification',
                style: blackTextStyle.merge(semiBoldStyle),
              ),
              value: _isNotificationEnabled,
              onChanged: _onToggleChanged,
            ),
          ],
        ),
      ),
    );
  }
}
