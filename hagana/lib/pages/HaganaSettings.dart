import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HaganaHomeScreen.dart';
import 'Preventionpage.dart';
import 'CommunityPage.dart';
import 'HaganaProfilePage.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';

class HaganaSettings extends StatefulWidget {
  const HaganaSettings({super.key});

  @override
  State<HaganaSettings> createState() => _HaganaSettingsState();
}

class _HaganaSettingsState extends State<HaganaSettings> {
  bool _notificationsEnabled = true;

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
          "Settings",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.white : Colors.black87,
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          _buildSection("PROFILE", isDark, [
            _buildTile(
              icon: Icons.person_outline,
              title: "Edit Profile",
              isDark: isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HaganaProfilePage()),
                );
              },
            ),
          ]),
          _buildSection("APP SETTINGS", isDark, [
            _buildSwitchTile(
              icon: Icons.notifications_outlined,
              title: "Notifications",
              value: _notificationsEnabled,
              isDark: isDark,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              value: themeProvider.isDarkMode,
              isDark: isDark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(value);
              },
            ),
          ]),
          _buildSection("PRIVACY", isDark, [
            _buildTile(
              icon: Icons.security_outlined,
              title: "Privacy Settings",
              isDark: isDark,
              onTap: () {
                // Add your logic here.
              },
            ),
          ]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? const Color(0xFF051650) : Colors.white,
        currentIndex: 3,
        elevation: 0,
        selectedItemColor: const Color(0xFF4B7BEC),
        unselectedItemColor: isDark ? Colors.white54 : Colors.black54,
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

  Widget _buildSection(String title, bool isDark, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: const Color(0xFF4B7BEC)),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: const Color(0xFF4B7BEC)
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required bool isDark,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: const Color(0xFF4B7BEC)),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF4B7BEC),
        inactiveTrackColor: isDark ? Colors.white24 : Colors.black12,
      ),
    );
  }
}