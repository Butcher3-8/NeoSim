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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.9, // Küçükten büyüğe animasyon
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

  void _toggleEsim(bool isLocal) {
    if (isLocalSelected == isLocal) return; // Aynı butona tıklanırsa işlem yapma

    setState(() {
      isLocalSelected = isLocal;
    });

    _controller.forward().then((_) => _controller.reverse()); // Scale animasyonu başlat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 42, 63),
      body: Column(
        children: [
          // Üst Menü
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 20, 50, 75),
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
                      hintText: "Ara...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10, top: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // eSIM Butonları (Scale Animasyon Eklenmiş)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleEsim(true),
                        child: ScaleTransition(
                          scale: isLocalSelected ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 50),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isLocalSelected ? const Color.fromRGBO(88, 24, 16, 1) : Colors.grey[700],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Yerel eSIM'ler",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleEsim(false),
                        child: ScaleTransition(
                          scale: !isLocalSelected ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !isLocalSelected ? const Color.fromRGBO(88, 24, 16, 1) : Colors.grey[700],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Global eSIM'ler",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Sayfa İçeriği (Yerel veya Global eSIM)
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: isLocalSelected
                  ? const Text(
                      'Yerel eSIM İçeriği',
                      key: ValueKey(1),
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : const Text(
                      'Global eSIM İçeriği',
                      key: ValueKey(2),
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
