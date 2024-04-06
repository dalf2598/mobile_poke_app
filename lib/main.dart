import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_poke_app/provider/pokemon_provider.dart';
import 'package:mobile_poke_app/views/pokemon_list.dart';
import 'package:mobile_poke_app/views/splash_screen.dart';
import 'package:mobile_poke_app/views/podemon_details.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PokemonProvider>(
      create: (context) => PokemonProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/splashScreen",
      routes: {
        "/splashScreen": (context) => const SplashScreen(),
        "/pokemonList": (context) => const PokemonList(),
        "/details": (context) => const PokemonDetails(),
      },
    );
  }
}
