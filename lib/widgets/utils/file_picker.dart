import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;

var unsupportedMobileTypes = ['gpx'];
var supportedImageTypes = ['jpg', 'jpeg', 'tiff', 'png', 'bmp', 'gif', 'webp'];

/// Open File Picker dialog
/// Returns null if nothing was selected.
/// * [allowedExtensions] specifies a list of file extensions that will be displayed for selection, if empty - files with any extension are displayed. Example: `['jpg', 'jpeg']`
Future<local.PlatformFile> openFileExplorer({List<String> allowedExtensions}) async {
  try {
      return _openFileExplorer(allowedExtensions);
  } catch (ex) {
    print(ex);
  }
  return null;
}

Future<local.PlatformFile> _openFileExplorer(List<String> allowedExtensions) async {
  try {
    List<String> allowedExtensionsTmp = allowedExtensions;

    if (allowedExtensions != null)
      for (var i = 0; i < allowedExtensions.length; i++)
        allowedExtensions[i] = allowedExtensions[i].replaceFirst('.', '');

    if (_hasUnsupportedTypes(allowedExtensions)) allowedExtensions = null;

    var files = (await FilePicker.platform.pickFiles(
            type: allowedExtensions == null ? FileType.any : FileType.custom,
            allowMultiple: false,
            allowedExtensions: allowedExtensions))
        ?.files;

    if (allowedExtensions == null) files = _filterFiles(files, allowedExtensionsTmp);

    return (files == null || files.length == 0)
        ? null
        : new local.PlatformFile(path: files.first.path, name: files.first.name, bytes: await _getFileData(files.first));
  } on PlatformException catch (e) {
    print("Unsupported operation " + e.toString());
  }
  return null;
}

Future<Uint8List> _getFileData(PlatformFile file) async {
  return kIsWeb ? Future.value(file.bytes) : readByteDataFromFile(file.path);
}

List<PlatformFile> _filterFiles(List<PlatformFile> files, List<String> allowedExtensions) {
  if (files == null || allowedExtensions == null) return files;

  return files.where((element) => allowedExtensions.contains(element.extension)).toList();
}

bool _hasUnsupportedTypes(List<String> allowedExtensions) {
  if (allowedExtensions == null) return false;
  if (kIsWeb) return false;

  for (int i = 0; i < allowedExtensions.length; i++) {
    if (unsupportedMobileTypes.contains(allowedExtensions[i])) return true;
  }
  return false;
}
