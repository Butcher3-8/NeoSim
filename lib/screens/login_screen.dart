import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/storage_helper.dart';
import 'package:go_router/go_router.dart';
 // StorageHelper dosyanı eklemeyi unutma!

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true; // Varsayılan olarak giriş ekranı gösterilecek

  // Kayıt Formu İçin Controller'lar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Hata Mesajlarını Tutacak Değişkenler
  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Uygulama logosu
            Center(
              child: Image.asset(
                'assets/icons/logosimm.png',
                width: 300,
                height: 200,
              ),
            ),
            const SizedBox(height: 40),

            // Giriş Yap / Kayıt Ol Butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton('Giriş Yap', isLogin, () {
                  setState(() {
                    isLogin = true;
                  });
                }),
                const SizedBox(width: 20),
                _buildTabButton('Kayıt Ol', !isLogin, () {
                  setState(() {
                    isLogin = false;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Giriş yapma ve kayıt formu
            isLogin ? _buildLoginForm() : _buildRegisterForm(),
          ],
        ),
      ),
    );
  }

  // Giriş ve Kayıt Ol Butonları İçin Ortak Widget
  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.grey,
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }

  // Giriş Formu
  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildTextField('E-posta', emailController),
        const SizedBox(height: 16),
        _buildTextField('Şifre', passwordController, obscureText: true),
        const SizedBox(height: 16),
        _buildActionButton('Giriş Yap', _loginUser),
      ],
    );
  }

  // Kayıt Formu
  Widget _buildRegisterForm() {
    return Column(
      children: [
        _buildTextField('Ad Soyad', nameController, errorText: nameError),
        const SizedBox(height: 16),
        _buildTextField('E-posta', emailController, errorText: emailError),
        const SizedBox(height: 16),
        _buildTextField('Şifre', passwordController, obscureText: true, errorText: passwordError),
        const SizedBox(height: 16),
        _buildTextField('Şifre Tekrar', confirmPasswordController, obscureText: true, errorText: confirmPasswordError),
        const SizedBox(height: 16),
        _buildActionButton('Kayıt Ol', _validateAndRegister),
      ],
    );
  }

  // Ortak TextField Widget'ı
  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false, String? errorText}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorText: errorText,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  // Ortak Buton Widget'ı
  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 28, 28, 28), // Buton rengi
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  // Şifre kurallarını kontrol eden fonksiyon
  bool _isPasswordValid(String password) {
    return password.length >= 8 && RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
  }

  // Kayıt Ol Butonuna Basıldığında Kontrolleri Yap
  void _validateAndRegister() async {
    setState(() {
      nameError = nameController.text.isEmpty ? "Ad Soyad girmeyi unutmayınız" : null;
      emailError = emailController.text.isEmpty ? "E-posta girmeyi unutmayınız" : null;
      passwordError = !_isPasswordValid(passwordController.text)
          ? "Şifrenizin 8 karakterden uzun olmasına ve büyük küçük harf içerdiğinden emin olunuz"
          : null;
      confirmPasswordError = confirmPasswordController.text != passwordController.text
          ? "Şifreler eşleşmiyor"
          : null;
    });

    if (nameError == null && emailError == null && passwordError == null && confirmPasswordError == null) {
      // Kullanıcıyı kaydet
      await StorageHelper.saveUser(emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt başarılı! Giriş yapabilirsiniz.")),
      );
      setState(() {
        isLogin = true;
      });
    }
  }

  // Kullanıcı Giriş Yapınca Kontrol ve Yönlendirme
  void _loginUser() async {
    Map<String, String?> userData = await StorageHelper.getUser();

    if (emailController.text == userData['username'] &&
        passwordController.text == userData['password']) {
      context.go('/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-posta veya şifre hatalı!')),
      );
    }
  }
}
