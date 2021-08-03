import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart' as filePicker;
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;

const UNSUPPORTED_MOBILE_TYPES = [FileType.GPX];
final SUPPORTED_IMAGE_TYPES = fileTypesByFileClass(FileClass.IMAGE);

/// Open File Picker dialog
///
/// Returns null if nothing was selected.
///
/// * [allowedFileTypes] specifies a list of file extensions that will be displayed for selection, if empty - files with any extension are displayed. Example: `['jpg', 'jpeg']`
Future<local.PlatformFile> openFileExplorer({List<FileType> allowedFileTypes}) async {
  try {
    if (!kIsWeb)
      //return _openMobileFileExplorer(allowedExtensions);
      return _openWebFileExplorer(allowedFileTypes);
    else

      /// web version
      return _openWebFileExplorer(allowedFileTypes);
  } catch (ex) {
    print(ex);
  }
  return null;
}

// Future<local.PlatformFile> _openMobileFileExplorer(List<String> allowedExtensions) async {
//   final fileInfo = await FilePickerWritable().openFile((fileInfo, file) async {
//     if (file != null && _filterFile(fileInfo?.fileName, allowedExtensions) != null)
//       return (file == null) ? null : new local.PlatformFile(path: fileInfo.uri, name: fileInfo?.fileName, bytes: file.readAsBytesSync());
//   });
//   return fileInfo;
// }

Future<local.PlatformFile> _openWebFileExplorer(List<FileType> allowedFileTypes) async {
  try {
    if (_hasUnsupportedTypes(allowedFileTypes)) allowedFileTypes = null;

    var files = (await filePicker.FilePicker.platform.pickFiles(
            type: allowedFileTypes == null ? filePicker.FileType.any : filePicker.FileType.custom,
            allowMultiple: false,
            allowedExtensions: allowedFileTypes.map((type) => fileExtension(type)).toList()))
        ?.files;

    if (allowedFileTypes == null) files = _filterFiles(files, allowedFileTypes);

    return (files == null || files.length == 0)
        ? null
        : new local.PlatformFile(
            path: files.first.path, name: files.first.name, bytes: await _getFileData(files.first));
  } on PlatformException catch (e) {
    print("Unsupported operation " + e.toString());
  }
  return null;
}

Future<Uint8List> _getFileData(filePicker.PlatformFile file) async {
  return kIsWeb ? Future.value(file.bytes) : readByteDataFromFile(file.path);
}

// String _filterFile(String fileName, List<String> allowedExtensions) {
//   return allowedExtensions.contains(fileName?.split('.').last) ? fileName : null;
// }

List<filePicker.PlatformFile> _filterFiles(List<filePicker.PlatformFile> files, List<FileType> allowedFileTypes) {
  if (files == null || allowedFileTypes == null) return files;

  var allowedExtensions = fileExtensions(allowedFileTypes);

  return files.where((element) => allowedExtensions.contains(element.extension)).toList();
}

bool _isAndroid() {
  try {
    return (!kIsWeb && Platform.isAndroid);
  } catch (ex) {}
  return false;
}

bool _hasUnsupportedTypes(List<FileType> allowedExtensions) {
  if (allowedExtensions == null) return false;
  if (kIsWeb) return false;

  for (int i = 0; i < allowedExtensions.length; i++) {
    if (UNSUPPORTED_MOBILE_TYPES.contains(allowedExtensions[i])) return true;
  }
  return false;
}
