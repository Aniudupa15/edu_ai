import 'package:flutter/material.dart';

import 'dashboard.dart';

class mentalHealth extends StatelessWidget {
  const mentalHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E D U - A I'),
        backgroundColor: Colors.deepPurple,
        actions: const [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reminder');
              },
              child: const Text('Set Reminder'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/timer');
              },
              child: const Text('Track Meditation'),
            ),
          ],
        ),
      ),
    );
  }
}