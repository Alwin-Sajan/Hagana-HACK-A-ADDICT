import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hagana/main.dart';
import 'package:hagana/init_setup.dart';
import 'package:hagana/pages/HomePage.dart';

class HaganaProfilePage extends StatefulWidget {
  const HaganaProfilePage({super.key});

  @override
  State<HaganaProfilePage> createState() => _HaganaProfilePageState();
}

class _HaganaProfilePageState extends State<HaganaProfilePage> {
  final _secureStorage = SecureStorage();
  bool _isLoading = false;
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _emergencyPhoneController =
      TextEditingController();

  // Profile preferences
  bool _isAnonymous = true;
  bool _enableNotifications = true;
  bool _enableLocationSharing = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() => _isLoading = true);
    try {
      final profileData = await _secureStorage.getAllProfileData();

      _nicknameController.text = profileData['nickName'] ?? '';
      _fullNameController.text = profileData['fullName'] ?? '';
      _emailController.text = await _secureStorage.getUserName() ?? '';
      _phoneController.text = profileData['phoneNumber'] ?? '';
      _emergencyContactController.text = profileData['emergencyContact'] ?? '';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        await _secureStorage.setNickName(_nicknameController.text);
        await _secureStorage.setFullName(_fullNameController.text);
        await _secureStorage.setPhoneNumber(_phoneController.text);
        await _secureStorage
            .setEmergencyContact(_emergencyContactController.text);

        setState(() => _isEditing = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  // Add a logout method
  Future<void> _handleLogout() async {
    try {
      await _secureStorage.setLoggedIn(false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

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
          "Profile",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
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
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveProfile,
            )
          else
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Avatar
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          isDark ? Colors.white24 : Colors.blue.shade100,
                      child: Text(
                        _nicknameController.text.isNotEmpty
                            ? _nicknameController.text[0].toUpperCase()
                            : "?",
                        style: TextStyle(
                          fontSize: 36,
                          color: isDark ? Colors.white : Colors.blue,
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: isDark ? Colors.white : Colors.blue,
                          radius: 18,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: isDark ? Colors.black : Colors.white,
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
              const SizedBox(height: 24),

              // Profile Fields
              _buildProfileSection(
                "Basic Information",
                [
                  _buildTextField(
                    "Nickname",
                    _nicknameController,
                    isDark,
                    required: true,
                    enabled: _isEditing,
                  ),
                  _buildTextField(
                    "Full Name (Optional)",
                    _fullNameController,
                    isDark,
                    enabled: _isEditing,
                  ),
                  _buildTextField(
                    "Email",
                    _emailController,
                    isDark,
                    required: true,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    "Phone",
                    _phoneController,
                    isDark,
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Emergency Contact
              _buildProfileSection(
                "Emergency Contact",
                [
                  _buildTextField(
                    "Contact Name",
                    _emergencyContactController,
                    isDark,
                    enabled: _isEditing,
                  ),
                  _buildTextField(
                    "Contact Phone",
                    _emergencyPhoneController,
                    isDark,
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Preferences
              _buildProfileSection(
                "Preferences",
                [
                  _buildSwitchTile(
                    "Stay Anonymous",
                    "Hide your full name from other users",
                    _isAnonymous,
                    isDark,
                    (value) {
                      if (_isEditing) {
                        setState(() => _isAnonymous = value);
                      }
                    },
                  ),
                  _buildSwitchTile(
                    "Enable Notifications",
                    "Get important updates and reminders",
                    _enableNotifications,
                    isDark,
                    (value) {
                      if (_isEditing) {
                        setState(() => _enableNotifications = value);
                      }
                    },
                  ),
                  _buildSwitchTile(
                    "Location Sharing",
                    "Share location with emergency contacts",
                    _enableLocationSharing,
                    isDark,
                    (value) {
                      if (_isEditing) {
                        setState(() => _enableLocationSharing = value);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Danger Zone
              _buildProfileSection(
                "Account Actions",
                [
                  TextButton.icon(
                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                    label: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: _isEditing
                        ? () {
                            // Show delete confirmation dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: isDark
                                    ? const Color(0xFF0A2164)
                                    : Colors.white,
                                title: Text(
                                  "Delete Account",
                                  style: TextStyle(
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                content: Text(
                                  "Are you sure you want to delete your account? This action cannot be undone.",
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      // Handle account deletion
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDark, {
    bool enabled = true,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.white : Colors.blue,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
          ),
        ),
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    bool isDark,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.black54,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }
}
