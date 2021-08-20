import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:tuple/tuple.dart';

enum FileType {ZIP, RAR, TAR, SEVEN_ZIP, JPEG, PNG, GIF, TIFF, WEBP, WMV, MP3, PDF, EXE, BMP, TXT, GPX, KML, KMZ}
enum FileClass { IMAGE, ARCHIVE, SOUND, DATA, TEXT }

const Map<FileType, Map<String, dynamic>> _FILE_TYPES = {
  FileType.JPEG : {
    'extensions': ['jpg', 'jpeg'],
    'magic_bytes': [
      [0xFF, 0xD8, 0xFF, 0xE0],
      [0xFF, 0xD8, 0xFF, 0xE1],
      [0xFF, 0xD8, 0xFF, 0xFE]
    ],
    'file_class' : FileClass.IMAGE
  },
  FileType.GIF : {
    'extensions': ['gif'],
    'magic_bytes': [
      [0x47, 0x49, 0x46, 0x38, 0x39, 0x61],
      [0x47, 0x49, 0x46, 0x38, 0x37, 0x61]
    ],
    'file_class' : FileClass.IMAGE
  },
  FileType.PNG : {
    'extensions': ['png'],
    'magic_bytes': [
      [0x89, 0x50, 0x4E, 0x47]
    ],
    'file_class' : FileClass.IMAGE
  },
  FileType.BMP : {
    'extensions': ['bmp'],
    'magic_bytes': [
      [0x42, 0x4D]
    ],
    'file_class' : FileClass.IMAGE
  },
  FileType.TIFF : {
    'extensions': ['tiff', 'tif'],
    'magic_bytes': [
      [0x49, 0x49, 0x2A, 0x00],
      [0x4D, 0x4D, 0x00, 0x2A]
    ],
    'file_class' : FileClass.IMAGE
  },
  FileType.WEBP : {
    'extensions': ['webp'],
    'magic_bytes': [
      [0x52, 0x49, 0x46, 0x46]
    ],
    'file_class' : FileClass.IMAGE
  },
  FileType.ZIP : {
    'extensions': ['zip'],
    'magic_bytes': [
      [0x50, 0x4B, 0x03, 0x04]
    ],
    'file_class' : FileClass.ARCHIVE
  },
  FileType.TAR : {
    'extensions': ['tar'],
    'magic_bytes': [
      [0x75, 0x73, 0x74, 0x61, 0x72]
    ],
    'file_class' : FileClass.ARCHIVE
  },
  FileType.RAR : {
    'extensions': ['rar'],
    'magic_bytes': [
      [0x1F, 0x8B, 0x08, 0x00],
      [0x52, 0x61, 0x72, 0x21, 0x1A, 0x07, 0x00],
      [0x52, 0x61, 0x72, 0x21, 0x1A, 0x07, 0x01, 0x00]
    ],
    'file_class' : FileClass.ARCHIVE
  },
  FileType.SEVEN_ZIP : {
    'extensions': ['7z', '7zip'],
    'magic_bytes': [
      [0x30, 0x26, 0xB2, 0x75]
    ],
    'file_class' : FileClass.ARCHIVE
  },
  FileType.WMV : {
    'extensions': ['wmv'],
    'magic_bytes': [
      [0x30, 0x26, 0xB2, 0x75]
    ],
    'file_class' : FileClass.SOUND
  },
  FileType.MP3 : {
    'extensions': ['mp3'],
    'magic_bytes': [
      [0x49, 0x44, 0x33],
      [0xFF, 0xFB],
      [0xFF, 0xF3],
      [0xFF, 0xF2]
    ],
    'file_class' : FileClass.SOUND
  },
  FileType.PDF : {
    'extensions': ['pdf'],
    'magic_bytes': [
      [0x25, 0x50, 0x44, 0x46]
    ],
    'file_class' : FileClass.DATA
  },
  FileType.EXE : {
    'extensions': ['exe'],
    'magic_bytes': [
      [0x4D, 0x5A, 0x50, 0x00],
      [0x4D, 0x5A, 0x90, 0x00]
    ],
    'mime_type' : FileClass.DATA
  },
  FileType.GPX : {
    'extensions': ['gpx'],
    'magic_bytes': [<int>[]],
    'file_class' : FileClass.DATA,
    'mime_type' : 'application/gpx+xml',
    'uniform_type_identifier': 'com.topografix.gpx'
  },
  FileType.KML : {
    'extensions': ['kml'],
    'magic_bytes': [<int>[]],
    'file_class' : FileClass.DATA,
    'mime_type' : 'application/vnd.google-earth.kml+xml',
    'uniform_type_identifier': 'com.google.earth.kml'
  },
  FileType.KMZ : {
    'extensions': ['kmz'],
    'magic_bytes': [<int>[]],
    'file_class' : FileClass.DATA,
    'mime_type' : 'application/vnd.google-earth.kmz'
  },
};

