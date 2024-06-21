import 'package:flutter/material.dart';

class SummaryPython extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summary Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SummaryPage(),
      debugShowCheckedModeBanner: false,
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
      body: SingleChildScrollView(
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
                'This video tutorial introduces the Python programming language and covers some of the basics of programming with Python. The tutorial covers how to create variables, how to use print statements, and how to get input from the user. Additionally, the tutorial covers how to use the Python math functions and how to create a basic calculator program. This YouTube video introduces the Python if statement. It covers how to use if statements to make decisions based on the values of two variables. The video also demonstrates how to use multiple if statements to check different combinations of conditions. This video demonstrates how to use for loops in Python to create a guessing game, a power function, and a translator. The author also shows how to use nested for loops to access elements in a two-dimensional list. This video introduces the concept of classes and objects in Python. It also shows how to create a student class and use it in a program. Finally, it demonstrates how to create a multiple choice quiz using the student data type. This video covers the basics of Python programming, including how to create and run functions, and how to use the Python interpreter.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
