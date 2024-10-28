import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'dashboard.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

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
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isBotTyping = false;
  int _questionCount = 0;
  int _score = 0;
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _sendBotMessage('Generate a simple Python question with four options.');
  }

  Future<void> _sendBotMessage(String prompt) async {
    setState(() {
      _isBotTyping = true;
    });

    final transformer = StreamTransformer<Candidates, String>.fromHandlers(
      handleData: (candidates, sink) {
        if (candidates.content != null &&
            candidates.content!.parts != null &&
            candidates.content!.parts!.isNotEmpty) {
          sink.add(candidates.content!.parts![0].text!);
        } else {
          print('Invalid response format from Gemini.');
        }
      },
    );

    final stream = _gemini.streamGenerateContent(prompt).transform(transformer);

    String combinedResponse = ''; // Combine all responses into one string

    await for (final message in stream) {
      combinedResponse += message; // Append each message to the combined response
    }

    setState(() {
      _messages.insert(0, ChatMessage(combinedResponse, true)); // Display the combined response
      _isBotTyping = false;
    });
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text, false));
    });
    _questionCount++;
    if (_questionCount < 10) {
      _sendBotMessage('Generate a simple Python question with four options.');
    } else {
      setState(() {
        _quizCompleted = true;
        _messages.insert(0, ChatMessage('Quiz completed! Your score is $_score/5.', true));
      });
    }
  }

  void _retryQuiz() {
    setState(() {
      _messages.clear();
      _questionCount = 0;
      _score = 0;
      _quizCompleted = false;
    });
    _sendBotMessage('Generate a simple Python question with four options.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E D U - A I'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
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
          if (!_quizCompleted)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            ),
          if (_quizCompleted)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _retryQuiz,
                child: const Text('Retry Quiz'),
              ),
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
                //onSubmitted: _is BotTyping ? null : _handleSubmitted,
                decoration: const InputDecoration.collapsed(hintText: "Enter your answer"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _isBotTyping ? null : () => _handleSubmitted(_controller.text),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isBot
              ? Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: const CircleAvatar(child: Text('B')),
          )
              : Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: const CircleAvatar(child: Text('U')),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    isBot ? "Bot" : "User",
                   // style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 28.0)
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                      text,
                      //style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 26.0)
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