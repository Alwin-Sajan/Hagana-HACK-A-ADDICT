import 'package:flutter/material.dart';
import 'HaganaHomeScreen.dart';
import 'CommunityPage.dart';
import 'HaganaSettings.dart';

class Preventionpage extends StatefulWidget {
  const Preventionpage({super.key});

  @override
  State<Preventionpage> createState() => _PreventionpageState();
}

class _PreventionpageState extends State<Preventionpage> {
  final _pages = const [
    HaganaHomeScreen(),
    Preventionpage(),
    CommunityPage(),
    HaganaSettings()
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:
              const Text("Prevention", style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Stay Safe, Stay Smart",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Learn essential prevention strategies for your safety"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Prevention Strategies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...[
              {
                "title": "Personal Safety",
                "icon": Icons.shield,
                "color": Colors.blue
              },
              {
                "title": "Digital Security",
                "icon": Icons.security,
                "color": Colors.green
              },
              {
                "title": "Community Safety",
                "icon": Icons.people,
                "color": Colors.purple
              },
            ]
                .map((item) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(item["icon"] as IconData,
                            color: item["color"] as Color),
                        title: Text(item["title"] as String),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ))
                .toList(),
            const SizedBox(height: 20),
            const Text("Emergency Contacts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...[
              {
                "title": "Police Emergency",
                "number": "911",
                "icon": Icons.local_police
              },
              {
                "title": "Hagana Hotline",
                "number": "1-800-HAGANA",
                "icon": Icons.phone
              },
            ]
                .map((contact) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(contact["icon"] as IconData,
                            color: Colors.red),
                        title: Text(contact["title"] as String),
                        subtitle: Text(contact["number"] as String),
                        trailing: IconButton(
                          icon: const Icon(Icons.phone, color: Colors.green),
                          onPressed: () {},
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HaganaHomeScreen()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommunityPage()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HaganaSettings()),
                );
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety), label: "Prevention"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "Community"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      );
}