import 'package:flutter/material.dart';
import 'package:mobile_poke_app/models/pokemon.dart';
import 'package:mobile_poke_app/services/pokemon_api.dart';

class PokemonProvider extends ChangeNotifier {
  PokemonProvider() {
    _initPokemonList();
  }

  final List<Pokemon> _pokemonList = [];
  final int _initPokemonListNumber = 10;

  void _initPokemonList() async {
    for (int i = 1; i <= _initPokemonListNumber; i++) {
      final pokemon = await PokemonServices.getPokemon(i);
      _pokemonList.add(pokemon);
    }
    notifyListeners();
  }

  void addPokemon(id) async {
    final pokemon = await PokemonServices.getPokemon(id);
    _pokemonList.add(pokemon);
    notifyListeners();
  }

  int get initPokemonListNumber => _initPokemonListNumber;
  List<Pokemon> get pokemonList => _pokemonList;
}
