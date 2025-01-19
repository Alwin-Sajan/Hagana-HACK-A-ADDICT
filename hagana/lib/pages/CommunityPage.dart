import 'package:flutter/material.dart';
import 'package:hagana/pages/ChatPage.dart';
import 'package:hagana/pages/HaganaHomeScreen.dart';
import 'package:hagana/pages/HaganaSettings.dart';
import 'package:hagana/pages/Preventionpage.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildSection('Community Posts', [
                    {'title': 'Anti-Drug Campaign', 'likes': 20, 'content': 'Join us in the fight against drug abuse! The campaign aims to raise awareness and provide support for those affected.', 'image': 'assets/images/anti_drug_campaign.png'},
                    {'title': 'Community Support Day', 'likes': 35, 'content': 'A day dedicated to providing support for those recovering from substance abuse. Join us for free counseling, resources, and a strong community of supporters.', 'image': 'assets/images/community_support_day.png'},
                    {'title': 'Prevention Workshop', 'likes': 50, 'content': 'Attend our workshop on drug abuse prevention. We’ll cover strategies, coping mechanisms, and share inspiring stories from those who’ve overcome addiction.', 'image': 'assets/images/prevention_workshop.png'},
                  ], _buildPostCard, isDark),

                  _buildSection('Awareness Camp', [
                    {
                      'title': 'Same as U',
                      'description': 'Join our community of survivors who understand your struggles. Weekly meetings, counseling sessions, and 24/7 support available.',
                      'link': 'https://sameasu.org'
                    },
                    {
                      'title': 'Nourish',
                      'description': 'Comprehensive recovery program including therapy, nutrition guidance, fitness training, and mindfulness practices.',
                      'link': 'https://nourish-recovery.org'
                    },
                    {
                      'title': 'One Life One Shot',
                      'description': 'Engaging programs designed specifically for young adults, featuring sports activities, art therapy, and career guidance.',
                      'link': 'https://onelifeoneshot.org'
                    },
                  ], _buildCampCard, isDark),

                  _buildSection('Upcoming Events', [
                    {'title': 'Anti-Drug Day', 'description': 'This is group 1.'},
                    {'title': 'Marathon', 'description': 'Marathon'},
                    {'title': 'Let\'s Talk', 'description': 'Webinar'},
                  ], _buildGroupCard, isDark),

                ],
              ),
            ),
          ],
        ),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
          const SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) => cardBuilder(items[index], isDark),
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
            post.containsKey('image') ? Image.asset(post['image']) : Container(),
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
              child: Text('Join Us' ,style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampCard(Map<String, dynamic> camp, bool isDark) {
    return Builder(
      builder: (BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        color: isDark ? Color(0xFF2C3E50) : Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B7BEC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _showCampDescription(context, camp, isDark),
                        child: const Text(
                          'Learn More',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _showExternalLinkDialog(context, camp, isDark),
                        child: const Text(
                          'Visit Website',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExternalLinkDialog(BuildContext context, Map<String, dynamic> camp, bool isDark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
          title: Text(
            'External Resource',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You will be redirected to ${camp['title']} website. Do you want to continue?',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B7BEC),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                final url = camp['link'];
                try {
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not open link'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Visit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCampDescription(BuildContext context, Map<String, dynamic> camp, bool isDark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
          title: Text(
            camp['title'],
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            camp['description'],
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B7BEC),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Got it',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
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
