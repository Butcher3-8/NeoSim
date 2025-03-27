import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navigation_bar.dart'; // Alt menü widget'ını ekleyin

class MyEsimScreen extends StatefulWidget {
  const MyEsimScreen({super.key});

  @override
  _MyEsimScreenState createState() => _MyEsimScreenState();
}

class _MyEsimScreenState extends State<MyEsimScreen> {
  int _selectedIndex = 1; // Başlangıçta "Simlerim" seçili

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      context.go('/home');
    } else if (index == 1) {
      context.go('/my_esim');
    } else if (index == 2) {
      context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Column(
        children: [
          // Üst Menü (E-SIMlerim başlığı burada)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 45, 45, 45),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 90), // Boşluk bırakıldı

                // "E-SIMlerim" Başlığı
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E-SIMlerim',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Boşluk bırakmak için
              ],
            ),
          ),

          // Giriş Yap / Kaydol Butonu


          // Sayfa içeriği
          Expanded(
            child: Center(
              child: Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
