import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  // Authentication keys
  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';
  final String _keyIsLoggedIn = 'isLoggedIn';

  // Profile keys
  final String _keyFullName = 'fullName';
  final String _keyNickName = 'nickName';
  final String _keyPhoneNumber = 'phoneNumber';
  final String _keyBio = 'bio';
  final String _keyGender = 'gender';
  final String _keyHobbies = 'hobbies';
  final String _keyLocation = 'location';
  final String _keyEmergencyContact = 'emergencyContact';

  // Authentication methods
  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }

  Future setLoggedIn(bool isLoggedIn) async {
    await storage.write(key: _keyIsLoggedIn, value: isLoggedIn.toString());
  }

  Future<bool> isLoggedIn() async {
    final value = await storage.read(key: _keyIsLoggedIn);
    return value == 'true';
  }

  Future<bool> checkCreds() async {
    try {
      String? email = await getUserName();
      String? pass = await getPassWord();
      if (email == null || pass == null || email.isEmpty || pass.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Profile methods
  Future setFullName(String? fullName) async {
    if (fullName != null && fullName.isNotEmpty) {
      await storage.write(key: _keyFullName, value: fullName);
    }
  }

  Future<String?> getFullName() async {
    return await storage.read(key: _keyFullName);
  }

  Future setNickName(String nickName) async {
    await storage.write(key: _keyNickName, value: nickName);
  }

  Future<String?> getNickName() async {
    return await storage.read(key: _keyNickName);
  }

  Future setPhoneNumber(String? phoneNumber) async {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      await storage.write(key: _keyPhoneNumber, value: phoneNumber);
    }
  }

  Future<String?> getPhoneNumber() async {
    return await storage.read(key: _keyPhoneNumber);
  }

  Future setBio(String? bio) async {
    if (bio != null && bio.isNotEmpty) {
      await storage.write(key: _keyBio, value: bio);
    }
  }

  Future<String?> getBio() async {
    return await storage.read(key: _keyBio);
  }

  Future setGender(String gender) async {
    await storage.write(key: _keyGender, value: gender);
  }

  Future<String?> getGender() async {
    return await storage.read(key: _keyGender);
  }

  Future setHobbies(List<String> hobbies) async {
    final hobbiesString = hobbies.join(',');
    await storage.write(key: _keyHobbies, value: hobbiesString);
  }

  Future<List<String>> getHobbies() async {
    final hobbiesString = await storage.read(key: _keyHobbies);
    if (hobbiesString == null || hobbiesString.isEmpty) {
      return [];
    }
    return hobbiesString.split(',');
  }

  Future setLocation(String? location) async {
    if (location != null && location.isNotEmpty) {
      await storage.write(key: _keyLocation, value: location);
    }
  }

  Future<String?> getLocation() async {
    return await storage.read(key: _keyLocation);
  }

  Future setEmergencyContact(String emergencyContact) async {
    await storage.write(key: _keyEmergencyContact, value: emergencyContact);
  }

  Future<String?> getEmergencyContact() async {
    return await storage.read(key: _keyEmergencyContact);
  }

  // Method to clear all user data (for logout)
  Future clearAll() async {
    await storage.deleteAll();
  }

  // Method to get all profile data at once
  Future<Map<String, String?>> getAllProfileData() async {
    return {
      'fullName': await getFullName(),
      'nickName': await getNickName(),
      'phoneNumber': await getPhoneNumber(),
      'bio': await getBio(),
      'gender': await getGender(),
      'hobbies': (await getHobbies()).join(','),
      'location': await getLocation(),
      'emergencyContact': await getEmergencyContact(),
    };
  }

  // Method to check if profile is complete
  Future<bool> isProfileComplete() async {
    final nickName = await getNickName();
    final gender = await getGender();

    // Only checking required fields
    return nickName != null &&
        nickName.isNotEmpty &&
        gender != null &&
        gender.isNotEmpty;
  }
}
