import 'package:edu_ai/pages/quiz.dart';
import 'package:edu_ai/pages/skillDev.dart';
import 'package:flutter/material.dart';

import '../languages/learnAI.dart';
import 'dashboard.dart';
import 'mental_health.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 70)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const languagesAI()),
                  );
                },
                child: const Text(
                  "Learn with AI",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 70)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SkillDev()),
                  );
                },
                child: const Text(
                  "Problem Solving with AI",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 70)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizApp()),
                  );
                },
                child: const Text(
                  "Quiz",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.blue,
          //           minimumSize: const Size(double.infinity, 70)),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const mentalHealth()),
          //         );
          //       },
          //       child: const Text(
          //         "Mental Health",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold),
          //       )),
          // ),
        ],
      ),
    );
  }
}
