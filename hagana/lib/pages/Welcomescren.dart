import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagana/pages/CommunityPage.dart';
import 'package:hagana/pages/HomePage.dart';
import 'package:hagana/pages/LoginPage.dart';
import 'package:hagana/pages/SignUp.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  void initState() {
    super.initState();

    // Wait for a short duration before navigating to HomeScreen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF051650), // New background color #051650
        ),
        child: Center(
          child: Image.asset(
            'assets/images/hagana_logo.png',
            width: MediaQuery.of(context).size.width *
                1.0, // Increased from 0.8 to 0.9 (90% of screen width)
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
