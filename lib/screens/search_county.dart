import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart'; // bunu ekle

class SearchCountryScreen extends StatefulWidget {
  final List<Map<String, String>> allCountries;
  final Function(String, String) onCountrySelected;

  const SearchCountryScreen({
    Key? key,
    required this.allCountries,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  _SearchCountryScreenState createState() => _SearchCountryScreenState();
}

class _SearchCountryScreenState extends State<SearchCountryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredCountries = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    
    _filteredCountries = [];
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _hasSearched = true;
      if (query.isEmpty) {
        _filteredCountries = [];
      } else {
        _filteredCountries = widget.allCountries
            .where((country) => country['name']!.toLowerCase().startsWith(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        elevation: 0,
        title: Text('search_country'.tr(), style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _animationController.reverse().then((_) {
              Navigator.pop(context);
            });
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(_animation),
          child: Column(
            children: [
              // Search Input
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "search_placeholder".tr(),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                ),
              ),
              
              // Mesaj veya Sonuç Listesi
              Expanded(
                child: !_hasSearched
                    ? Center(
                        child: Text(
                          "search_info".tr(),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : _filteredCountries.isEmpty
                        ? Center(
                            child: Text(
                              "no_country_found".tr(),
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _filteredCountries.length,
                            itemBuilder: (context, index) {
                              final country = _filteredCountries[index];
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
                                    widget.onCountrySelected(
                                      country['name']!,
                                      country['image']!,
                                    );
                                    _animationController.reverse().then((_) {
                                      Navigator.pop(context);
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
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
