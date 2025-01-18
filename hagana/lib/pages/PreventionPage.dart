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
            fontWeight: FontWeight.w300,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, 
            color: isDark ? Colors.white : Colors.black87
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0A2164) : Colors.blue.shade50,
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
                    fontWeight: FontWeight.w300,
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
              fontWeight: FontWeight.w300,
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
                ),
              )),
          const SizedBox(height: 24),
          Text(
            "Emergency Contacts",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
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
