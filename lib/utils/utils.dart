import 'package:flutter/material.dart';

String capitalizeFirstLetter(String s) => s[0].toUpperCase() + s.substring(1);

String getAssetImage(String type, String name) {
  return "assets/${type}_types/$name.png";
}

Color getColorForPokemonType(String type) {
  switch (type.toLowerCase()) {
    case 'normal':
      return const Color.fromARGB(255, 154, 113, 97);
    case 'fire':
      return const Color.fromARGB(255, 249, 111, 101);
    case 'water':
      return const Color.fromARGB(255, 67, 164, 244);
    case 'electric':
      return const Color.fromARGB(255, 238, 225, 115);
    case 'grass':
      return const Color.fromARGB(255, 102, 214, 105);
    case 'ice':
      return Colors.cyanAccent;
    case 'fighting':
      return Colors.orange;
    case 'poison':
      return Colors.purple;
    case 'ground':
      return Colors.brown;
    case 'flying':
      return Colors.indigo;
    case 'psychic':
      return Colors.pink;
    case 'bug':
      return Colors.lightGreen;
    case 'rock':
      return Colors.grey;
    case 'ghost':
      return Colors.deepPurpleAccent;
    case 'dragon':
      return Colors.deepPurple;
    case 'dark':
      return Colors.brown;
    case 'steel':
      return Colors.blueGrey;
    case 'fairy':
      return Colors.pinkAccent;
    default:
      return Colors.grey;
  }
}
