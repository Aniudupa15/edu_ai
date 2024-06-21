import 'package:flutter/material.dart';

class SummaryFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summary Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SummaryPage(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Page'),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue,
                ),
              ),
              child: Text(
                'SummaryThe video tutorial demonstrates how to create a real-time chat application using Flutter and Firebase, allowing users to register, log in, and chat with each other. The tutorial covers various components of Firebase, including authentication, Firestore database, storage, and analytics.HighlightsCreate a fully functional real-time chat application using Flutter and Firebase.Users can register, log in, and chat with each other.Utilize Firebase components such as authentication, Firestore database, storage, and analytics.Implement features like sending messages, images, and timestamps.Use packages like Dash chat and delightful toast to enhance the user experience.KeywordsFlutter, Firebase, real-time chat, mobile app, authentication, Firestore, storage, analytics, messages, images',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),)
    );
  }
}
