import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_poke_app/widgets/pokemon_card.dart';
import 'package:mobile_poke_app/provider/pokemon_capture_provider.dart';

class MyPokemons extends StatefulWidget {
  const MyPokemons({super.key});

  @override
  State<MyPokemons> createState() => _MyPokemonsState();
}

class _MyPokemonsState extends State<MyPokemons> {
  @override
  Widget build(BuildContext context) {
    final capturesProvider = Provider.of<PokemonCaptureProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Pokemons'),
        ),
        body: capturesProvider.loadingPokemonsCaptures
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: capturesProvider.pokemonsCaptures.length,
                      itemBuilder: (context, index) {
                        return PokemonCard(
                          pokemon:
                              capturesProvider.pokemonsCaptures[index].pokemon,
                          captures:
                              capturesProvider.pokemonsCaptures[index].captures,
                        );
                      },
                    )
                  ],
                ),
              ));
  }
}
