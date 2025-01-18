import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagana/pages/CommunityPage.dart';
// import 'package:hagana/pages/CommunityPage.dart';
import 'package:hagana/pages/HomePage.dart';
import 'package:hagana/pages/LoginPage.dart';
import 'package:hagana/pages/SignUp.dart';
// import 'package:hagana/pages/Homepage.dart';
// import '../error_boundary.dart';

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
        MaterialPageRoute(builder: (context) =>  HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(222, 225, 230, 1.0),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Center(
                child: Text(
                  "Hagana",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.allura(
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(23, 26, 31, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 47.0,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