FileType fileTypeByExtension(String extension) {
  extension = extension.split('.').last;
  return _FILE_TYPES.keys.firstWhere((type) => _FILE_TYPES[type]['extensions'].contains(extension), orElse: () => null);
}

String fileExtension(FileType type) {
  if (type == null) return '';
  return _FILE_TYPES[type]['extensions'].first;
}

List<String> fileExtensions (List<FileType> types) {
  return types.map((type) => _FILE_TYPES[type]['extensions']).expand((extensions) => extensions).toList();
}

List<String> fileExtensionsByFileClass (FileClass _fileClass) {
  return fileExtensions(fileTypesByFileClass(_fileClass));
}

List<FileType> fileTypesByFileClass (FileClass _fileClass) {
  return _FILE_TYPES.keys.where((type) => fileClass(type) == _fileClass).toList();
}

FileClass fileClass(FileType type) {
  if (type == null) return null;
  return _FILE_TYPES[type]['file_class'];
}

List<List<int>> magicBytes(FileType type) {
  return _FILE_TYPES[type]['magic_bytes'];
}

String mimeType(FileType type) {
  return _FILE_TYPES[type]['mime_type'];
}

String uniformTypeIdentifier(FileType type) {
  return _FILE_TYPES[type]['uniform_type_identifier'];
}

Future<bool> checkStoragePermission() async {
  var _permissionStatus = await Permission.storage.status;

  if (_permissionStatus.isPermanentlyDenied)
    return false;

  if (!_permissionStatus.isGranted) {
    await Permission.storage.request();

    if (!await Permission.storage.isGranted)
      return false;
  }

  return true;
}

Future<Map<String, dynamic>> saveByteDataToFile(ByteData data, String fileName, {String subDirectory}) async {
  var storagePermission = await checkStoragePermission();
  if (!storagePermission)
    return null;

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

    filePath = await FlutterAbsolutePath.getAbsolutePath(fileInfo.identifier);
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

    filePath = await FlutterAbsolutePath.getAbsolutePath(fileInfo.identifier);
  }
  return {'path': filePath, 'file': fileX};
}

String _limitFileNameLength(String fileName) {
  const int maxLength = 30;
  if (fileName.length <= maxLength) return fileName;
  var extension = getFileExtension(fileName);
  return getFileBaseNameWithoutExtension(fileName).substring(0, maxLength - extension.length) + extension;
}

shareFile(String path, FileType type) {
  ShareExtend.share(path, "file");
}

