import 'package:edu_ai/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:edu_ai/auth/login_or_register.dart';
import 'package:edu_ai/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the options from firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'auth',
    routes: {
      'login_or_register': (context) => const LoginOrRegister(),
      'auth':(context) => const AuthPage(),
      // 'login_page': (context) => const MyLogin(),
      // 'register': (context) => const MyRegister(),
      // 'attendance': (context) => const MapPage(),
      // 'user': (context) => const MyUser(),
      // 'admin': (context) => const MyAdmin(),
      // 'home': (context) => HomeScreen(),
    },
  ));
}
