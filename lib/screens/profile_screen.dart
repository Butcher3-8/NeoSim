import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../helpers/storage_helper.dart';

// Profil ekranında gösterilecek farklı içerik türleri
enum ProfileContent {
  profile,     // Ana profil içeriği
  account,     // Hesap bilgileri
  cards,       // Kayıtlı kartlar
  activeSims,  // Aktif simler
  pastSims,    // Önceki simler
  language,    // Dil ayarları
  currency,    // Para birimi ayarları
  contact,     // Neo Sım'a ulaşın
  help         // Yardım merkezi
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  int _selectedIndex = 1; // Bottom navigation için seçili index (Profil sekmesi)
  ProfileContent _currentContent = ProfileContent.profile; // Şu anki içerik
  String? _profilePhotoUrl; // Profil fotoğrafı URL'si

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
      // Boş bırakılmış
    } else if (index == 1) {
      context.go('/profile');
    }
  }

  Future<void> _loadUserData() async {
    try {
      String? email = await StorageHelper.getCurrentUser();
      
      String? photoUrl = await StorageHelper.getUserProfilePhoto();
      setState(() {
        userName = email; 
        _profilePhotoUrl = photoUrl;
      });
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

 
  void _changeContent(ProfileContent content) {
    setState(() {
      _currentContent = content;
    });
  }

  
  void _backToMainProfile() {
    setState(() {
      _currentContent = ProfileContent.profile;
    });
  }

 
  Future<void> _changeProfilePhoto() async {
    // FOTO DEĞİŞTİRME YERİ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('profile_photo_change_started'.tr())),
    );
  }

  
  Future<void> _removeProfilePhoto() async {
    await StorageHelper.removeProfilePhoto();
    setState(() {
      _profilePhotoUrl = null;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('profile_photo_removed'.tr())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            if (_currentContent != ProfileContent.profile) 
              _buildBackButton(),
            if (userName == null) 
              _buildLoginButton()
            else 
              _buildCurrentContent(),
            
            if (_currentContent == ProfileContent.profile && userName != null)
              _buildSettingsSection(),
        
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

 
  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: _backToMainProfile,
        ),
      ),
    );
  }


Widget _buildCurrentContent() {
  switch (_currentContent) {
    case ProfileContent.profile:
      return _buildUserProfile();
    case ProfileContent.account:
      return _buildAccountContent();
    case ProfileContent.cards:
      return _buildCardsContent();
    case ProfileContent.activeSims:
      return _buildActiveSimsContent();
    case ProfileContent.pastSims:
      return _buildPastSimsContent();
    case ProfileContent.language:
      return _buildLanguageContent();
    case ProfileContent.currency:
      return _buildCurrencyContent();
    case ProfileContent.contact:
      return _buildContactContent();
    case ProfileContent.help:
      return _buildHelpContent();
    default:
      return _buildUserProfile();
  }
}

Widget _buildAccountContent() {
  return _buildCustomContent('account_content'.tr());
}

Widget _buildCardsContent() {
  return _buildCustomContent('cards_content'.tr());
}

Widget _buildActiveSimsContent() {
  return _buildCustomContent('active_sims_content'.tr());
}

Widget _buildPastSimsContent() {
  return _buildCustomContent('past_sims_content'.tr());
}

Widget _buildLanguageContent() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 45, 45, 45), // Buton arka plan rengi
            padding: const EdgeInsets.symmetric(vertical: 20), // Butonun dikey paddingi
            textStyle: const TextStyle(fontSize: 18), // Yazı büyüklüğü
          ),
          onPressed: () {
            context.setLocale(const Locale('tr'));
          },
          child: const Text(
            "Türkçe",
            style: TextStyle(color: Colors.white), // Yazı rengi beyaz
          ),
        ),
        const SizedBox(height: 15), // Butonlar arasında daha fazla boşluk
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 45, 45, 45), // Buton arka plan rengi
            padding: const EdgeInsets.symmetric(vertical: 20), // Butonun dikey paddingi
            textStyle: const TextStyle(fontSize: 18), // Yazı büyüklüğü
          ),
          onPressed: () {
            context.setLocale(const Locale('en'));
          },
          child: const Text(
            "English",
            style: TextStyle(color: Colors.white), // Yazı rengi beyaz
          ),
        ),
        const SizedBox(height: 15), // Butonlar arasında daha fazla boşluk
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 45, 45, 45), // Buton arka plan rengi
            padding: const EdgeInsets.symmetric(vertical: 20), // Butonun dikey paddingi
            textStyle: const TextStyle(fontSize: 18), // Yazı büyüklüğü
          ),
          onPressed: () {
            context.setLocale(const Locale('de'));
          },
          child: const Text(
            "Deutsch",
            style: TextStyle(color: Colors.white), // Yazı rengi beyaz
          ),
        ),
      ],
    ),
  );
}



