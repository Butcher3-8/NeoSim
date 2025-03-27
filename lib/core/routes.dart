import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/loading_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/my_esim_screen.dart';
import '../screens/login_screen.dart'; // Login ekranını ekledik

// Router yapılandırması
final router = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/my_esim',
      builder: (context, state) => const MyEsimScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(), // Login ekranı rotaya eklendi
    ),
  ],
);
