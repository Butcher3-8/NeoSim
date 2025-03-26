import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
//import '../widgets/bottom_navigation_bar.dart'; // Alt menü widget'ını ekleyin

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
        backgroundColor: const Color.fromARGB(255, 16, 42, 63),
        title: const Text('Simlerim'),
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
