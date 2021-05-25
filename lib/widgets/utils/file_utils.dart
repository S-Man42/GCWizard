import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

Map<List<int>, String> _fileTypes = {
  [0x50, 0x4B, 0x03, 0x04]: ".zip",
  [0x52, 0x61, 0x72, 0x21]: ".rar",
  [0x1F, 0x8B, 0x08, 0x00]: ".tar",
  [0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C]: ".7z",
  [0xFF, 0xD8, 0xFF, 0xE0]: ".jpg",
  [0xFF, 0xD8, 0xFF, 0xE1]: ".jpg",
  [0xFF, 0xD8, 0xFF, 0xFE]: ".jpg",
  [0x89, 0x50, 0x4E, 0x47]: ".png",
  [0x42, 0x4D]: ".bmp",
  [0x47, 0x49, 0x46, 0x38, 0x39, 0x61]: ".gif",
  [0x47, 0x49, 0x46, 0x38, 0x37, 0x61]: ".gif",
  [0x49, 0x49, 0x2A, 0x00]: ".tif",
  [0x4D, 0x4D, 0x00, 0x2A]: ".tif",
  [0x52, 0x49, 0x46, 0x46]: ".webp",
  [0x30, 0x26, 0xB2, 0x75]: ".wmv",
  [0x49, 0x44, 0x33, 0x2E]: ".mp3",
  [0x49, 0x44, 0x33, 0x03]: ".mp3",
  [0x25, 0x50, 0x44, 0x46]: ".pdf",
  [0x4D, 0x5A, 0x50, 0x00]: ".exe",
  [0x4D, 0x5A, 0x90, 0x00]: ".exe",
};

String web_directory = "Downloads";

Future<String> mainDirectory() async {
  Directory _appDocDir;
  if (Platform.isAndroid) {
    //  _appDocDir = await getDownloadsDirectory();
    // _appDocDir = await getExternalStorageDirectory();
    String dloadDir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    _appDocDir = await Directory(dloadDir);
  } else {
    _appDocDir = await getApplicationDocumentsDirectory();
  }

  final Directory _appDocDirFolder = Directory('${_appDocDir.path}');

  var path;
  if (await _appDocDirFolder.exists()) {
    path = _appDocDirFolder.path;
  } else {
    final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
    path = _appDocDirNewFolder.path;
  }
  return path;
}

Future<Map<String, dynamic>> saveByteDataToFile(ByteData data, String fileName, {String subDirectory}) async {
  var status = await Permission.storage.request();
  if (status != PermissionStatus.granted) {
    return null;
  }

  var filePath = '';
  File file;

  if (kIsWeb) {
    // var blob = new html.Blob([data], 'image/png');
    //
    // var anchorElement = html.AnchorElement(
    //   href: html.Url.createObjectUrl(blob),
    //   )..setAttribute("download", fileName)..click();
    //
    // filePath = '/$web_directory/$fileName';
  } else {
    var path = await mainDirectory();

    if (path == null) return null;
    filePath = subDirectory == null ? '$path/$fileName' : '$path/$subDirectory/$fileName';
    file = File(filePath);

    if (!await file.exists()) file.create();

    await file.writeAsBytes(data.buffer.asUint8List());
  }
  return {'path': filePath, 'file': file};
}

Future<Map<String, dynamic>> saveStringToFile(String data, String fileName, {String subDirectory}) async {
  var filePath = '';
  File file;

  if (kIsWeb) {
    // var blob = html.Blob([data], 'text/plain', 'native');
    //
    // var anchorElement = html.AnchorElement(
    //   href: html.Url.createObjectUrl(blob),
    // )..setAttribute("download", fileName)..click();
    //
    // filePath = '/$web_directory/$fileName';
  } else {
    var path = await mainDirectory();

    if (path == null) return null;
    filePath = subDirectory == null ? '$path/$fileName' : '$path/$subDirectory/$fileName';
    file = await File(filePath).create(recursive: true);

    if (!await file.exists()) file.create();

    await file.writeAsString(data);
  }
  return {'path': filePath, 'file': file};
}

shareFile(String path, String type) {
  ShareExtend.share(path, "file");
}

openFile(String path, String type) {
  Map<String, String> knowExtensions = {
    ".gpx": "application/gpx+xml",
    ".kml": "application/vnd.google-earth.kml+xml",
    ".kmz": "application/vnd.google-earth.kmz",
  };
  Map<String, String> knowUtiExtensions = {
    ".gpx": "com.topografix.gpx",
    ".kml": "com.google.earth.kml",
  };

  if (type != null) {
    type = type.toLowerCase();
    OpenFile.open(path,
        type: knowExtensions.containsKey(type) ? knowExtensions[type] : null,
        uti: knowUtiExtensions.containsKey(type) ? knowUtiExtensions[type] : null);
  } else
    OpenFile.open(path);
}

Future<Uint8List> readByteDataFromFile(String fileName) async {
  var fileIn = File(fileName);
  return fileIn.readAsBytes();
}

Future<String> readStringFromFile(String fileName) async {
  var fileIn = File(fileName);
  return fileIn.readAsString();
}

String getFileType(Uint8List blobBytes, {String defaultType = ".txt"}) {
  for (var key in _fileTypes.keys) {
    if (blobBytes.length >= key.length && ListEquality().equals(blobBytes.sublist(0, key.length), key))
      return _fileTypes[key];
  }

  return defaultType;
}
