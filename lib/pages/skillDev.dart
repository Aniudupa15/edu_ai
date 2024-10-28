import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'dashboard.dart';

void main() => runApp(const SkillDev());

class SkillDev extends StatelessWidget {
  const SkillDev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _gemini = Gemini.instance;
  final _messages = <ChatMessage>[];
  final _controller = TextEditingController();
  bool _isBotTyping = false;
  late StreamSubscription<Candidates?> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  @override
  void dispose() {
    _streamSubscription.cancel(); // Cancel the subscription when disposing
    super.dispose();
  }

  Future<void> _generateQuestion() async {
    if (!_isBotTyping) {
      setState(() {
        _isBotTyping = true;
      });
      _streamSubscription = _gemini
          .streamGenerateContent('Generate a short problem Statement ')
          .listen((response) {
        final candidates = response as Candidates?;
        if (candidates != null &&
            candidates.content != null &&
            candidates.content!.parts != null &&
            candidates.content!.parts!.isNotEmpty) {
          final parts = candidates.content!.parts!;
          final combinedResponse = parts.map((part) => part.text ?? '').join();
          setState(() {
            final message = combinedResponse.isNotEmpty
                ? ChatMessage(combinedResponse, true)
                : ChatMessage('Failed to generate question.', true);
            _messages.insert(
                0, message); // Insert at the beginning for reverse display
            _isBotTyping = false;
          });
        } else {
          print('Invalid response format from Gemini.');
          setState(() {
            _isBotTyping = false;
          });
        }
      }, onError: (error) {
        print('Error: $error');
        setState(() {
          _isBotTyping = false;
        });
      });
    }
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      _messages.insert(
          0,
          ChatMessage(
              text, false)); // Insert at the beginning for reverse display
      _isBotTyping = true; // Set bot typing status
    });

    // Analyze user's answer
    _gemini
        .streamGenerateContent(
        'Analyze this Python answer: "$text". Provide suggestions if needed.')
        .listen((response) {
      final candidates = response as Candidates?;
      if (candidates != null &&
          candidates.content != null &&
          candidates.content!.parts != null &&
          candidates.content!.parts!.isNotEmpty) {
        final parts = candidates.content!.parts!;
        final combinedResponse = parts.map((part) => part.text ?? '').join();
        setState(() {
          final message = combinedResponse.isNotEmpty
              ? ChatMessage(combinedResponse, true)
              : ChatMessage('Failed to analyze answer.', true);
          _messages.insert(
              0, message); // Insert at the beginning for reverse display
          _isBotTyping = false; // Set bot typing status
          _generateQuestion(); // Generate the next question after analyzing the answer
        });
      } else {
        print('Invalid response format from Gemini.');
        setState(() {
          _isBotTyping = false; // Set bot typing status
        });
      }
    }, onError: (error) {
      print('Error: $error');
      setState(() {
        _isBotTyping = false; // Set bot typing status
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E D U - A I ',style: TextStyle(color: Colors.white,fontSize: 20),),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _handleSubmitted(_controller.text),
                decoration: const InputDecoration.collapsed(
                  hintText: "Enter your answer",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isBot;

  ChatMessage(this.text, this.isBot);

  @override
  Widget build(BuildContext context) {
    var subtitle1;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isBot
              ? Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const CircleAvatar(child: Text('B')),
          )
              : Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const CircleAvatar(child: Text('U')),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(isBot ? "Bot" : "User",
                    //style: Theme.of(context).textTheme.subtitle1
                    ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 25), // Increase text size to 25
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}