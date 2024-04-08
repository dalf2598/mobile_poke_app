import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_poke_app/utils/file_system_utils.dart';

class PokemonSlider extends StatelessWidget {
  final List<String> imagesPath;

  const PokemonSlider({super.key, required this.imagesPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: imagesPath.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FutureBuilder<File>(
                future: FileSystemUtils.loadImageFromStorage(imagesPath[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return sliderImage(context, 'assets/loading.gif');
                  } else if (snapshot.hasError) {
                    return sliderImage(context, 'assets/default.jpeg');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return FadeInImage(
                      image: FileImage(snapshot.data as File),
                      imageErrorBuilder: (context, error, stackTrace) {
                        debugPrint('Error loading image:$error');
                        return sliderImage(context, 'assets/default.jpeg');
                      },
                      placeholder: const AssetImage("assets/loading.gif"),
                      width: MediaQuery.of(context).size.width - 50.0,
                      fit: BoxFit.fill,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Image sliderImage(BuildContext context, String path) {
    return Image.asset(
      path,
      width: MediaQuery.of(context).size.width - 50.0,
      fit: BoxFit.fill,
    );
  }
}
