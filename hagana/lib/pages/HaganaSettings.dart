import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HaganaHomeScreen.dart';
import 'Preventionpage.dart';
import 'CommunityPage.dart';
import 'HaganaProfilePage.dart';

class HaganaSettings extends StatefulWidget {
  const HaganaSettings({super.key});

  @override
  State<HaganaSettings> createState() => _HaganaSettingsState();
}

class _HaganaSettingsState extends State<HaganaSettings> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF051650),
      appBar: AppBar(
        backgroundColor: const Color(0xFF051650),
        elevation: 0,
        title: Text(
          "Settings",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          _buildSection("PROFILE", [
            _buildTile(
              icon: Icons.person_outline,
              title: "Edit Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HaganaProfilePage()),
                );
              },
            ),
          ]),
          _buildSection("APP SETTINGS", [
            _buildSwitchTile(
              icon: Icons.notifications_outlined,
              title: "Notifications",
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
          ]),
          _buildSection("PRIVACY", [
            _buildTile(
              icon: Icons.security_outlined,
              title: "Privacy Settings",
              onTap: () {
                // Add your logic here.
              },
            ),
          ]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF051650),
        currentIndex: 3,
        elevation: 0,
        selectedItemColor: const Color(0xFF4B7BEC),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HaganaHomeScreen()),
              );
              break;
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
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety_outlined),
              label: "Prevention"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: "Community"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Settings"),
        ],
      ),
    );
  }
}