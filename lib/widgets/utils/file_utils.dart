import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Map<String, dynamic>> saveByteDataToFile(ByteData data, String fileName) async {
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

  var filePath = '$path/$fileName';
  var file = File(filePath);

  if (! await file.exists())
    file.create();

  await file.writeAsBytes(data.buffer.asUint8List());

  return {'path': filePath, 'file': file};
}