import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Bottom navigation bar'da hangi sekmenin seçili olduğunu belirlemek için
  int _selectedIndex = 1; // Başlangıçta "Simlerim" seçili

  // Her bir sekme için ekranda ne gösterileceği
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 42, 63), // Arka plan rengini buraya ekledik
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 42, 63), // AppBar rengini aynı yaptık
        title: const Text('Home Screen'),
      ),
      body: Center(
        // Seçilen sekmeye göre içerik gösterme
        child: _selectedIndex == 0
            ? const Text('Mağaza', style: TextStyle(color: Colors.white, fontSize: 24))
            : _selectedIndex == 1
                ? const Text('Simlerim', style: TextStyle(color: Colors.white, fontSize: 24))
                : const Text('Profil', style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 42, 63), // Aynı renk ile alt menü
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ), // Üst köşelerde yuvarlatma
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0), // Hafif gölge efekti
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, -2), // Alt menünün yukarı doğru hafif yükselmesini sağlıyor
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Arka planı şeffaf yapıyoruz
          selectedItemColor: Colors.white, // Seçili öğe rengi
          unselectedItemColor: Colors.grey, // Seçili olmayan öğe rengi
          currentIndex: _selectedIndex, // Seçilen sekme
          onTap: _onItemTapped, // Sekmeye tıklandığında yapılacak işlem
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.store), // Mağaza ikonu
              label: 'Mağaza',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sim_card), // Simlerim ikonu
              label: 'Simlerim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), // Profil ikonu
              label: 'Profil',
            ),
          ],
          // Tıklama efektini kaldırmak için
          type: BottomNavigationBarType.fixed, // Tıklama animasyonunu kaldırmak için
          elevation: 0, // Elevation'ı sıfırladık, tıklama efektini etkileyebilir
        ),
      ),
    );
  }
}
