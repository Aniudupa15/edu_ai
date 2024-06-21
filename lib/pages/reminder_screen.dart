import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Duration _duration = Duration();
  bool _isRunning = false;
  Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initializeNotificationPlugin();
  }

  void _initializeNotificationPlugin() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleDailyNotification(TimeOfDay timeOfDay) async {
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(timeOfDay);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily-notifications',
      'Daily Notifications',
      channelDescription: 'Daily notifications for meditation reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Meditation Reminder',
      'It\'s time to meditate!',
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay timeOfDay) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
    });
    _updateTime();
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _stopwatch.reset();
      _duration = Duration();
    });
  }

  void _updateTime() {
    if (_stopwatch.isRunning) {
      setState(() {
        _duration = _stopwatch.elapsed;
      });
      Future.delayed(Duration(milliseconds: 30), _updateTime);
    }
  }

  void _saveMeditationSession() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> sessions = prefs.getStringList('meditation_sessions') ?? [];
    sessions.add(_duration.toString());
    await prefs.setStringList('meditation_sessions', sessions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Meditation Timer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '${_duration.inMinutes.toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveMeditationSession();
                _resetTimer();
              },
              child: Text('Save Session'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _scheduleDailyNotification(const TimeOfDay(hour: 20, minute: 0)); // 8:00 PM
              },
              child: Text('Set Daily Reminder at 8 PM'),
            ),
          ],
        ),
      ),
    );
  }
}