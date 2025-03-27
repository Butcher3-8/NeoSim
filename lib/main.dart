import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // GoRouter import edilmesi gerekiyor
import 'core/routes.dart';  // Burada routes.dart dosyanızı doğru şekilde import ettiğinizden emin olun

void main() {
  WidgetsFlutterBinding.ensureInitialized();  // Flutter widget'larını başlat
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router,  // GoRouter yapılandırmasını buraya bağladık
      debugShowCheckedModeBanner: false,  // Debug bandını kaldır
    );
  }
}
