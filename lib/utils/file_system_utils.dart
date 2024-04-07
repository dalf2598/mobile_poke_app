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
}
