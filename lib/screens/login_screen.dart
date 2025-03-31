import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/storage_helper.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String previousRoute; // Hangi sayfadan geldiğini takip etmek için

  LoginScreen({this.previousRoute = '/home'}); // Varsayılan olarak home sayfası

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoginMode = true; // Giriş ve kayıt formu arasında geçişi kontrol eder
  
  // Error handling
  String? errorMessage;
  bool showError = false;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    // Clean up controllers
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Hata gösterme fonksiyonu
  void showErrorMessage(String message) {
    setState(() {
      errorMessage = message;
      showError = true;
    });
    
    // 4 saniye sonra hata mesajını kaldır
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  // Şifre doğrulama
  String? validatePassword(String password) {
    if (password.length < 8) return "Şifre en az 8 karakter olmalıdır";
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "Şifre büyük harf içermelidir";
    if (!RegExp(r'[a-z]').hasMatch(password)) return "Şifre küçük harf içermelidir";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Şifre en az bir rakam içermelidir";
    return null;
  }

  // Email doğrulama
  String? validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return "Geçerli bir email adresi giriniz";
    return null;
  }

  // Giriş fonksiyonu
  void login() async {
    String email = emailController.text;
    String password = passwordController.text;
    
    // Email kontrolü
    if (email.isEmpty) {
      showErrorMessage("Email adresi giriniz");
      return;
    }
    
    String? emailError = validateEmail(email);
    if (emailError != null) {
      showErrorMessage(emailError);
      return;
    }
    
    // Şifre kontrolü
    if (password.isEmpty) {
      showErrorMessage("Şifre giriniz");
      return;
    }

    final user = await StorageHelper.loginUser(email, password);

    if (user != null) {
      await StorageHelper.setCurrentUser(email); // Kullanıcıyı kaydet
      context.go('/profile'); // GoRouter ile yönlendirme
    } else {
      showErrorMessage("Böyle bir kullanıcı bulunamadı");
    }
  }

  // Kayıt olma fonksiyonu
  void register() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty) {
      showErrorMessage("Ad Soyad giriniz");
      return;
    }
    
    if (email.isEmpty) {
      showErrorMessage("Email adresi giriniz");
      return;
    }
    
    String? emailError = validateEmail(email);
    if (emailError != null) {
      showErrorMessage(emailError);
      return;
    }
    
    if (password.isEmpty) {
      showErrorMessage("Şifre giriniz");
      return;
    }
    
    if (password != confirmPassword) {
      showErrorMessage("Şifreler uyuşmuyor");
      return;
    }

    String? passwordError = validatePassword(password);
    if (passwordError != null) {
      showErrorMessage(passwordError);
      return;
    }

    // Kullanıcıyı kaydet
    await StorageHelper.saveUser(email, password);

    // Başarı mesajı
    setState(() {
      errorMessage = "Başarıyla Kayıt Oldunuz";
      showError = true;
    });
    
    // 2 saniye sonra başarı mesajını kaldır ve giriş ekranına dön
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showError = false;
          isLoginMode = true; // Kayıt işleminden sonra giriş ekranına dön
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 28), // Arka plan rengi
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                     Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        context.go(widget.previousRoute); // Önceki sayfaya dön
                      },
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          
                          // Logo
                          Center(
                            child: Image.asset(
                              'assets/icons/logosimm.png', // Logo dosyanızın yolu
                              height: 250, // Logo yüksekliği
                              width: 400, // Logo genişliği
                            ),
                          ),
                          SizedBox(height: 20),
                          
                          // Kayıt olma formu
                          if (!isLoginMode)
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Ad Soyad',
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color.fromARGB(255, 45, 45, 45),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          if (!isLoginMode) SizedBox(height: 12),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Color.fromARGB(255, 45, 45, 45),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Şifre',
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Color.fromARGB(255, 45, 45, 45),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 12),
                          if (!isLoginMode) 
                            TextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Şifre Tekrar',
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color.fromARGB(255, 45, 45, 45),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: isLoginMode ? login : register,
                            child: Text(
                              isLoginMode ? 'Giriş Yap' : 'Kayıt Ol',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 45, 45, 45),
                              foregroundColor: Colors.white, 
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 5,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginMode = !isLoginMode; // Kayıt ve giriş ekranları arasında geçiş yap
                                // Geçiş yaparken hata mesajını temizle
                                showError = false;
                              });
                            },
                            child: Text(
                              isLoginMode ? 'Hesabınız yok mu? Kayıt olun' : 'Zaten bir hesabınız var mı? Giriş yapın',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Disclaimer text positioned at the bottom
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Tüm verileriniz NEO SIM ŞİRKETİ tarafından profesyonel bir şekilde saklanıp korunmaktadır.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            
            // Animated Error Message
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: showError ? 20 : -100, // Show from top or hide above screen
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: errorMessage?.contains("Başarıyla") == true 
                        ? Colors.green.shade800 
                        : Colors.red.shade800,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        errorMessage?.contains("Başarıyla") == true 
                            ? Icons.check_circle 
                            : Icons.error_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          errorMessage ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showError = false;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}