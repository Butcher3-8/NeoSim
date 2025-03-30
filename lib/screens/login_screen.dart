import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/storage_helper.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoginMode = true; // Giriş ve kayıt formu arasında geçişi kontrol eder

  @override
  void initState() {
    super.initState();
  }

  // Şifre doğrulama
  String? validatePassword(String password) {
    if (password.length < 8) return "Şifre en az 8 karakter olmalıdır";
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "Şifre büyük harf içermelidir";
    if (!RegExp(r'[a-z]').hasMatch(password)) return "Şifre küçük harf içermelidir";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Şifre en az bir rakam içermelidir";
    return null;
  }

  // Giriş fonksiyonu
void login() async {
  String email = emailController.text;
  String password = passwordController.text;

  final user = await StorageHelper.loginUser(email, password);

  if (user != null) {
    await StorageHelper.setCurrentUser(email); // Kullanıcıyı kaydet
    context.go('/profile'); // GoRouter ile yönlendirme
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Böyle bir kullanıcı bulunamadı")));
  }
}

  // Kayıt olma fonksiyonu
void register() async {
  String name = nameController.text;
  String email = emailController.text;
  String password = passwordController.text;
  String confirmPassword = confirmPasswordController.text;

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifreler uyuşmuyor")));
    return;
  }

  String? passwordError = validatePassword(password);
  if (passwordError != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(passwordError)));
    return;
  }

  // Kullanıcıyı kaydet
  await StorageHelper.saveUser(email, password);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Başarıyla Kayıt Oldunuz")));
  setState(() {
    isLoginMode = true; // Kayıt işleminden sonra giriş ekranına dön
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLoginMode ? 'Giriş Yap' : 'Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isLoginMode) 
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Ad Soyad'),
              ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre'),
            ),
            if (!isLoginMode) 
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Şifre Tekrar'),
              ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoginMode ? login : register,
              child: Text(isLoginMode ? 'Giriş Yap' : 'Kayıt Ol'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800, // Profil ekranındaki renk ile uyumlu
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  isLoginMode = !isLoginMode; // Kayıt ve giriş ekranları arasında geçiş yap
                });
              },
              child: Text(isLoginMode ? 'Hesabınız yok mu? Kayıt olun' : 'Zaten bir hesabınız var mı? Giriş yapın'),
            ),
          ],
        ),
      ),
    );
  }
}
