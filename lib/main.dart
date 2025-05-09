import 'package:examen_ordinaria/provider/pokemon_provider.dart';
import 'package:examen_ordinaria/provider/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
        ChangeNotifierProvider(create: (_) => FavoritProvider()),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: Center(
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
