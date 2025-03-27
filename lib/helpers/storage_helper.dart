import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Önce var olan kullanıcıları al
    String? usersJson = prefs.getString('users');
    List<Map<String, String>> users = usersJson != null
        ? List<Map<String, String>>.from(jsonDecode(usersJson))
        : [];

    // Aynı e-posta ile kayıtlı kullanıcı var mı kontrol et
    bool userExists = users.any((user) => user['email'] == email);
    if (!userExists) {
      users.add({'email': email, 'password': password});
      await prefs.setString('users', jsonEncode(users));
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');

    if (usersJson != null) {
      List<Map<String, String>> users = List<Map<String, String>>.from(jsonDecode(usersJson));
      
      // Kullanıcı bilgilerini kontrol et
      for (var user in users) {
        if (user['email'] == email && user['password'] == password) {
          await prefs.setString('currentUser', email); // Giriş yapanı sakla
          return true;
        }
      }
    }
    return false;
  }

  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser'); // Sadece oturumu kapat, kullanıcıları silme!
  }

  static Future<Map<String, String>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('currentUser');
    String? usersJson = prefs.getString('users');

    if (email != null && usersJson != null) {
      List<Map<String, String>> users = List<Map<String, String>>.from(jsonDecode(usersJson));
      return users.firstWhere((user) => user['email'] == email, orElse: () => {});
    }
    return null;
  }

  static getUser() {}

  static clearUser() {}
}
