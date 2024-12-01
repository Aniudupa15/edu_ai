import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:edu_ai/summary/summaryC.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:collection/collection.dart'; // Add this import for firstOrNull

class ChatBotC extends StatefulWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );
  const ChatBotC({super.key});

  @override
  State<ChatBotC> createState() => _ChatBotCState();
}

class _ChatBotCState extends State<ChatBotC> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  String selectedLevel = "Beginner";

  late YoutubePlayerController _youtubeController;

  final Map<String, List<String>> videoUrls = {
    "Beginner": ["dTp0c41XnrQ",], // Replace with actual video IDs
    "Moderate": ["87SH2Cn0s9A",],
    "Hard": ["KJgsSFOSQv0",],
  };

  @override
  void initState() {
    super.initState();

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoUrls[selectedLevel]![0], // Default to Beginner level
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "AI");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDULINK'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedLevel,
            items: videoUrls.keys
                .map((level) => DropdownMenuItem(
              value: level,
              child: Text(level),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedLevel = value;
                  _youtubeController.load(videoUrls[selectedLevel]![0]);
                });
              }
            },
          ),
          Container(
            color: Colors.blue,
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
              ),
              builder: (context, player) {
                return player;
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                color: Colors.amber,
                child: _buildUI(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SummaryC()),
              );
            },
            child: const Text('Go to Summary Page'),
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts
              ?.fold("", (previous, current) => "$previous${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts
              ?.fold("", (previous, current) => "$previous${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
