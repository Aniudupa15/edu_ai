import 'package:flutter/material.dart';

class SummaryJava extends StatelessWidget {
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
                'Mosh introduces himself as the instructor for a Java course and explains that students will learn everything they need to know to start programming in Java. He covers the installation of necessary tools, the basics of Java, building algorithms, and writing good code. The course is suitable for beginners and Mosh has a coding school for further skill development.Highlights💻 Mosh introduces himself as the instructor for a Java course and explains that students will learn everything they need to know to start programming in Java.🛠 Mosh discusses the installation of necessary tools, the basics of Java, building algorithms, and writing good code.🎓 The course is suitable for beginners and Mosh mentions his coding school for further skill development.📺 Mosh briefly mentions a video sponsor and emphasizes the importance of online safety.⚙ Mosh explains how to download and install the necessary tools to build Java application',
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
