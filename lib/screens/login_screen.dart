import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true; // Varsayılan olarak giriş ekranı gösterilecek

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Giriş Yap / Kayıt Ol'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: isLogin ? Colors.white : Colors.grey,
                  ),
                  child: const Text('Giriş Yap', style: TextStyle(fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: !isLogin ? Colors.white : Colors.grey,
                  ),
                  child: const Text('Kayıt Ol', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLogin ? _buildLoginForm() : _buildRegisterForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'E-posta',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Şifre',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Giriş işlemi
          },
          child: const Text('Giriş Yap'),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Ad Soyad',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'E-posta',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Şifre',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Kayıt işlemi
          },
          child: const Text('Kayıt Ol'),
        ),
      ],
    );
  }
}
