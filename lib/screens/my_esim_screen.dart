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
      backgroundColor: const Color.fromARGB(255, 16, 42, 63),
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 42, 63), // AppBar rengini aynı yaptık
        title: const Text(
          'E-Simlerim',
          style: TextStyle(
            color: Colors.white, // Beyaz renk
            fontSize: 22, // Font boyutu büyütüldü
            fontWeight: FontWeight.bold, // Kalın yazı
            letterSpacing: 1.2, // Harf aralığı artırıldı
          ),
        ),
        actions: [
          // Sağ üst köşeye şeffaf bir "Giriş Yap" butonu ekliyoruz
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                // Burada giriş yap butonuna tıklandığında yapılacak işlemi ekleyebilirsiniz
                print("Giriş Yap butonuna tıklandı");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Arka planı şeffaf yapıyoruz
                side: const BorderSide(color: Colors.white, width: 2), // Beyaz kenarlık ekliyoruz
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Yuvarlatılmış köşeler
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // İç boşluk
              ),
              child: const Text(
                'Giriş Yap',
                style: TextStyle(fontSize: 16), // Yazı boyutu
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Simlerim Ekranı',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
