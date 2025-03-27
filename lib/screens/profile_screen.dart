import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

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
          // Üst Menü (Profil yazısı burada!)
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
                const SizedBox(height: 90), // Profil yazısını aşağı kaydıran boşluk

                // Profil başlığı
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profil',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical:100), // Yukarıdaki boşluk burada artırıldı
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 45, 45, 45), // Buton arka plan rengi
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Giriş yap veya kaydol işlemi yapılacak
                print('Giriş Yap / Kaydol tıklandı');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "Giriş Yap / Kaydol" Yazısı
                  const Text(
                    'Giriş Yap / Kaydol',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  // Profil İkonu (Sağda)
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 80,
                  ),
                ],
              ),
            ),
          ),

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
