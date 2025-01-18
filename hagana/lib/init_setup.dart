import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// const credStorage = FlutterSecureStorage();

class SecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';

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

  Future<bool> checkCreds() async{
    try{
      String? email = await getUserName();
      String? pass = await getPassWord();
      if (email!.isEmpty || pass!.isEmpty){
        return true;
      }
      return false;
    } catch(e){
      return false;
    }
  }
}