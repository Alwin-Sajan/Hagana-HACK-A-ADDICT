import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagana/pages/CommunityPage.dart';
import 'package:hagana/pages/HomePage.dart';
import 'package:hagana/pages/LoginPage.dart';
import 'package:hagana/pages/SignUp.dart';
import 'package:hagana/init_setup.dart';
import 'package:hagana/pages/HaganaHomeScreen.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();

    // Check if user is already logged in
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await _secureStorage.isLoggedIn();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const HaganaHomeScreen() : const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF051650), // Background color #051650
        ),
        child: Center(
          child: Image.asset(
            'assets/images/hagana_logo.png',
            width:
                MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
