import 'package:mobile_poke_app/models/pokemon_model.dart';

class PokemonCapturesModel {
  Pokemon pokemon;
  List<String> captures = [];

  PokemonCapturesModel({
    required this.pokemon,
    required this.captures,
  });
}
