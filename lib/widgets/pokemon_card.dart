import 'package:flutter/material.dart';
import 'package:mobile_poke_app/utils/utils.dart';
import 'package:mobile_poke_app/models/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final List<String> captures;

  const PokemonCard({super.key, required this.pokemon, required this.captures});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: Image.network(
            pokemon.sprites.frontDefault,
            scale: 1.5,
          ),
          title: Text(
            capitalizeFirstLetter(pokemon.name),
            style: const TextStyle(fontSize: 40),
          ),
          subtitle: Text(
            capitalizeFirstLetter(pokemon.types[0].type.name),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      onTap: () {
        Map<String, dynamic> arguments = {
          'pokemon': pokemon,
          'captures': captures,
        };
        Navigator.pushNamed(context, "/details", arguments: arguments);
      },
    );
  }
}
