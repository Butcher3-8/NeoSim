import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // 1.5 saniye sonra '/home' rotasına yönlendirme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          context.go('/home'); // GoRouter ile yönlendirme
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animasyonu (Büyütüldü)
            SizedBox(
              width: 500,
              height: 500,
              child: Lottie.asset(
                'assets/motions/logo.json', // Lottie dosya yolu
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 40),

            // Yükleniyor yazısı
        
          ],
        ),
      ),
    );
  }
}
