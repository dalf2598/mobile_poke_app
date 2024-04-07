import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_poke_app/provider/pokemon_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions(BuildContext context) async {
  final pokemonProvider = Provider.of<PokemonProvider>(context);

  PermissionStatus cameraPermission = await Permission.camera.request();

  if (cameraPermission.isGranted) {
    pokemonProvider.hasCameraPermission = true;
  }

  /* DEV Note
    I remove the request permission to storage becuase by default it will always be denied.
    You can find the reason for this in the documentation of the permission_handler package (https://pub.dev/packages/permission_handler)
    As for the camera permission, if permission is denied then the camera icon on the pokemon details screen will not be displayed.
  */
}
