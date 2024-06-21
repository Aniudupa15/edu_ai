import 'package:flutter/material.dart';

class SummaryScript extends StatelessWidget {
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
      body:SingleChildScrollView( child: Padding(
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
              child: Text('This video course is a comprehensive introduction to JavaScript for beginners, covering topics such as variables, arrays, functions, conditionals, and more.Highlights🎥 JavaScript basics and getting started with code editors💡 Writing reusable code with functions🌟 Understanding scopes and variable declaration🔄 Mutating arrays and preventing object mutation➡ Using arrow functions and higher-order functions📦 Importing and exporting JavaScript modulesKey Insights💡 The use of var, let, and const for variable declaration and their scope differences.💡 Preventing object mutation with object.freeze to maintain data integrity.💡 The benefits of using arrow functions for writing concise and readable code.💡 The powerful functionality of higher-order functions like map, filter, and reduce.💡 The convenience of default parameters and rest parameters for flexible function usage.💡 The versatility of destructuring assignment for easily extracting values from objects and arrays.💡 The importance of understanding module imports and exports for modular JavaScript development.',
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
