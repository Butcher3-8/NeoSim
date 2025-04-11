import 'package:flutter/material.dart';
import 'package:flutter_app/screens/search_county.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../helpers/storage_helper.dart';
import '../screens/search_county.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? userName;
  String? selectedCountry; // Seçili ülke
  String? selectedCountryImage; // Seçili ülkenin bayrak resmi

  // Tüm ülkeler listesi (popüler + diğer tüm ülkeler)
  final List<Map<String, String>> allCountries = [
    {'name': 'Almanya', 'image': 'assets/flags/germany.png'},
    {'name': 'Arnavutluk', 'image': 'assets/flags/albania.png'},
    {'name': 'Amerika Birleşik Devletleri', 'image': 'assets/flags/united-states.png'},
    {'name': 'Avustralya', 'image': 'assets/flags/australia.png'},
    {'name': 'Arjantin', 'image': 'assets/flags/argentina.png'},
    {'name': 'Azerbaycan', 'image': 'assets/flags/azerbaijan.png'},
    {'name': 'Belçika', 'image': 'assets/flags/belgium.png'},
    {'name': 'Birleşik Arap Emirlikleri', 'image': 'assets/flags/united-arab-emirates.png'},
    {'name': 'Birleşik Krallık', 'image': 'assets/flags/united-kingdom.png'},
    {'name': 'Brezilya', 'image': 'assets/flags/brazil-.png'},
    {'name': 'Bulgaristan', 'image': 'assets/flags/bulgaria.png'},
    {'name': 'Çin', 'image': 'assets/flags/china.png'},
    {'name': 'Danimarka', 'image': 'assets/flags/denmark.png'},
    {'name': 'Endonezya', 'image': 'assets/flags/indonesia.png'},
    {'name': 'Fas', 'image': 'assets/flags/morocco.png'},
    {'name': 'Finlandiya', 'image': 'assets/flags/finland.png'},
    {'name': 'Fransa', 'image': 'assets/flags/france (1).png'},
    {'name': 'Avusturya', 'image': 'assets/flags/avusturya.png'},
    {'name': 'Bosna Hersek', 'image': 'assets/flags/bosna.png'},
    {'name': 'Çek Cumhuriyeti', 'image': 'assets/flags/çekya.png'},
    {'name': 'Cezayir', 'image': 'assets/flags/cezayir.png'},
    {'name': 'Kolombiya', 'image': 'assets/flags/colombia.png'},
    {'name': 'Dominik Cumhuriyeti', 'image': 'assets/flags/dominik.png'},
    {'name': 'Ekvator', 'image': 'assets/flags/ekvador.png'},
    {'name': 'Estonya', 'image': 'assets/flags/estonya.png'},
    {'name': 'Filipinler', 'image': 'assets/flags/filipinler.png'},
    {'name': 'Gürcistan', 'image': 'assets/flags/gürcü.png'},
    {'name': 'İzlanda', 'image': 'assets/flags/iceland.png'},
    {'name': 'İran', 'image': 'assets/flags/iran.png'},
    {'name': 'Irak', 'image': 'assets/flags/iraq.png'},
    {'name': 'İrlanda', 'image': 'assets/flags/irlanda.png'},
    {'name': 'Karadağ', 'image': 'assets/flags/karadağ.png'},
    {'name': 'Küba', 'image': 'assets/flags/küba.png'},
    {'name': 'Lihtenştayn', 'image': 'assets/flags/lihtenştayn.png'},
    {'name': 'Lübnan', 'image': 'assets/flags/lübnan.png'},
    {'name': 'Lüksemburg', 'image': 'assets/flags/luxembourg.png'},
    {'name': 'Malezya', 'image': 'assets/flags/malezya.png'},
    {'name': 'Malta', 'image': 'assets/flags/malta.png'},
    {'name': 'Moldova', 'image': 'assets/flags/moldova.png'},
    {'name': 'Paraguay', 'image': 'assets/flags/paraguay.png'},
    {'name': 'Peru', 'image': 'assets/flags/peru.png'},
    {'name': 'Şili', 'image': 'assets/flags/şili.png'},
    {'name': 'Slovakya', 'image': 'assets/flags/slovakya.png'},
    {'name': 'Slovenya', 'image': 'assets/flags/slovenia.png'},
    {'name': 'Tunus', 'image': 'assets/flags/tunisia.png'},
    {'name': 'Urugay', 'image': 'assets/flags/uruguay.png'},
    {'name': 'Yeni Zelanda', 'image': 'assets/flags/yeni zelanda.png'},
    {'name': 'Hırvatistan', 'image': 'assets/flags/hırvatistan.png'},
    {'name': 'Hollanda', 'image': 'assets/flags/netherlands.png'},
    {'name': 'İspanya', 'image': 'assets/flags/spain.png'},
    {'name': 'İsveç', 'image': 'assets/flags/sweden.png'},
    {'name': 'İsviçre', 'image': 'assets/flags/switzerland.png'},
    {'name': 'İtalya', 'image': 'assets/flags/italy.png'},
    {'name': 'Japonya', 'image': 'assets/flags/japan.png'},
    {'name': 'Kanada', 'image': 'assets/flags/canada.png'},
    {'name': 'Katar', 'image': 'assets/flags/qatar.png'},
    {'name': 'Kıbrıs Türk Cumhuriyeti', 'image': 'assets/flags/northern-cyprus.png'},
    {'name': 'Kosova', 'image': 'assets/flags/kosovo.png'},
    {'name': 'Macaristan', 'image': 'assets/flags/hungary.png'},
    {'name': 'Meksika', 'image': 'assets/flags/mexico.png'},
    {'name': 'Mısır', 'image': 'assets/flags/egypt.png'},
    {'name': 'Norveç', 'image': 'assets/flags/norway.png'},
    {'name': 'Polonya', 'image': 'assets/flags/poland.png'},
    {'name': 'Portekiz', 'image': 'assets/flags/portugal.png'},
    {'name': 'Romanya', 'image': 'assets/flags/romania.png'},
    {'name': 'Rusya', 'image': 'assets/flags/russia.png'},
    {'name': 'Sırbistan', 'image': 'assets/flags/serbia.png'},
    {'name': 'Singapur', 'image': 'assets/flags/singapore.png'},
    {'name': 'Suudi Arabistan', 'image': 'assets/flags/saudi-arabia.png'},
    {'name': 'Tayland', 'image': 'assets/flags/thailand.png'},
    {'name': 'Türkiye', 'image': 'assets/flags/turkey.png'},
    {'name': 'Ukrayna', 'image': 'assets/flags/ukraine.png'},
    {'name': 'Yunanistan', 'image': 'assets/flags/greece.png'},
  
  ];

  // Popüler ülkeler listesi (ana sayfada gösterilecek)
  final List<Map<String, String>> popularEsims = [
    {'name': 'Almanya', 'image': 'assets/flags/germany.png'},
    {'name': 'Birleşik Krallık', 'image': 'assets/flags/united-kingdom.png'},
    {'name': 'Türkiye', 'image': 'assets/flags/turkey.png'},
    {'name': 'Arnavutluk', 'image': 'assets/flags/albania.png'},
    {'name': 'İspanya', 'image': 'assets/flags/spain.png'},
    {'name': 'Fransa', 'image': 'assets/flags/france.png'},
    {'name': 'İtalya', 'image': 'assets/flags/italy.png'},
    {'name': 'Kıbrıs Türk Cumhuriyeti', 'image': 'assets/flags/northern-cyprus.png'},
    {'name': 'Kanada', 'image': 'assets/flags/canada.png'},
    {'name': 'Rusya', 'image': 'assets/flags/russia.png'},
    {'name': 'Kosova', 'image': 'assets/flags/kosovo.png'},
    {'name': 'Mısır', 'image': 'assets/flags/egypt.png'},
  ];

  // Plan bilgileri için liste
  final List<Map<String, String>> planOptions = [
    {
      'name': 'Mini ',
      'data': '1 GB',
      'validity': '7 Gün',
      'price': '\$4.50 USD'
    },
    {
      'name': 'Standard ',
      'data': '3 GB',
      'validity': '15 Gün',
      'price': '\$8.99 USD'
    },
    {
      'name': 'Comfort',
      'data': '5 GB',
      'validity': '30 Gün',
      'price': '\$12.50 USD'
    },
    {
      'name': 'Premium ',
      'data': '10 GB',
      'validity': '30 Gün',
      'price': '\$18.00 USD'
    },
    {
      'name': 'Ultra ',
      'data': '20 GB',
      'validity': '30 Gün',
      'price': '\$24.99 USD'
    },
    {
      'name': 'Best ',
      'data': '30 GB',
      'validity': '30 Gün',
      'price': '\$39.99 USD'
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      String? email = await StorageHelper.getCurrentUser();
      setState(() {
        userName = email;
      });
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      context.go('/home');
    } else if (index == 1) {
      context.go('/profile');
    }
  }

  // Ülke seçildiğinde çağrılacak fonksiyon
  void _onCountrySelected(String country, String image) {
    setState(() {
      selectedCountry = country;
      selectedCountryImage = image;
    });
  }

  // Arama ekranına yönlendiren fonksiyon
  void _navigateToSearch(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SearchCountryScreen(
          allCountries: allCountries,
          onCountrySelected: _onCountrySelected,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
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
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Eğer ülke seçilmediyse sadece "Hoşgeldiniz" yazısı, 
                    // seçildiyse ülke bayrağı ve ülke adı yanyana gösterilecek
                    Row(
                      children: [
                        if (selectedCountry != null && selectedCountryImage != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image.asset(
                              selectedCountryImage!,
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        Text(
                          selectedCountry ?? 'Hoşgeldiniz',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Ülke seçili değilse ve kullanıcı giriş yapmışsa email bilgisini göster
                    // Ülke seçiliyse veya kullanıcı giriş yapmamışsa giriş yap butonunu göster
                    selectedCountry == null 
                        ? (userName == null
                            ? TextButton(
                                onPressed: () {
                                  context.go('/login');
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white, width: 2),
                                ),
                                child: const Text(
                                  'Giriş Yap',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    userName!.split('@')[0],
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.account_circle, color: Colors.white, size: 24),
                                ],
                              ))
                        : Container(), // Ülke seçiliyse boş bir container göster
                  ],
                ),
                const SizedBox(height: 16),

                // Eğer ülke seçili değilse arama çubuğu görünecek
                if (selectedCountry == null)
                  InkWell(
                    onTap: () => _navigateToSearch(context),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Text(
                            "150'den fazla ülkede hızlı veri kullanımı...",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Geri Dön butonu - ülke seçiliyse göster
          if (selectedCountry != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () {
                    setState(() {
                      selectedCountry = null;
                      selectedCountryImage = null;
                    });
                  },
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Eğer ülke seçili değilse "En Çok Tercih Edilenler" başlığını göster
          if (selectedCountry == null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Text(
                  'En Çok Tercih Edilenler',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3.0,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Eğer ülke seçiliyse detayları göster, değilse listeyi göster
          Expanded(
            child: selectedCountry == null ? _buildCountryList() : _buildCountryDetails(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // Ülke listesi gösterimi
  Widget _buildCountryList() {
    return ListView.builder(
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
              setState(() {
                selectedCountry = country['name'];
                selectedCountryImage = country['image'];
              });
            },
            child: Row(
              children: [
                Image.asset(
                  country['image']!,
                  width: 50,
                  height: 50,
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
    );
  }

  // Seçili ülkenin detaylarını gösteren widget
  Widget _buildCountryDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        itemCount: planOptions.length,
        itemBuilder: (context, index) {
          final plan = planOptions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 28, 92, 128), // Kırmızı arka plan
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            plan['name'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Yeşil kart görseli (sağ tarafta)
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 28, 92, 126),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/sımcard.png', // Yeşil SIM kartınızın yolunu buraya ekleyin
                              width: 200,
                              height: 190,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildDetailRow(Icons.language, 'KAPSAMA ALANI', selectedCountry ?? ''),
                  _buildDetailRow(Icons.data_usage, 'VERİ', plan['data'] ?? ''),
                  _buildDetailRow(Icons.calendar_today, 'GEÇERLİLİK', plan['validity'] ?? ''),
                  _buildDetailRow(Icons.attach_money, 'FİYAT', plan['price'] ?? ''),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Satın alma işlemi buraya gelecek
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 238, 13, 5),
                          foregroundColor: const Color.fromARGB(255, 247, 247, 247),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'HEMEN SATIN AL',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Bu widget detay satırlarını oluşturmak için
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white24, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}