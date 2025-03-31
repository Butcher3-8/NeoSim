import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../helpers/storage_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  int _selectedIndex = 1; // Bottom navigation için seçili index (Profil sekmesi)
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      context.go('/home');
    } else if (index == 2) {
      
    } else if (index == 1) {
      context.go('/profile');
    }
  }

  Future<void> _loadUserData() async {
    try {
      String? email = await StorageHelper.getCurrentUser();
      setState(() {
        userName = email; // Kullanıcı adı olarak email göster
      });
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Column(
        children: [
          _buildProfileHeader(),
          userName == null ? _buildLoginButton() : _buildUserProfile(),
          _buildSettingsSection(),
          const Spacer(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
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
      child: const Column(
        children: [
          SizedBox(height: 90),
          Align(
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
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          context.go('/login');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Giriş Yap / Kaydol',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 45, 45),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.account_circle, color: Colors.white, size: 80),
              ],
            ),
            const SizedBox(height: 20),
            _buildSettingsButton("Hesap Bilgileri", () {}),
            _buildDivider(),
            _buildSettingsButton("Kayıtlı Kartlarım", () {}),
            _buildDivider(),
            _buildSettingsButton("Aktif Simlerim", () {}),
            _buildDivider(),
            _buildSettingsButton("Önceki Simlerim", () {}),
            const SizedBox(height: 10),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          await StorageHelper.logoutUser();
          setState(() {
            userName = null;
          });
          context.go('/login');
        },
        child: const Text("Çıkış Yap", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 45, 45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildSettingsButton('Dil', () {}),
            _buildDivider(),
            _buildSettingsButton('Para Birimi', () {}),
            _buildDivider(),
            _buildSettingsButton('Neo Sım\'e ulaşın', () {}),
            _buildDivider(),
            _buildSettingsButton('Yardım Merkezi', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Colors.white30, height: 1, thickness: 0.5);
  }
}