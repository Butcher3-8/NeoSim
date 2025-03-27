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

    // 9 saniye sonra '/home' rotasına yönlendirme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          context.go('/home'); 
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
           
            SizedBox(
              width: 300,
              height: 300, 
              child: Lottie.asset(
                'assets/motions/loading.json', 
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 40), 

           
            const Text(
              "NEO SIM",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 255, 255, 255),
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.center, 
            ),

          
            Padding(
              padding: const EdgeInsets.only(bottom: 200.0), 
            ),
          ],
        ),
      ),
    );
  }
}
