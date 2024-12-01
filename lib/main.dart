import 'package:edu_ai/auth/auth.dart';
import 'package:edu_ai/pages/meditation_timer_screen.dart';
import 'package:edu_ai/pages/quiz.dart';
import 'package:edu_ai/pages/skillDev.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:edu_ai/auth/login_or_register.dart';
import 'package:edu_ai/auth/firebase_options.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'components/consts.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the options from firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp()); // Call the MyApp class instead of directly running MaterialApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'auth',
      theme: ThemeData(
        // Set primary color (deep purple)
        primarySwatch: Colors.deepPurple,
        ),
      routes: {
        'login_or_register': (context) => const LoginOrRegister(),
        'auth': (context) => const AuthPage(),
        'quiz': (context) => const QuizApp(),
        'skill': (context) => const SkillDev(),
        '/timer': (context) => MeditationTimerScreen(),
        // ... other routes
      },
    );
  }
}
