import 'package:flutter/material.dart';

void main() => runApp(Achiver());

class Achiver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achievements',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AchievementsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AchievementsPage extends StatelessWidget {
  final List<Achievement> achievements = [
    Achievement(
      title: 'Beginner',
      description: 'Completed the first lesson',
      icon: Icons.star_border,
    ),
    Achievement(
      title: 'Intermediate',
      description: 'Completed 5 lessons',
      icon: Icons.star_half,
    ),
    Achievement(
      title: 'Advanced',
      description: 'Completed 10 lessons',
      icon: Icons.star,
    ),
    Achievement(
      title: 'Expert',
      description: 'Completed all lessons',
      icon: Icons.star_rate,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(achievements[index].icon, size: 40.0, color: Colors.blue),
              title: Text(
                achievements[index].title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(achievements[index].description),
            ),
          );
        },
      ),
    );
  }
}

class Achievement {
  final String title;
  final String description;
  final IconData icon;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
  });
}
