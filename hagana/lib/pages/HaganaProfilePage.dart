import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';

class HaganaProfilePage extends StatelessWidget {
  const HaganaProfilePage({super.key});

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isDark,
      {bool isOptional = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        maxLines: maxLines,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label + (isOptional ? " (Optional)" : ""),
          labelStyle: GoogleFonts.inter(
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          filled: true,
          fillColor: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[50],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.inter(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save profile changes
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFF4B7BEC),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: isDark ? Colors.white24 : Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: isDark ? Colors.white : Colors.black54,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF4B7BEC),
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Handle profile picture update
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Basic Information Section
              _buildSectionTitle("Basic Information", isDark),
              _buildTextField("Full Name", isDark),
              _buildTextField("Nickname", isDark),
              _buildTextField("Phone Number", isDark, isOptional: true),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: isDark ? Colors.black : Colors.white,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Gender",
                    labelStyle: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white24 : Colors.black12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[50],
                  ),
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  dropdownColor: isDark ? Colors.black : Colors.white,
                  items: ["Male", "Female", "Other", "Prefer not to say"]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
              ),
              const SizedBox(height: 20),

              // Personal Details Section
              _buildSectionTitle("Personal Details", isDark),
              _buildTextField("Bio", isDark, maxLines: 3),
              _buildTextField("Hobbies & Interests", isDark, maxLines: 2),
              _buildTextField("Location", isDark, isOptional: true),

              // Contact Information Section
              _buildSectionTitle("Contact Information", isDark),
              _buildTextField("Email", isDark),
              _buildTextField("Emergency Contact", isDark, isOptional: true),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
