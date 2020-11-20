import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

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

Future<Map<String, dynamic>> saveByteDataToFile(ByteData data, String fileName) async {

  var path = await MainPath();
  if (path == null)
    return null;
  var filePath = '$path/$fileName';
  var file = File(filePath);

  if (! await file.exists())
    file.create();

  await file.writeAsBytes(data.buffer.asUint8List());

  return {'path': filePath, 'file': file};
}

Future<Map<String, dynamic>> saveStringToFile(String data, String fileName, {String subDirectory}) async {

  var path = await MainPath();
  if (path == null)
    return null;
  var filePath = subDirectory == null ? '$path/$fileName' : '$path/$subDirectory/$fileName';
  var file = await File(filePath).create(recursive: true);

  if (! await file.exists())
    file.create();

  await file.writeAsString(data);

  return {'path': filePath, 'file': file};
}

void shareFile(String path) {
  //Share.shareFiles(path);
  ShareExtend.share(path, "file");
}