import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool isLocalSelected = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // En Çok Tercih Edilen Ülkeler Listesi
  final List<Map<String, String>> popularEsims = [
    {'name': 'Almanya', 'image': 'assets/flags/germany.png'},
    {'name': 'Birleşik Krallık', 'image': 'assets/flags/united-kingdom.png'},
    {'name': 'Türkiye', 'image': 'assets/flags/turkey.png'},
    {'name': 'Arnavutluk', 'image': 'assets/flags/albania.png'},
    {'name': 'İspanya', 'image': 'assets/flags/spain.png'},
    {'name': 'Fransa', 'image': 'assets/flags/france.png'},
    {'name': 'İtalya', 'image': 'assets/flags/italy.png'},
    {'name': 'Kuzey Kıbrıs Türk Cumhuriyeti', 'image': 'assets/flags/northern-cyprus.png'},
    {'name': 'Kuzey Makedonya', 'image': 'assets/flags/republic-of-macedonia.png'},

   
    
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);
  }

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
          // Üst Menü
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hoşgeldiniz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
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
                const SizedBox(height: 16),

                // Arama Çubuğu
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "150'den fazla ülkede hızlı veri kullanımı...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10, top: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),

          // En Çok Tercih Edilenler Başlığı
Align(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    child: Text(
      'En Çok Tercih Edilenler',
      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ),
),

          // Ülke Butonları
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: popularEsims.length,
              itemBuilder: (context, index) {
                final country = popularEsims[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      print("${country['name']} eSIM alındı");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          country['image']!,
                          width: 32,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          country['name']!,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
