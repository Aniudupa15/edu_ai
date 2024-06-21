import 'package:flutter/material.dart';

class SummaryC extends StatelessWidget {
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
                'Summary:This video tutorial is about getting started with the C programming language. It covers topics such as installing a text editor and a C compiler, writing basic code, understanding program structure, and exploring advanced concepts like structures and functions.Highlights:The C programming language is one of the oldest and most influential programming languages.Installing an integrated development environment (IDE) like Code Blocks can make programming in C easier.A C compiler is needed to translate C programs into a language that the computer can understand.The tutorial provides instructions for setting up Code Blocks and a C compiler on both Windows and Mac operating systems.The tutorial also demonstrates how to create a new C project, write and run a basic C program.Keywords:C programming, tutorial, beginners, Giraffe Academy, IDE, C compiler, Code Blocks, Windows, Mac, integrated development environment, program structure, basic code, advanced concepts.',
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
