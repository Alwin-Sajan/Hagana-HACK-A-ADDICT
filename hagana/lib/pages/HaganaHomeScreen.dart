import 'package:flutter/material.dart';
import 'Preventionpage.dart';
import 'CommunityPage.dart';
import 'HaganaSettings.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';

class HaganaHomeScreen extends StatefulWidget {
  const HaganaHomeScreen({super.key});

  @override
  State<HaganaHomeScreen> createState() => _HaganaHomeScreenState();
}

class _HaganaHomeScreenState extends State<HaganaHomeScreen> {
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
          "Hagana",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, 
              color: isDark ? Colors.white : Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Welcome to Hagana",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your personal safety companion",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ...["Emergency Call", "Report Incident", "Safety Tips"].map(
              (action) => Container(
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
                    action == "Emergency Call"
                        ? Icons.phone_outlined
                        : action == "Report Incident"
                            ? Icons.report_outlined
                            : Icons.lightbulb_outline,
                    color: action == "Emergency Call"
                        ? const Color(0xFFFF4B4B)
                        : action == "Report Incident"
                            ? const Color(0xFFFFB74D)
                            : const Color(0xFF4CAF50),
                  ),
                  title: Text(
                    action,
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? const Color(0xFF0A2164) : Colors.white,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Preventionpage()),
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
        selectedItemColor: isDark ? Colors.white : Colors.blue,
        unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
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
