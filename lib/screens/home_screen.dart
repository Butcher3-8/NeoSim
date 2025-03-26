import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
//import '../widgets/bottom_navigation_bar.dart'; // Alt menü widget'ını ekleyin

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Başlangıçta "Simlerim" seçili

  void _onItemTapped(int index) {
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 42, 63),
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: _selectedIndex == 0
            ? const Text('Mağaza', style: TextStyle(color: Colors.white, fontSize: 24))
            : _selectedIndex == 1
                ? const Text('Simlerim', style: TextStyle(color: Colors.white, fontSize: 24))
                : const Text('Profil', style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
