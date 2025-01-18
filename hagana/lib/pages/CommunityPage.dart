import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF051650),
      appBar: AppBar(
        backgroundColor: Color(0xFF051650),
        elevation: 0,
        title: Text(
          'Community',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Add post functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.chat, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/chatPage');
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
                ], _buildPostCard),
                _buildSection('Groups', [
                  {'title': 'Group 1', 'description': 'This is group 1.'},
                  {'title': 'Group 2', 'description': 'This is group 2.'},
                  {'title': 'Group 3', 'description': 'This is group 3.'},
                ], _buildGroupCard),
                _buildSection('Awareness Camp', [
                  {'title': 'Camp 1', 'content': 'Details about Camp 1.'},
                  {'title': 'Camp 2', 'content': 'Details about Camp 2.'},
                  {'title': 'Camp 3', 'content': 'Details about Camp 3.'},
                ], _buildCampCard),
              ],
            ),
          ),
          // Bottom navigation bar
          Container(
            color: Color(0xFF2C3E50),
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(Icons.home, 'Home', false, context, '/home'),
                _buildNavBarItem(Icons.shield, 'Prevention', false, context, '/prevention'),
                _buildNavBarItem(Icons.people, 'Community', true, context, '/community'),
                _buildNavBarItem(Icons.settings, 'Settings', false, context, '/settings'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items, Widget Function(Map<String, dynamic>) cardBuilder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          ...items.map((item) => cardBuilder(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      color: Color(0xFF2C3E50),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              post['content'],
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.thumb_up, color: Colors.blue, size: 16),
                SizedBox(width: 4.0),
                Text(
                  post['likes'].toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    return Card(
      color: Color(0xFF2C3E50),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group['title'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              group['description'],
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
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

  Widget _buildCampCard(Map<String, dynamic> camp) {
    return Card(
      color: Color(0xFF2C3E50),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              camp['title'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              camp['content'],
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem(
      IconData icon, String label, bool isSelected, BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
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
