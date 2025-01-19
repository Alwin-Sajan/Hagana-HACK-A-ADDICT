import 'package:flutter/material.dart';
import 'package:hagana/pages/HaganaHomeScreen.dart';
import 'package:hagana/pages/HomePage.dart';
import 'package:hagana/init_setup.dart'; // Assuming this is where SecureStorage is defined.

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and the animations
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Set animation duration
      vsync: this,
    )..forward(); // Start the animation immediately

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start off the left side of the screen
      end: Offset.zero, // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Ease-in-out transition
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Ease-in-out transition
    ));

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
  void dispose() {
    // Dispose the animation controller when done
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF051650), // Background color #051650
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/hagana_logo.png',
                    width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
