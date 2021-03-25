import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';


Future<List<PlatformFile>> openFileExplorer({
  FileType pickingType = FileType.any,
  bool multiPick = false,
  String extension}) async {

  try {
    return (await FilePicker.platform.pickFiles(
      type: pickingType,
      allowMultiple: multiPick,
      allowedExtensions: (extension?.isNotEmpty ?? false) ? extension?.replaceAll(' ', '')?.split(',') : null,
    ))?.files;

  } on PlatformException catch (e) {
    print("Unsupported operation" + e.toString());
  } catch (ex) {
    print(ex);
  }
  return null;
}

Future<bool> clearCachedFiles() async {
  return FilePicker.platform.clearTemporaryFiles();
}

Future<String> selectFolder() async {
  return FilePicker.platform.getDirectoryPath();
}

