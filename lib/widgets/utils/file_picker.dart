import 'dart:typed_data';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

/// useFileFilterOnAndroid -> for unknow mime types (for example gpx)
Future<List<PlatformFile>> openFileExplorer({
  FileType pickingType = FileType.any,
  bool multiPick = false,
  List<String> allowedExtensions,
  bool useFileFilterOnAndroid = false}) async {

  var status = await Permission.storage.request();
  if (status != PermissionStatus.granted) {
    return null;
  }

  try {
    List<String> allowedExtensionsTmp = allowedExtensions;
    if (useFileFilterOnAndroid && _isAndroid())
      allowedExtensions = null;

    var files = (await FilePicker.platform.pickFiles(
      type: allowedExtensions != null ? FileType.custom : pickingType,
      allowMultiple: multiPick,
      allowedExtensions: allowedExtensions,
    ))?.files;

    if (useFileFilterOnAndroid && _isAndroid())
      files = _filterFiles(files, allowedExtensionsTmp);

    return files;

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

Future<Uint8List> getFileData(PlatformFile file) async {
  return kIsWeb ? Future.value(file.bytes) : readByteDataFromFile(file.path);
}

List<PlatformFile> _filterFiles(List<PlatformFile> files,List<String> allowedExtensions) {
  if (files == null || allowedExtensions == null)
    return null;

  return files.where((element) => allowedExtensions.contains(element.extension)).toList();
}

Future<bool> clearCachedFiles() async {
  return FilePicker.platform.clearTemporaryFiles();
}

Future<String> selectFolder() async {
  return FilePicker.platform.getDirectoryPath();
}

