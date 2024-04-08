import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileSystemUtils {
  static Future<Directory> createLocalDirectory(String folderName) async {
    final Directory? appDocDir = await getExternalStorageDirectory();

    final Directory appDocDirFolder =
        Directory('${appDocDir?.path}/$folderName/');

    if (await appDocDirFolder.exists()) {
      return appDocDirFolder;
    } else {
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder;
    }
  }

  static Future<List<String>> listExternalDirectory() async {
    final Directory? appDocDir = await getExternalStorageDirectory();
    return appDocDir == null
        ? []
        : appDocDir.listSync().map((event) => event.path).toList();
  }

  static Future<List<String>> listExternalFolder(String folderName) async {
    final Directory? appDocDir = await getExternalStorageDirectory();
    final Directory folderDirectory =
        Directory('${appDocDir?.path}/$folderName/');
    return folderDirectory.listSync().map((event) => event.path).toList();
  }

  static Future<File> loadImageFromStorage(String imagePath) async {
    File imageFile = File(imagePath);
    return (imageFile.existsSync()) ? imageFile : File('assets/default.jpeg');
  }
}
