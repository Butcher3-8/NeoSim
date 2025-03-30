import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _usersKey = 'users';
  static const String _loggedInUserKey = 'loggedInUser';

  // Kullanıcıyı kaydet
  static Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Mevcut kullanıcıları al
    Map<String, String> users = {};
    if (prefs.containsKey(_usersKey)) {
      users = Map<String, String>.from(jsonDecode(prefs.getString(_usersKey)!));
    }
    
    // Kullanıcıyı ekle
    users[email] = password;
    
    // Güncellenmiş kullanıcıları kaydet
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  // Kullanıcıyı giriş yaptır
  static Future<Map<String, String>?> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(_usersKey)) return null;

    Map<String, String> users = Map<String, String>.from(jsonDecode(prefs.getString(_usersKey)!));

    if (users.containsKey(email) && users[email] == password) {
      return {'email': email, 'password': password}; // Başarılı giriş
    }
    
    return null; // Kullanıcı bulunamadı
  }

  // Şu anki giriş yapan kullanıcıyı al
  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loggedInUserKey);
  }

  // Kullanıcıyı girişte sakla
  static Future<void> setCurrentUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInUserKey, email);
  }

  // Çıkış işlemi
  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserKey);
  }
}
