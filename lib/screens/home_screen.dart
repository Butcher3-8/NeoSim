import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navigation_bar.dart'; // Alt menü widget'ını ekleyin

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Başlangıçta "Mağaza" seçili
  bool isLocalSelected = true; // Başlangıçta Yerel eSIM'ler seçili

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Aynı sekmeye tıklanırsa yönlendirme yapma

    setState(() {
      _selectedIndex = index;
    });

    // GoRouter ile yönlendirme
    if (index == 0) {
      context.go('/home'); // Mağaza
    } else if (index == 1) {
      context.go('/my_esim'); // Simlerim
    } else if (index == 2) {
      context.go('/profile'); // Profil
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 42, 63),
      body: Column(
        children: [
          // Üst Menü (Hoşgeldiniz + Giriş Yap Butonu + Arama Çubuğu + Butonlar)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 20, 50, 75), // Arka plan rengi
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
                // Hoşgeldiniz + Giriş Yap
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hoşgeldiniz Yazısı
                    const Text(
                      'Hoşgeldiniz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24, // Biraz büyütüldü
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    // Giriş Yap Butonu
                    TextButton(
                      onPressed: () {
                        print("Giriş Yap butonuna tıklandı");
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                      ),
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16), // Hoşgeldiniz ile arama çubuğu arasına boşluk eklendi

                // Arama Çubuğu
                Container(
                  height: 45, // Biraz daha büyük yapıldı
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Ara...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10, top: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Arama çubuğu ile butonlar arasına boşluk eklendi

                // eSIM Butonları
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Yerel eSIM Butonu
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLocalSelected = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLocalSelected ? Colors.blueAccent : Colors.grey[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Yerel eSIM'ler",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12), // Butonlar arasındaki boşluk artırıldı
                    // Global eSIM Butonu
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLocalSelected = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLocalSelected ? Colors.grey[700] : Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Global eSIM'ler",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // Üst menü ile içerik arasına boşluk eklendi

          // Sayfa İçeriği (Yerel veya Global eSIM)
          Expanded(
            child: Center(
              child: isLocalSelected
                  ? const Text(
                      'Yerel eSIM İçeriği',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : const Text(
                      'Global eSIM İçeriği',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
            ),
          ),
        ],
      ),

      // Alt Menü
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
