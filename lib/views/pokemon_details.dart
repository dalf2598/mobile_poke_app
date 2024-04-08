import 'dart:io';
import 'package:mobile_poke_app/provider/pokemon_capture_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_poke_app/utils/utils.dart';
import 'package:mobile_poke_app/models/pokemon_model.dart';
import 'package:mobile_poke_app/utils/file_system_utils.dart';
import 'package:mobile_poke_app/widgets/pokemon_slider.dart';
import 'package:mobile_poke_app/provider/pokemon_provider.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final pokemon = arguments['pokemon'];
    final captures = arguments['captures'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                pokemonImage(context, pokemon, captures,
                    pokemonProvider.hasCameraPermission),
                Text(
                  capitalizeFirstLetter(pokemon.name),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Weight: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${pokemon.weight} Pounds",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Stats: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                pokemonStats(pokemon.stats),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Types",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                pokemonTypes(pokemon.types),
              ],
            ),
          ),
        ));
  }
}

Widget pokemonImage(BuildContext context, Pokemon pokemon,
    List<String> captures, bool hasCameraPermission) {
  final capturesProvider = Provider.of<PokemonCaptureProvider>(context);

  return Container(
      color: getColorForPokemonType(pokemon.types.first.type.name),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Stack(children: [
        (captures.isEmpty)
            ? Image(
                image: NetworkImage(pokemon.sprites.frontDefault),
                fit: BoxFit.fill,
                height: 160,
                width: 180,
              )
            : PokemonSlider(imagesPath: captures),
        (hasCameraPermission && captures.isEmpty)
            ? Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt_rounded),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () async {
                    final picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile == null) return;

                    Directory capturesDirectory =
                        await FileSystemUtils.createLocalDirectory(
                            'pokemon_${pokemon.id}');

                    String fileName = basename(pickedFile.path);

                    String destinationFile =
                        '${capturesDirectory.path}$fileName';

                    File sourceFile = File(pickedFile.path);
                    File destination = File(destinationFile);

                    await destination
                        .writeAsBytes(await sourceFile.readAsBytes());

                    debugPrint("Saved Image Path: $destinationFile");
                    debugPrint(
                        "Saved Image Size: ${await File(destinationFile).length()} bytes");

                    await capturesProvider.loadPokemonsCaptures();
                  },
                ))
            : const SizedBox(),
      ]));
}

Widget pokemonStats(List<StatElement> stats) {
  return Column(
    children: stats.map((stat) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(
                  width: 25,
                  height: 25,
                  image: AssetImage(getAssetImage('stats',
                      stat.stat.name.replaceFirst(RegExp(r'(\-)'), '_'))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  capitalizeFirstLetter(stat.stat.name),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              stat.baseStat.toString(),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget pokemonTypes(List<Type> types) {
  return Column(
    children: types.map((currentType) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(getAssetImage(
                'pokemon',
                currentType.type.name,
              )),
              fit: BoxFit.fill,
              height: 80,
              width: 80,
            ),
            Text(
              capitalizeFirstLetter(currentType.type.name),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
