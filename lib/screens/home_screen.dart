import 'package:flutter/material.dart';
import 'package:flutter_app/screens/search_county.dart';
import 'package:flutter_app/services/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
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
  String? selectedCountry; 
  String? selectedCountryCode; // Ülke kodunu saklayacak değişken
  String? selectedCountryImage; 

  // Ülke kodu - bayrak eşleşmeleri
  final Map<String, String> countryFlags = {
    'germany': 'assets/flags/germany.png',
    'albania': 'assets/flags/albania.png',
    'united_states': 'assets/flags/united-states.png',
    'australia': 'assets/flags/australia.png',
    'argentina': 'assets/flags/argentina.png',
    'azerbaijan': 'assets/flags/azerbaijan.png',
    'belgium': 'assets/flags/belgium.png',
    'united_arab_emirates': 'assets/flags/united-arab-emirates.png',
    'united_kingdom': 'assets/flags/united-kingdom.png',
    'brazil': 'assets/flags/brazil-.png',
    'bulgaria': 'assets/flags/bulgaria.png',
    'china': 'assets/flags/china.png',
    'denmark': 'assets/flags/denmark.png',
    'indonesia': 'assets/flags/indonesia.png',
    'morocco': 'assets/flags/morocco.png',
    'finland': 'assets/flags/finland.png',
    'france': 'assets/flags/france (1).png',
    'austria': 'assets/flags/avusturya.png',
    'bosnia': 'assets/flags/bosna.png',
    'czech_republic': 'assets/flags/çekya.png',
    'algeria': 'assets/flags/cezayir.png',
    'colombia': 'assets/flags/colombia.png',
    'dominican_republic': 'assets/flags/dominik.png',
    'ecuador': 'assets/flags/ekvador.png',
    'estonia': 'assets/flags/estonya.png',
    'philippines': 'assets/flags/filipinler.png',
    'georgia': 'assets/flags/gürcü.png',
    'iceland': 'assets/flags/iceland.png',
    'iran': 'assets/flags/iran.png',
    'iraq': 'assets/flags/iraq.png',
    'ireland': 'assets/flags/irlanda.png',
    'montenegro': 'assets/flags/karadağ.png',
    'cuba': 'assets/flags/küba.png',
    'liechtenstein': 'assets/flags/lihtenştayn.png',
    'lebanon': 'assets/flags/lübnan.png',
    'luxembourg': 'assets/flags/luxembourg.png',
    'malaysia': 'assets/flags/malezya.png',
    'malta': 'assets/flags/malta.png',
    'moldova': 'assets/flags/moldova.png',
    'paraguay': 'assets/flags/paraguay.png',
    'peru': 'assets/flags/peru.png',
    'chile': 'assets/flags/şili.png',
    'slovakia': 'assets/flags/slovakya.png',
    'slovenia': 'assets/flags/slovenia.png',
    'tunisia': 'assets/flags/tunisia.png',
    'uruguay': 'assets/flags/uruguay.png',
    'new_zealand': 'assets/flags/yeni zelanda.png',
    'croatia': 'assets/flags/hırvatistan.png',
    'netherlands': 'assets/flags/netherlands.png',
    'spain': 'assets/flags/spain.png',
    'sweden': 'assets/flags/sweden.png',
    'switzerland': 'assets/flags/switzerland.png',
    'italy': 'assets/flags/italy.png',
    'japan': 'assets/flags/japan.png',
    'canada': 'assets/flags/canada.png',
    'qatar': 'assets/flags/qatar.png',
    'northern_cyprus': 'assets/flags/northern-cyprus.png',
    'kosovo': 'assets/flags/kosovo.png',
    'hungary': 'assets/flags/hungary.png',
    'mexico': 'assets/flags/mexico.png',
    'egypt': 'assets/flags/egypt.png',
    'norway': 'assets/flags/norway.png',
    'poland': 'assets/flags/poland.png',
    'portugal': 'assets/flags/portugal.png',
    'romania': 'assets/flags/romania.png',
    'russia': 'assets/flags/russia.png',
    'serbia': 'assets/flags/serbia.png',
    'singapore': 'assets/flags/singapore.png',
    'saudi_arabia': 'assets/flags/saudi-arabia.png',
    'thailand': 'assets/flags/thailand.png',
    'turkey': 'assets/flags/turkey.png',
    'ukraine': 'assets/flags/ukraine.png',
    'greece': 'assets/flags/greece.png',
  };

  // Tüm ülkeler listesi
  late List<Map<String, String>> allCountries;
  
  // Popüler eSIM'ler
  final List<String> popularEsimCodes = [
    'germany',
    'united_kingdom',
    'turkey',
    'albania',
    'spain',
    'france',
    'italy',
    'northern_cyprus',
    'canada',
    'russia',
    'kosovo',
    'egypt',
  ];

  // Plan seçenekleri
  final List<Map<String, String>> planOptions = [
    {
      'name': 'home.plans.mini',
      'data': '1 GB',
      'validity': '7 Gün',
      'price': '\$4.50 USD'
    },
    {
      'name': 'home.plans.standard',
      'data': '3 GB',
      'validity': '15 Gün',
      'price': '\$8.99 USD'
    },
    {
      'name': 'home.plans.comfort',
      'data': '5 GB',
      'validity': '30 Gün',
      'price': '\$12.50 USD'
    },
    {
      'name': 'home.plans.premium',
      'data': '10 GB',
      'validity': '30 Gün',
      'price': '\$18.00 USD'
    },
    {
      'name': 'home.plans.ultra',
      'data': '20 GB',
      'validity': '30 Gün',
      'price': '\$24.99 USD'
    },
    {
      'name': 'home.plans.best',
      'data': '30 GB',
      'validity': '30 Gün',
      'price': '\$39.99 USD'
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _prepareCountryLists();
  }

  // Ülke listelerini hazırla
  void _prepareCountryLists() {
    // Tüm ülkeleri hazırla
    allCountries = countryFlags.entries.map((entry) {
      return {
        'code': entry.key,
        'name': 'countries.${entry.key}'.tr(),
        'image': entry.value
      };
    }).toList();
    
    // Alfabetik sırala
    allCountries.sort((a, b) => a['name']!.compareTo(b['name']!));
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

  void _onCountrySelected(String countryCode, String image) {
    setState(() {
      selectedCountryCode = countryCode;
      selectedCountry = 'countries.$countryCode'.tr();
      selectedCountryImage = image;
    });
  }

  void _navigateToSearch(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SearchCountryScreen(
          allCountries: allCountries,
          onCountrySelected: (String countryCode, String image) {
            _onCountrySelected(countryCode, image);
          },
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
    // Dil değişikliğini dinlemek için
    
    
    // Ülke listelerini güncelle (dil değişikliğinde)
    _prepareCountryLists();
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Column(
        children: [
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
                          selectedCountry ?? 'home.welcome'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                   
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
                                child: Text(
                                  'home.login'.tr(),
                                  style: const TextStyle(fontSize: 16),
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
                        : Container(),
                  ],
                ),
                const SizedBox(height: 16),

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
                            'home.search_placeholder'.tr(),
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

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
                      selectedCountryCode = null;
                      selectedCountryImage = null;
                    });
                  },
                ),
              ),
            ),

          const SizedBox(height: 8),

          if (selectedCountry == null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Text(
                  'home.popular_choices'.tr(),
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

  Widget _buildCountryList() {
    // Popüler ülkeler listesini oluştur
    final popularEsims = popularEsimCodes.map((code) {
      return {
        'code': code,
        'name': 'countries.$code'.tr(),
        'image': countryFlags[code] ?? ''
      };
    }).toList();

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
                selectedCountryCode = country['code'];
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
                color: const Color.fromARGB(255, 28, 92, 128),
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
                            plan['name']!.tr(),
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
                              'assets/icons/sımcard.png', 
                              width: 200,
                              height: 190,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildDetailRow(Icons.language, 'home.coverage_area'.tr(), selectedCountry ?? ''),
                  _buildDetailRow(Icons.data_usage, 'home.data'.tr(), plan['data'] ?? ''),
                  _buildDetailRow(Icons.calendar_today, 'home.validity'.tr(), plan['validity'] ?? ''),
                  _buildDetailRow(Icons.attach_money, 'home.price'.tr(), plan['price'] ?? ''),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Burada satın alma işlemleri
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 238, 13, 5),
                          foregroundColor: const Color.fromARGB(255, 247, 247, 247),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'home.buy_now'.tr(),
                          style: const TextStyle(
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