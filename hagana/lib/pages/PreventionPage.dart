import 'package:flutter/material.dart';
import 'HaganaHomeScreen.dart';
import 'CommunityPage.dart';
import 'HaganaSettings.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';

class Preventionpage extends StatefulWidget {
  const Preventionpage({super.key});

  @override
  State<Preventionpage> createState() => _PreventionpageState();
}

class _PreventionpageState extends State<Preventionpage> {
  final List<String> personalSafetyTips = [
    "• Identify and avoid trigger situations",
    "• Practice mindfulness and meditation",
    "• Keep a journal of cravings and emotions",
    "• Exercise regularly to manage stress",
    "• Develop healthy coping mechanisms",
    "• Create a daily routine and stick to it",
    "• Stay connected with supportive family members",
    "• Find drug-free activities you enjoy",
    "• Learn to say 'no' confidently",
    "• Keep emergency contacts readily available",
  ];

  final List<String> digitalSecurityTips = [
    "• Block contacts of drug dealers",
    "• Install addiction recovery apps",
    "• Join online support groups",
    "• Enable content filtering",
    "• Set screen time limits",
    "• Remove triggering social media",
    "• Use apps for tracking sobriety",
    "• Enable location sharing with trusted contacts",
    "• Install panic button apps",
    "• Use password protection for recovery resources",
  ];

  final List<String> communitySafetyTips = [
    "• Join local support groups",
    "• Participate in community outreach programs",
    "• Build a network of sober friends",
    "• Attend regular counseling sessions",
    "• Volunteer at recovery centers",
    "• Share your recovery journey to help others",
    "• Create safe spaces in your community",
    "• Organize drug-free social events",
    "• Support others in their recovery",
    "• Stay connected with recovery mentors",
  ];

  void _showStrategyList(BuildContext context, String title, List<String> strategies, bool isDark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
          title: Row(
            children: [
              Icon(
                title == "Personal Safety" 
                    ? Icons.shield_outlined
                    : title == "Digital Security"
                        ? Icons.security_outlined
                        : Icons.people_outline,
                color: title == "Personal Safety"
                    ? const Color(0xFF4A90E2)
                    : title == "Digital Security"
                        ? const Color(0xFF64B5F6)
                        : const Color(0xFF90CAF9),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: strategies.map((tip) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  tip,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              )).toList(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B7BEC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
          "Prevention",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black87
            ),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HaganaHomeScreen()),
              );
            },
          )
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0A2164) : Colors.blue,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.blue.shade100,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stay Safe, Stay Smart",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Learn essential prevention strategies for your safety",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Prevention Strategies",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...[
            {
              "title": "Personal Safety",
              "icon": Icons.shield_outlined,
              "color": Color(0xFF4A90E2)
            },
            {
              "title": "Digital Security",
              "icon": Icons.security_outlined,
              "color": Color(0xFF64B5F6)
            },
            {
              "title": "Community Safety",
              "icon": Icons.people_outline,
              "color": Color(0xFF90CAF9)
            },
          ].map((item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0A2164) : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.blue.shade100,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    item["icon"] as IconData,
                    color: item["color"] as Color,
                  ),
                  title: Text(
                    item["title"] as String,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  onTap: () {
                    if (item["title"] == "Personal Safety") {
                      _showStrategyList(context, "Personal Safety", personalSafetyTips, isDark);
                    } else if (item["title"] == "Digital Security") {
                      _showStrategyList(context, "Digital Security", digitalSecurityTips, isDark);
                    } else if (item["title"] == "Community Safety") {
                      _showStrategyList(context, "Community Safety", communitySafetyTips, isDark);
                    }
                  },
                ),
              )),
          const SizedBox(height: 24),
          Text(
            "Emergency Contacts",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...[
            {
              "title": "Police Emergency",
              "number": "911",
              "icon": Icons.local_police_outlined
            },
            {
              "title": "Hagana Hotline",
              "number": "1-800-HAGANA",
              "icon": Icons.phone_outlined
            },
          ].map((contact) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0A2164) : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.blue.shade100,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    contact["icon"] as IconData,
                    color: const Color(0xFFFF4B4B),
                  ),
                  title: Text(
                    contact["title"] as String,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  subtitle: Text(
                    contact["number"] as String,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.phone_outlined,
                      color: Color(0xFF4CAF50),
                    ),
                    onPressed: () {},
                  ),
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HaganaHomeScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CommunityPage()),
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
}
