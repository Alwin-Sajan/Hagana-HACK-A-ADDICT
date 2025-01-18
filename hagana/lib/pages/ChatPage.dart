// Flutter Frontend: Minimalist Chat Page
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';

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
    },
    {
      "user": "Support",
      "message": "We're here to support your recovery journey.",
      "time": "09:01 AM",
      "isRead": true,
    }
  ];

  final List<String> _quickResponses = [
    "I need help right now",
    "Looking for support groups",
    "Need to talk to someone",
    "Emergency assistance",
  ];

  bool _isTyping = false;

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "user": "You",
          "message": _messageController.text,
          "time": "${DateTime.now().hour}:${DateTime.now().minute}",
          "isRead": false,
        });
      });
      _messageController.clear();
      // Simulate response after 1 second
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isTyping = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _isTyping = false;
            _messages.add({
              "user": "Support",
              "message": "Thank you for reaching out. A support member will respond shortly.",
              "time": "${DateTime.now().hour}:${DateTime.now().minute}",
              "isRead": true,
            });
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF051650) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
        title: Column(
          children: [
            Text(
              "Support Chat",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Online - Usually responds in 5 minutes",
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              // Show chat info/guidelines
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
                  title: Text(
                    'Chat Guidelines',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGuideline('24/7 Support Available', Icons.access_time),
                      _buildGuideline('Confidential Conversations', Icons.lock_outline),
                      _buildGuideline('Professional Support Team', Icons.verified_user_outlined),
                      _buildGuideline('Emergency Services Available', Icons.emergency_outlined),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Got it',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Responses
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _quickResponses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? const Color(0xFF1A237E) : Colors.blue.shade100,
                      foregroundColor: isDark ? Colors.white : Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      _messageController.text = _quickResponses[index];
                      _sendMessage();
                    },
                    child: Text(_quickResponses[index]),
                  ),
                );
              },
            ),
          ),
          
          // Messages List
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Column(
                  children: [
                    if (index == 0 || _shouldShowDate(index))
                      _buildDateDivider(_messages[index]['time']),
                    MessageBubble(
                      message: message,
                      isDark: isDark,
                    ),
                  ],
                );
              },
            ),
          ),

          // Typing Indicator
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'Support is typing...',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),

          // Message Input
          Container(
            color: isDark ? const Color(0xFF0A2164) : Colors.white,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.attach_file,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  onPressed: () {
                    // Handle file attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF1A237E) : Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
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

  Widget _buildGuideline(String text, IconData icon) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  bool _shouldShowDate(int index) {
    if (index == 0) return true;
    final previousMessage = _messages[index - 1];
    final currentMessage = _messages[index];
    return previousMessage['time'] != currentMessage['time'];
  }

  Widget _buildDateDivider(String time) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        time,
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.black54,
          fontSize: 12,
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isDark;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message['user'] == 'You' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: message['user'] == 'You'
              ? (isDark ? const Color(0xFF0A2164) : Colors.blue.shade100)
              : (isDark ? const Color(0xFF1A237E) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message['user'],
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  message['time'],
                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message['message'],
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
            if (message['user'] == 'You')
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  message['isRead'] ? Icons.done_all : Icons.done,
                  size: 16,
                  color: message['isRead']
                      ? (isDark ? Colors.white70 : Colors.blue)
                      : (isDark ? Colors.white54 : Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
