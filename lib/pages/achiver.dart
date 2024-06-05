import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Achiver extends StatefulWidget {
  const Achiver({super.key});

  @override
  State<Achiver> createState() => _AchiverState();
}
class _AchiverState extends State<Achiver> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text('achivement'),
    );
  }
}