openFile(String path, FileType type) {
  if (type != null) {
    OpenFile.open(path,
      type: mimeType(type),
      uti: uniformTypeIdentifier(type));
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

bool isImage(Uint8List blobBytes) {
  try {
    FileType fileType = getFileType(blobBytes);
    return _FILE_TYPES[fileType]['file_class'] == FileClass.IMAGE;
  } catch(e) {
    return false;
  }
}

FileType getFileType(Uint8List blobBytes, {FileType defaultType = FileType.TXT}) {
  for (var fileType in _FILE_TYPES.keys) {
    var _magicBytes = magicBytes(fileType);

    if ((_magicBytes == null) | (_magicBytes.length == 0) | (_magicBytes[0].length == 0)) return null;
    for (var bytes in _magicBytes) {
      if (blobBytes.length >= bytes.length && ListEquality().equals(blobBytes.sublist(0, bytes.length), bytes))
        return fileType;
    }
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
  if (getFileType(data) != FileType.JPEG) return null;

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
  if (getFileType(data) != FileType.PNG) return null;

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
  if (getFileType(data) != FileType.GIF) return null;

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

int zipFileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != '.zip') return null;

  var offset = 0;
  if (offset + 30 > data.length) return null;

  // ZIP Signature file header
  while ((data[offset] == 0x50) & (data[offset + 1] == 0x4B) & (data[offset + 2] == 0x03) & (data[offset + 3] == 0x04)) {
    offset += 30;

    var fileNameLength = data.buffer.asByteData(offset - 4, 2).getInt16(0, Endian.little);
    var extraFieldLength = data.buffer.asByteData(offset - 2, 2).getInt16(0, Endian.little);
    var compressedSize = data.buffer.asByteData(offset - 12, 4).getInt32(0, Endian.little);

    offset += fileNameLength + extraFieldLength + compressedSize;
  }

  bool fileHeaderFound = false;
  do {
    if (offset + 4 >= data.length) return offset;

    fileHeaderFound = false;
    // central directory file header
    if ((data[offset] == 0x50) & (data[offset + 1] == 0x4B) & (data[offset + 2] == 0x01) & (data[offset + 3] == 0x02)) {
      if (offset + 46 > data.length) return null;

      offset += 46;
      var fileNameLength = data.buffer.asByteData(offset - 18, 2).getInt16(0, Endian.little);
      var extraFieldLength = data.buffer.asByteData(offset - 16, 2).getInt16(0, Endian.little);
      var commentLength = data.buffer.asByteData(offset - 14, 2).getInt16(0, Endian.little);

      offset += fileNameLength + extraFieldLength + commentLength;
      fileHeaderFound = true;
    }

    // header end central directory
    else if ((data[offset] == 0x50) & (data[offset + 1] == 0x4B) & (data[offset + 2] == 0x05) & (data[offset + 3] == 0x06)) {
      if (offset + 22 > data.length) return null;

      offset += 22;
      var commentLength = data.buffer.asByteData(offset - 2, 2).getInt16(0, Endian.little);
      offset += commentLength;
    }
  } while (fileHeaderFound);

  return offset;
}

int bmpImageSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.BMP) return null;

  var offset = 0;

  return data.buffer.asByteData(offset + 2).getInt32(0, Endian.little);
}

int rarFileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.RAR) return null;

  var offset = 0;
  bool archiveBlockFound = false;
  var fileNames = <String>[];

  // header RAR 5.0
  if ((data[offset] == 0x52) & (data[offset + 1] == 0x61) & (data[offset + 2] == 0x72) & (data[offset + 3] == 0x21) & (data[offset + 4] == 0x1A) & (data[offset + 5] == 0x07) & (data[offset + 6] == 0x01) & (data[offset + 7] == 0x00)) {
    offset += 8;
  } else return null;

  do {
    archiveBlockFound = false;

    offset += 4; // HeaderCRC32

    var dataSizeAdd = 0;
    var headerSize = _rarVint(data, offset);
    offset += headerSize.item2;
    var headerTypePos = offset;

    var headerType = _rarVint(data, offset);
    offset += headerType.item2;

    var headerFlags = _rarVint(data, offset);
    offset += headerFlags.item2;

    switch (headerType.item1) {
      case 1: // Main archive header
        archiveBlockFound = true;
        break;
      case 2: // file header
      case 3: // service header
        archiveBlockFound = true;

        if ((headerFlags.item1 & 0x01) != 0)
          offset += _rarVint(data, offset).item2; // Extra area size

        if ((headerFlags.item1 & 0x02) != 0) {
          var dataSize = _rarVint(data, offset); // Data size
          offset += dataSize.item2;
          dataSizeAdd = dataSize.item1;
        }

        offset += _rarVint(data, offset).item2; // File flags
        offset += _rarVint(data, offset).item2; // unpacked size
        offset += _rarVint(data, offset).item2; // attributes
        if ((headerFlags.item1 & 0x02) != 0) offset += 4; // mtime
        if ((headerFlags.item1 & 0x04) != 0) offset += 4; // data CRC32
        offset += _rarVint(data, offset).item2; // Compression information
        offset += _rarVint(data, offset).item2; // Host OS

        var nameLength = _rarVint(data, offset); // Name length
        offset += nameLength.item2;

        var nameArray = data.sublist(offset, nameLength.item1);
        var name = utf8.decode(nameArray);
        if ((name != null) & (name.length > 0))
          fileNames.add(name);
        offset += nameLength.item1; //Name

        break;
      case 4: // Archive encryption header
        archiveBlockFound = true;

        offset += _rarVint(data, offset).item2; // Encryption version
        offset += _rarVint(data, offset).item2; // Encryption flags
        offset += 1; // KDF count
        offset += 16; // Salt
        offset += 12; // Check value

        break;
      case 5: // End of archive header
        offset += _rarVint(data, offset).item2; // End of archive flags

        break;
    }
    offset = headerTypePos + headerSize.item1+ dataSizeAdd;

  } while (archiveBlockFound);

  return offset;
}

