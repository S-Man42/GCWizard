import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:file_picker/file_picker.dart' as web_picker;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Directory, Platform;
import 'package:gc_wizard/widgets/utils/platform_file.dart';

import 'package:permission_handler/permission_handler.dart';

/// useFileFilterOnAndroid -> for unknow mime types (for example gpx)
Future<PlatformFile> openFileExplorer(BuildContext context, {
  List<String> allowedExtensions}) async {
  try {
    if (!kIsWeb) {
      Directory  rootDirectoryX = await getApplicationSupportDirectory();// getApplicationDocumentsDirectory();
      String path = await FilesystemPicker.open(
        //title: 'Open file',
        context: context,
        rootDirectory: await getExternalStorageDirectory(),
        fsType: FilesystemType.file,
        //folderIconColor: Colors.teal,
        allowedExtensions: allowedExtensions,
        //fileTileSelectMode: FileTileSelectMode.,
        requestPermission: () async =>
        await Permission.storage
            .request()
            .isGranted,
      );
      if (path != null)
        return new PlatformFile(path: path, name: (path.split('/').last));
      else
        return null;

    } else {
      /// web version
      var files = (await web_picker.FilePicker.platform.pickFiles(
        type: web_picker.FileType.custom,
        allowMultiple: false,
        allowedExtensions: allowedExtensions,
      ))?.files;

      files = _filterFiles(files, allowedExtensions);

      return files == null ? null : new PlatformFile(path: files.first.path, name: files.first.name, bytes: files.first.bytes);
    }
  } on PlatformException catch (e) {
    print("Unsupported operation " + e.toString());
  } catch (ex) {
    print(ex);
  }
  return null;
}

bool _isAndroid() {
  try {
    return (!kIsWeb && Platform.isAndroid);
  } catch (ex) {}
  return false;
}

Future<Uint8List> _getFileData(PlatformFile file) async {
  return kIsWeb ? Future.value(file.bytes) : readByteDataFromFile(file.path);
}

List<web_picker.PlatformFile> _filterFiles(List<web_picker.PlatformFile> files, List<String> allowedExtensions) {
  if (files == null || allowedExtensions == null)
    return null;

  return files.where((element) => allowedExtensions.contains(element.extension)).toList();
}


Future<String> selectFolder() async {
  if (!kIsWeb) {}
  else
    return web_picker.FilePicker.platform.getDirectoryPath();

}


