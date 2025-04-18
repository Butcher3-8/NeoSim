import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';  // easy_localization importu

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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.store),
            label: 'store'.tr(),  // 'store' anahtarını easy_localization ile çevir
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: 'profile'.tr(),  // 'profile' anahtarını easy_localization ile çevir
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
