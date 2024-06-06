import 'package:edu_ai/components/chat_bot.dart';
import 'package:flutter/material.dart';

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
                    MaterialPageRoute(builder: (context) => const ChatBot()),
                  );
                },
                child: const Text("Learn with AI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
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
                    MaterialPageRoute(builder: (context) => const ChatBot()),
                  );
                },
                child: const Text("Chat with AI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    minimumSize: const Size(double.infinity, 70)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatBot()),
                  );
                },
                child: const Text("Problem Solving with AI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    minimumSize: const Size(double.infinity, 70)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatBot()),
                  );
                },
                child: const Text("Quiz",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 5, left: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    minimumSize: const Size(double.infinity, 70)),
                onPressed: () {

                },
                child: const Text("Health Monitoring",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
          )
        ],
      ),
    );
  }
}