Tuple2<int, int> _rarVint(Uint8List data, int offset) {
  var index = 0;
  var value = 0;
  if (offset >= data.length) return Tuple2<int, int>(0, 0);

  do {
    value |= ((data[offset + index] & 0x7F) << index * 7);
    index++;
  } while (((offset + index) < data.length) & ((data[offset + index - 1] & 0x80) != 0));

  return new Tuple2<int, int>(value, index);
}

int mp3FileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.MP3) return null;

  int offset = 0;
  bool frameFound = false;
  var bitRates = <int>[ 0, 32000, 40000, 48000, 56000, 64000, 80000, 96000, 112000, 128000, 160000, 192000, 224000, 256000, 320000 ];
  var sampleRates = <int>[ 44100, 48000, 32000 ];

  do {
    frameFound = false;

    if ((offset + 4 < data.length) && (data[offset] == 0xFF) & ((data[offset + 1] & 0xE0) == 0xE0)) {// Frame Header

      var bitrateIndex = (data[offset + 2] & 0xF0) >> 4;
      if ((bitrateIndex <= 0) | (bitrateIndex > bitRates.length))
        return null;

      var sampleRateIndex = (data[offset + 2] & 0xC) >> 2;
      if ((sampleRateIndex < 0) | (sampleRateIndex > sampleRates.length))
        return null;

      var padding = (data[offset + 2] & 0x02) != 0 ? 1 : 0;

      var frameLen = ((144 * bitRates[bitrateIndex] / sampleRates[sampleRateIndex]) + padding).toInt();
      frameFound = true;
      offset += frameLen;

    } else if ((offset + 3 < data.length) && (data[offset] == 0x54) & (data[offset + 1] == 0x41) & (data[offset + 2] == 0x47)) {//ID3v1/ ID3v1.1 TAG

      offset += 3; // TAG
      offset += 30; // title
      offset += 30; // artist
      offset += 30; // album
      offset += 4; // year
      offset += 30; // comment
      offset += 1; // genre
      
    } else if ((offset + 3 < data.length) &&
        (((data[offset] == 0x49) & (data[offset + 1] == 0x44) & (data[offset + 2] == 0x33)) | //  ID3v2
        ((data[offset] == 0x33) & (data[offset + 1] == 0x44) & (data[offset + 2] == 0x49)))) {//  ID3v2 Footer

      var footer = (data[offset] == 0x33) & (data[offset + 1] == 0x44) & (data[offset + 2] == 0x49);//  ID3v2 Footer
      offset += 10;
      var extendedHeader = ((data[offset - 5] & 0x40) != 0);
      offset += mp3Vint(data, offset - 4); //bigEndian

      // extendedHeader
      if (extendedHeader) {
        offset += mp3Vint(data, offset); //bigEndian
        offset += 4;
      }

      frameFound = !footer;
    }
  } while (frameFound);

  return offset;
}

int mp3Vint(Uint8List data, int offset) {
  var value = 0;
  if (offset + 3 >= data.length) return 0;

  // big EndianFormat
  for (int i = 0; i < 4; i++)
    value |= ((data[offset + 3 - i] & 0x7F) << i * 7);

  return value;
}


Future<Uint8List> createZipFile(String fileName, List<Uint8List> imageList) async {
  try {
    String tmpDir = (await getTemporaryDirectory()).path;
    var counter = 0;
    var zipPath = '$tmpDir/gcwizardtmp.zip';
    var pointIndex = fileName.lastIndexOf('.');
    // FileType extension = getFileType(imageList[0]);
    if (pointIndex > 0) fileName = fileName.substring(0, pointIndex);

    var encoder = ZipFileEncoder();
    encoder.create(zipPath);

    for (Uint8List imageBytes in imageList) {
      counter++;
      var fileNameZip = '$fileName' + '_$counter$extension';
      var tmpPath = '$tmpDir/$fileNameZip';
      if (File(tmpPath).existsSync()) File(tmpPath).delete();

      File imageFileTmp = new File(tmpPath);
      imageFileTmp = await imageFileTmp.create();
      imageFileTmp = await imageFileTmp.writeAsBytes(imageBytes);

      encoder.addFile(imageFileTmp, fileNameZip);
      imageFileTmp.delete();
    };

    encoder.close();

    var bytes = File(encoder.zip_path).readAsBytesSync();
    await File(encoder.zip_path).delete();

    return bytes;
  } on Exception {
    return null;
  }
}