Widget _buildCurrencyContent() {
  return _buildCustomContent('currency_content'.tr());
}

Widget _buildContactContent() {
  return _buildCustomContent('contact_content'.tr());
}

Widget _buildHelpContent() {
  return _buildCustomContent('help_content'.tr());
}

Widget _buildCustomContent(String contentText) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 45),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contentText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'content_details'.tr(),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}

  
  Widget _buildContentPlaceholder(String contentTitle) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 45, 45),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              contentTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'content_will_be_shown_here'.tr(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    
    double headerHeight = _currentContent == ProfileContent.profile ? 140.0 : 80.0;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: _currentContent == ProfileContent.profile ? 20 : 10),
      height: headerHeight,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getHeaderTitle(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _currentContent == ProfileContent.profile ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              if (_currentContent == ProfileContent.profile)
                _buildProfilePhotoWidget(),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildProfilePhotoWidget() {
  return GestureDetector(
    onTap: () {
      _showProfilePhotoOptions(context);
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Profil resmi veya ikon
        _profilePhotoUrl != null
            ? CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(_profilePhotoUrl!),
              )
            : const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 80,
              ),
        // Şeffaf düzenleme ikonu overlay'i - profil fotoğrafının üzerinde
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.3),
          ),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    ),
  );
}

  // Profil fotoğrafı seçeneklerini gösteren dialog
  void _showProfilePhotoOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'profile_photo'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.add_a_photo, color: Colors.white),
                title: Text(
                  _profilePhotoUrl != null ? 'change_profile_photo'.tr() : 'add_profile_photo'.tr(),
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _changeProfilePhoto();
                },
              ),
              if (_profilePhotoUrl != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    'remove_profile_photo'.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _removeProfilePhoto();
                  },
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'cancel'.tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // İçeriğe göre başlık belirleme
  String _getHeaderTitle() {
    switch (_currentContent) {
      case ProfileContent.profile:
        return 'profile'.tr();
      case ProfileContent.account:
        return 'account_info'.tr();
      case ProfileContent.cards:
        return 'saved_cards'.tr();
      case ProfileContent.activeSims:
        return 'active_sims'.tr();
      case ProfileContent.pastSims:
        return 'previous_sims'.tr();
      case ProfileContent.language:
        return 'language_settings'.tr();
      case ProfileContent.currency:
        return 'currency'.tr();
      case ProfileContent.contact:
        return 'contact_neo_sim'.tr();
      case ProfileContent.help:
        return 'help_center'.tr();
      default:
        return 'profile'.tr();
    }
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
            Text(
              'login_register'.tr(),
              style: const TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                userName!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildProfileButton('account_info'.tr(), () => _changeContent(ProfileContent.account)),
            _buildDivider(),
            // Her buton arasında biraz daha boşluk
            const SizedBox(height: 8),
            _buildProfileButton('saved_cards'.tr(), () => _changeContent(ProfileContent.cards)),
            _buildDivider(),
            // Her buton arasında biraz daha boşluk
            const SizedBox(height: 8),
            _buildProfileButton('active_sims'.tr(), () => _changeContent(ProfileContent.activeSims)),
            _buildDivider(),
            // Her buton arasında biraz daha boşluk
            const SizedBox(height: 8),
            _buildProfileButton('previous_sims'.tr(), () => _changeContent(ProfileContent.pastSims)),
            const SizedBox(height: 20), // Alt boşluğu artırdık
            Center(
              child: _buildLogoutButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton(
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
          _profilePhotoUrl = null;
          _currentContent = ProfileContent.profile;
        });
        context.go('/login');
      },
      child: Text('logout'.tr(), style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Üst ve alt boşluğu artırdık
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 45, 45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildProfileButton('language'.tr(), () => _changeContent(ProfileContent.language)),
            _buildDivider(),
            // Her buton arasında biraz daha boşluk
            const SizedBox(height: 8),  
            _buildProfileButton('currency'.tr(), () => _changeContent(ProfileContent.currency)),
            _buildDivider(),
            // Her buton arasında biraz daha boşluk
            const SizedBox(height: 8),
            _buildProfileButton('contact_neo_sim'.tr(), () => _changeContent(ProfileContent.contact)),
            _buildDivider(),
            // Her buton arasında biraz daha boşluk
            const SizedBox(height: 8),
            _buildProfileButton('help_center'.tr(), () => _changeContent(ProfileContent.help)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // Buton içi boşluğu artırdık
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Colors.white30, height: 1, thickness: 0.5);
  }
}