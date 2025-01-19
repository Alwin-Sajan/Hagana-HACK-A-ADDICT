import 'package:flutter/material.dart';
import 'package:hagana/init_setup.dart';
import 'package:hagana/pages/HomePage.dart';
import 'package:hagana/pages/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';
import 'package:hagana/pages/HaganaProfilePage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
  bool isChecked = false;
  String email = "";
  String password = "";
  final _secureStorage = SecureStorage();
  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    if (email.isNotEmpty && password.isNotEmpty && isChecked) {
      setState(() => _isLoading = true);

      try {
        await _secureStorage.setUserName(email);
        await _secureStorage.setPassWord(password);
        await _secureStorage.setLoggedIn(true);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HaganaProfilePage(),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please fill all fields and accept Terms & Conditions.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF051650) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HaganaProfilePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "Hagana Register",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A237E) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  // Email Field
                  Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) => email = value,
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark ? Color(0xFF283593) : Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) => password = value,
                    obscureText: true,
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark ? Color(0xFF283593) : Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: Color(0xFF4B7BEC),
                        checkColor: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          "I agree with Terms & Conditions",
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A1A80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 16),

                  // OR SIGN UP WITH
                  Center(
                    child: Text(
                      "OR SIGN UP WITH",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Social Media Text
                  Center(
                    child: Text(
                      "using Google",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Already have an account?
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4B7BEC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32), // Bottom margin
          ],
        ),
      ),
    );
  }
}
