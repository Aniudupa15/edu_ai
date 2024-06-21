import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeditationTimerScreen extends StatefulWidget {
  @override
  _MeditationTimerScreenState createState() => _MeditationTimerScreenState();
}

class _MeditationTimerScreenState extends State<MeditationTimerScreen> {
  Duration _duration = Duration();
  bool _isRunning = false;
  Stopwatch _stopwatch = Stopwatch();

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
        title: Text('Meditation Timer'),
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
          ],
        ),
      ),
    );
  }
}