import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:open_file/open_file.dart';

Future<String> MainPath() async {
  var status = await Permission.storage.request();
  if (status != PermissionStatus.granted) {
    return null;
  }

  Directory _appDocDir;
  if (Platform.isAndroid)
    _appDocDir = await getExternalStorageDirectory();
  else
    _appDocDir = await getApplicationDocumentsDirectory();

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
  var filePath = '';
  File file;

  if (kIsWeb) {
    // var blob = new html.Blob([data], 'image/png');
    //
    // var anchorElement = html.AnchorElement(
    //   href: html.Url.createObjectUrl(blob),
    //   )..setAttribute("download", fileName)..click();
    //
    // filePath = 'Downloads/$fileName';
  } else {
    var path = await MainPath();
    if (path == null) return null;
    filePath = subDirectory == null ? '$path/$fileName' : '$path/$subDirectory/$fileName';
    file = await File(filePath).create(recursive: true);

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
    // filePath = 'Downloads/$fileName';
  } else {
    var path = await MainPath();
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

// Commented out because needs some problems to be fixed:
// 1. Problems with compiling on some environments
// 2. App c:geo is not in list for consuming GPX files as it should (seems to be a cgeo problem: )
// openFile(String path, String type) {
//   Map<String, String> knowExtensions = {
//     ".gpx": "application/gpx+xml",
//     ".kml": "application/vnd.google-earth.kml+xml",
//     ".kmz": "application/vnd.google-earth.kmz",
//   };
//   Map<String, String> knowUtiExtensions = {
//     ".gpx": "com.topografix.gpx",
//     ".kml": "com.google.earth.kml",
//   };
//
//   if (type != null) {
//     type = type.toLowerCase();
//     OpenFile.open(path,
//         type: knowExtensions.containsKey(type) ? knowExtensions[type] : null,
//         uti: knowUtiExtensions.containsKey(type) ? knowUtiExtensions[type] : null
//     );
//   }
//   else
//     OpenFile.open(path);
// }
