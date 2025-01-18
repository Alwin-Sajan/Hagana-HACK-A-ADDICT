import 'package:flutter/material.dart';
import 'package:hagana/pages/ChatPage.dart';
import 'package:hagana/pages/HaganaHomeScreen.dart';
import 'package:hagana/pages/HaganaSettings.dart';
import 'package:hagana/pages/Preventionpage.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Community',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, 
              color: isDark ? Colors.white : Colors.black87
            ),
            onPressed: () {
              // Add post functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.chat, 
              color: isDark ? Colors.white : Colors.black87
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildSection('Community Posts', [
                  {'title': 'Post 1', 'likes': 20, 'content': 'This is the content of post 1.'},
                  {'title': 'Post 2', 'likes': 35, 'content': 'This is the content of post 2.'},
                  {'title': 'Post 3', 'likes': 50, 'content': 'This is the content of post 3.'},
                ], _buildPostCard, isDark),
                _buildSection('Groups', [
                  {'title': 'Group 1', 'description': 'This is group 1.'},
                  {'title': 'Group 2', 'description': 'This is group 2.'},
                  {'title': 'Group 3', 'description': 'This is group 3.'},
                ], _buildGroupCard, isDark),
                _buildSection('Awareness Camp', [
                  {'title': 'Camp 1', 'content': 'Details about Camp 1.'},
                  {'title': 'Camp 2', 'content': 'Details about Camp 2.'},
                  {'title': 'Camp 3', 'content': 'Details about Camp 3.'},
                ], _buildCampCard, isDark),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HaganaHomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Preventionpage()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HaganaSettings()),
              );
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4B7BEC),
        unselectedItemColor: isDark ? Colors.white54 : Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_outlined),
            label: "Prevention",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items, 
      Widget Function(Map<String, dynamic>, bool) cardBuilder, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          title == 'Community Posts'
              ? Column(
                  children: items.map((item) => cardBuilder(item, isDark)).toList()
                )
              : GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: items.map((item) => cardBuilder(item, isDark)).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, bool isDark) {
    return Card(
      color: isDark ? Color(0xFF2C3E50) : Colors.blue.shade50,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              post['content'],
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.thumb_up, color: Color(0xFF4B7BEC), size: 16),
                SizedBox(width: 4.0),
                Text(
                  post['likes'].toString(),
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group, bool isDark) {
    return Card(
      color: isDark ? Color(0xFF2C3E50) : Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              group['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              group['description'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 12
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B7BEC),
              ),
              onPressed: () {
                // Join group functionality
              },
              child: Text('Join Us'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampCard(Map<String, dynamic> camp, bool isDark) {
    return Card(
      color: isDark ? Color(0xFF2C3E50) : Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              camp['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              camp['content'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 12
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/community',
    routes: {
      '/home': (context) => Placeholder(),
      '/prevention': (context) => Placeholder(),
      '/community': (context) => CommunityPage(),
      '/settings': (context) => Placeholder(),
      '/chatPage': (context) => Placeholder(),
    },
  ));
}