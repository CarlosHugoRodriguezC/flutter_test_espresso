import 'package:flutter/material.dart';
import 'package:flutter_test_espresso/infrastructure/models/favorites.dart';
import 'package:flutter_test_espresso/presentation/screens/favorites/favorites_screen.dart';
import 'package:flutter_test_espresso/presentation/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
