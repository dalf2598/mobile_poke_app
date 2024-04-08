import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:mobile_poke_app/models/pokemon_captures_model.dart';
import 'package:mobile_poke_app/models/pokemon_model.dart';
import 'package:mobile_poke_app/services/pokemon_service.dart';
import 'package:mobile_poke_app/utils/file_system_utils.dart';

class PokemonCaptureProvider extends ChangeNotifier {
  PokemonCaptureProvider() {
    loadingPokemonsCaptures = true;
    notifyListeners();
    loadPokemonsCaptures();
  }

  List<PokemonCapturesModel> pokemonsCaptures = [];
  bool loadingPokemonsCaptures = true;

  Future<void> loadPokemonsCaptures() async {
    debugPrint('loading pokemons captures');
    try {
      pokemonsCaptures = [];
      List<String> pokemonsDirs = await FileSystemUtils.listExternalDirectory();
      for (var i = 0; i < pokemonsDirs.length; i++) {
        String pokemonFolderName = basename(pokemonsDirs[i]);
        if (!pokemonFolderName.contains('pokemon_')) return;
        String pokemonId = pokemonFolderName.split('_')[1];
        Pokemon pokemon = await PokemonServices.getPokemon(pokemonId);
        List<String> pokemonsCapturePaths =
            await FileSystemUtils.listExternalFolder(pokemonFolderName);
        pokemonsCaptures.add(PokemonCapturesModel(
            pokemon: pokemon, captures: pokemonsCapturePaths));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    loadingPokemonsCaptures = false;
    notifyListeners();
  }
}
