import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45,45,45),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(100, 0, 0, 0),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Mağaza',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sim_card),
            label: 'Simlerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
