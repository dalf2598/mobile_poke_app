import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_poke_app/utils/permission_utils.dart';
import 'package:mobile_poke_app/provider/pokemon_provider.dart';
import 'package:mobile_poke_app/widgets/pokemon_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  bool _hasRequestedPermision = false;

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    if (!_hasRequestedPermision) {
      requestPermissions(context);
      setState(() => _hasRequestedPermision = true);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Pokemon List')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/my-pokemons"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'My Captured Pokemon',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pokemonProvider.pokemonList.length,
                itemBuilder: (context, index) {
                  return PokemonCard(
                      pokemon: pokemonProvider.pokemonList[index],
                      captures: const []);
                },
              ),
            ],
          ),
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
}
