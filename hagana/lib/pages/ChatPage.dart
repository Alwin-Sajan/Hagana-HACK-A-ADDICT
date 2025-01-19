import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import '../main.dart';
import 'dart:typed_data';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "user": "Support",
      "message": "Hello! How can we help you today?",
      "time": "09:00 AM",
      "isRead": true,
      "mood": "Neutral",
    },
  ];

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
  try {
    await Tflite.loadModel(
      model: "assets/sentiment_model.tflite",
      labels: "assets/labels.txt",
    );
    print("Model loaded successfully!");
  } catch (e) {
    print("Error loading model: $e");
  }
}


Future<String> _analyzeMood(String message) async {
  try {
    final List? results = await Tflite.runModelOnBinary(
      binary: Uint8List.fromList(message.codeUnits),
      numResults: 2,
      threshold: 0.5,
    );

    if (results != null && results.isNotEmpty) {
      print("Analysis results: $results");
      return results[0]['label'] ?? "Neutral";
    }
    return "Neutral";
  } catch (e) {
    print("Error analyzing mood: $e");
    return "Neutral";
  }
}


  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final userMessage = _messageController.text.trim();
      setState(() {
        _messages.add({
          "user": "You",
          "message": userMessage,
          "time": "${DateTime.now().hour}:${DateTime.now().minute}",
          "isRead": false,
          "mood": "Neutral",
        });
      });

      _messageController.clear();
      setState(() {
        _isTyping = true;
      });

      final mood = await _analyzeMood(userMessage);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isTyping = false;
          _messages.add({
            "user": "Support",
            "message": _getResponseBasedOnMood(mood),
            "time": "${DateTime.now().hour}:${DateTime.now().minute}",
            "isRead": true,
            "mood": mood,
          });
        });
      });
    }
  }

  String _getResponseBasedOnMood(String mood) {
    switch (mood) {
      case "Positive":
        return "Glad to hear that! Let us know if there's anything we can do.";
      case "Negative":
        return "I'm sorry to hear that. We're here to help you. Can you tell us more?";
      case "Neutral":
      default:
        return "Thanks for sharing. How can we assist you further?";
    }
  }

  @override
  void dispose() {
    Tflite.close();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF051650) // Dark theme background
          : Colors.white, // Light theme background
      appBar: AppBar(
        title: Text(
          "Support Chat",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: isDark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message,
                  isDark: isDark,
                );
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Support is typing...',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(8),
            color: isDark
                ? const Color(0xFF0A2164) // Input container for dark theme
                : Colors.white, // Input container for light theme
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      filled: true,
                      fillColor: isDark
                          ? const Color(0xFF1A237E) // Input field background for dark theme
                          : Colors.grey.shade100, // Input field background for light theme
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: isDark ? Colors.white : Colors.blue,
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isDark;

  const MessageBubble({
    required this.message,
    required this.isDark,
  });

  Color _getMoodColor(String mood) {
    switch (mood) {
      case "Positive":
        return Colors.green;
      case "Negative":
        return Colors.red;
      case "Neutral":
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mood = message['mood'] ?? "Neutral";

    return Align(
      alignment: message['user'] == 'You' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: message['user'] == 'You' 
              ? CrossAxisAlignment.end 
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A237E) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message['message'],
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Container(
              height: 2,
              width: 40,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: _getMoodColor(mood),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
