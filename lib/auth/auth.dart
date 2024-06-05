import 'package:edu_ai/auth/login_or_register.dart';
import 'package:edu_ai/pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
        if(snapshot.hasData){
          return HomeScreen();
        }
        else{
          return const LoginOrRegister();
        }
          }),
    );
  }
}
