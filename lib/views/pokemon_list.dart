import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_poke_app/models/pokemon.dart';
import 'package:mobile_poke_app/provider/pokemon_provider.dart';
import 'package:mobile_poke_app/utils/utils.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Pokemon List')),
        ),
        body: ListView.builder(
          itemCount: pokemonProvider.pokemonList.length,
          itemBuilder: (context, index) {
            return pokemonCard(pokemonProvider.pokemonList[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          elevation: 5,
          onPressed: () {
            pokemonProvider.addPokemon(pokemonProvider.pokemonList.length + 1);
          },
          child: const Icon(Icons.add),
        ));
  }

  InkWell pokemonCard(Pokemon pokemon) => InkWell(
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
          Navigator.pushNamed(context, "/details", arguments: pokemon);
        },
      );
}
