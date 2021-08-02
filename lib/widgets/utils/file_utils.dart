import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
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

// Future<String> mainDirectory() async {
//   Directory _appDocDir;
//   if (Platform.isAndroid) {
//     _appDocDir = await getExternalStorageDirectory();
//     String dloadDir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
//     _appDocDir = await Directory(dloadDir);
//   } else
//     _appDocDir = await getApplicationDocumentsDirectory();
//
//   final Directory _appDocDirFolder = Directory('${_appDocDir.path}');
//
//   var path;
//   if (await _appDocDirFolder.exists()) {
//     path = _appDocDirFolder.path;
//   } else {
//     final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
//     path = _appDocDirNewFolder.path;
//   }
//   return path;
// }

Future<Map<String, dynamic>> saveByteDataToFile(ByteData data, String fileName, {String subDirectory}) async {
  var status = await Permission.storage.request();
  if (status != PermissionStatus.granted) {
    return null;
  }

  var filePath = '';
  File fileX;

  if (kIsWeb) {
    // var blob = new html.Blob([data], 'image/png');
    //
    // var anchorElement = html.AnchorElement(
    //   href: html.Url.createObjectUrl(blob),
    //   )..setAttribute("download", fileName)..click();
    //
    // filePath = '/$web_directory/$fileName';
  } else {
    fileName = _limitFileNameLength(fileName);
    final fileInfo = await FilePickerWritable().openFileForCreate(
      fileName: fileName,
      writer: (file) async {
        await file.writeAsBytes(data.buffer.asUint8List());
        fileX = file;
      },
    );
    if (fileInfo == null) return null;

    filePath = fileInfo.identifier;
  }
  return {'path': filePath, 'file': fileX};
}

Future<Map<String, dynamic>> saveStringToFile(String data, String fileName, {String subDirectory}) async {
  var filePath = '';
  File fileX;

  if (kIsWeb) {
    // var blob = html.Blob([data], 'text/plain', 'native');
    //
    // var anchorElement = html.AnchorElement(
    //   href: html.Url.createObjectUrl(blob),
    // )..setAttribute("download", fileName)..click();
    //
    // filePath = '/$web_directory/$fileName';
  } else {
    fileName = _limitFileNameLength(fileName);
    final fileInfo = await FilePickerWritable().openFileForCreate(
      fileName: fileName,
      writer: (file) async {
        await file.writeAsString(data);
        fileX = file;
      },
    );
    if (fileInfo == null) return null;

    filePath = fileInfo.identifier;
  }
  return {'path': filePath, 'file': fileX};
}

String _limitFileNameLength(String fileName) {
  const int maxLength = 30;
  if (fileName.length <= maxLength) return fileName;
  var extension = getFileExtension(fileName);
  return getFileBaseNameWithoutExtension(fileName).substring(0, maxLength - extension.length) + extension;
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

String getFileExtension(String fileName) {
  return fileName == null ? null : extension(fileName);
}

String getFileBaseNameWithoutExtension(String fileName) {
  return fileName == null ? null : basenameWithoutExtension(fileName);
}

String changeExtension(String fileName, String extension) {
  return setExtension(fileName, extension);
}

String normalizePath(String path) {
  return normalize(path);
}

int jpgImageSize(Uint8List data) {
  var sum = 0;
  if (data == null) return null;
  if (getFileType(data) != '.jpg') return null;

  for (int i = 0; i < data.length - 2; i++) {
    // Segment ?
    if ((data[i] == 0xFF) & (data[i + 1] == 0xD8)) {
      var offset = 0;
      sum += 2;
      do {
        offset = _jpgSegmentLength(data, sum);
        sum += offset;
      } while (offset > 0);

      sum += _jpgSosSegmentLength(data, sum);

      return sum;
    }
  }

  return sum;
}

int _jpgSegmentLength(Uint8List data, int offset) {
  // Data Segment and not SOS Segment
  if ((offset + 3 < data.length) & (data[offset] == 0xFF) & (data[offset + 1] != 0xDA))
    return 256 * data[offset + 2] + data[offset + 3] + 2;
  return 0;
}

int _jpgSosSegmentLength(Uint8List data, int offset) {
  //  SOS Segment ?
  if ((offset + 1 < data.length) & (data[offset] == 0xFF) & (data[offset + 1] == 0xDA))
    for (int i = offset + 2; i < data.length - 1; i++)
      // EOI-Segment ?
      if (data[i] == 0xFF && data[i + 1] == 0xD9)
        return i - offset + 2;

  return 0;
}

int pngImageSize(Uint8List data) {

  var startIndex = 0;
  var endIndex = 0;
  if (data == null) return null;
  if (getFileType(data) != '.png') return null;

  for (int i = 0; i < data.length - 3; i++)
  {
    // IDAT ??
    if ((data[i] == 0x49) & (data[i + 1] == 0x44) & (data[i + 2] == 0x41) & (data[i + 3] == 0x54)) {
      startIndex = i + 4;
      break;
    }
  }

  if (startIndex > 0) {
    for (int i = startIndex; i < data.length - 7; i++)
    {
      // IEND ??
      if ((data[i] == 0x49) & (data[i + 1] == 0x45) & (data[i + 2] == 0x4E) & (data[i + 3] == 0x44) &
      (data[i + 4] == 0xAE) & (data[i + 5] == 0x42) & (data[i + 6] == 0x60) & (data[i + 7] == 0x82)) {
        endIndex = i + 4 + 4;
        break;
      }
    }
  }

  return endIndex;
}

int gifImageSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != '.gif') return null;

  var offset = "GIF89a".length; //GIF Signature
  offset += 7; //Screen Descriptor

  //Global Color Map
  offset = _gifColorMap(data, offset, -3);

  do {
    if (offset + 1 >= data.length) return data.length;

    // Application Extension, Comment Extension
    if ((data[offset] == 0x21) & ((data[offset + 1] == 0xFF) | (data[offset] == 0xFE)))
      offset = _gifExtensionBlock(data, offset);
    else
    {
      //Graphics Control Extension (option)
      offset = _gifExtensionBlock(data, offset);

      if (offset + 1 >= data.length) return data.length;

      if ((data[offset] == 0x21) & (data[offset + 1] == 0xFF))
        // Plain Text Extension
        offset = _gifExtensionBlock(data, offset);
      else {
        //Image Descriptor
        offset += 10;

        //Local Color Map
        offset = _gifColorMap(data, offset, -1);

        //Image Data
        offset += 1;
        while ((offset < data.length) & (data[offset] != 0))
        {
          offset += 1;
          offset += data[offset - 1];
        }

        offset += 1; //Terminator 0x00
      }
    }
  } while ((offset >= data.length) | (data[offset] != 0x3B));
  offset += 1; //0x3B

  return min(offset, data.length);
}

int _gifExtensionBlock(Uint8List data, int offset) {
  if (offset >= data.length) return data.length;
  if (data[offset] == 0x21) {
    offset += 3;
    offset += data[offset - 1];
    offset += 1; //Terminator 0x00
  }
  return offset;
}

int _gifColorMap(Uint8List data, int offset, int countOffset) {
  if (offset >= data.length) return data.length;
  if ((data[offset + countOffset] & 0x80) != 0) {
    var bitsPerPixel = (data[offset + countOffset] & 0x7) + 1;
    offset += (pow(2, bitsPerPixel) * 3).toInt();
  }

  return offset;
}
