import 'dart:typed_data';

import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

List<PlatformFile> hiddenData(PlatformFile data, { bool ignoreFirstEntry = true}) {
  if (data == null)
    return [];

  var resultList = <PlatformFile>[];

  var bytes = data.bytes;

  while (bytes != null && bytes.length > 0) {
    int imageLength;
    FileType detectedFileType = getFileType(bytes);

    switch (detectedFileType) {
      case FileType.JPEG:
        imageLength = jpgImageSize(bytes);
        break;
      case FileType.PNG:
        imageLength = pngImageSize(bytes);
        break;
      case FileType.GIF:
        imageLength = gifImageSize(bytes);
        break;
      case FileType.BMP:
        imageLength = bmpImageSize(bytes);
        break;
      case FileType.ZIP:
        imageLength = zipFileSize(bytes);
        break;
      case FileType.RAR:
        imageLength = rarFileSize(bytes);
        break;
      case FileType.MP3:
        imageLength = mp3FileSize(bytes);
        break;
      default:
        imageLength = bytes.length;
        break;
    }

    var resultBytes;
    if ((imageLength != null) && (imageLength > 0) && (bytes.length > imageLength)) {
      resultBytes = bytes.sublist(0, imageLength);
      // remove result from source data
      bytes = bytes.sublist(imageLength);
    } else {
      resultBytes = bytes;
      bytes = null;
    }

    var fileCounter = resultList.length;
    //if (fileCounter > 0 || !ignoreFirstEntry) {
      List<PlatformFile> children;
      if (fileClass(detectedFileType) == FileClass.ARCHIVE) {
        children = extractArchive(PlatformFile(bytes: resultBytes));
      }

      var result = PlatformFile(
        name: 'hidden_file_$fileCounter.${fileExtension(detectedFileType)}',
        bytes: resultBytes,
        children: children == null ? <PlatformFile>[] : children
      );

      resultList.add(result);

      var magicBytesList = List<List<int>>.from(magicBytes(FileType.JPEG));
      magicBytesList.addAll(magicBytes(FileType.PNG));
      magicBytesList.addAll(magicBytes(FileType.GIF));
      magicBytesList.addAll(magicBytes(FileType.ZIP));
      magicBytesList.addAll(magicBytes(FileType.RAR));
      if (children == null)
        searchMagicBytes(result, magicBytesList);
      else {
        children.forEach((element) {
          searchMagicBytes(element, magicBytesList);
          element == element;
        });
      }
    //}
  }
  if (ignoreFirstEntry && resultList.length>0) resultList.removeAt(0);
  return resultList;
}

searchMagicBytes(PlatformFile data, List<List<int>> magicBytesList) {
  magicBytesList.forEach((magicBytes) {
    var bytes = data.bytes;
    for (int i = 1; i < bytes.length; i++) {
      if (bytes[i] == magicBytes[0] && ((i + magicBytes.length) <= bytes.length)) {
        var valid = true;
        for (int offset = 1; offset < magicBytes.length; offset++) {
          if (bytes[i + offset] != magicBytes[offset]) {
            valid = false;
            break;
          }
        }
        if (valid) {
          var children = hiddenData(PlatformFile(bytes: bytes.sublist(i)), ignoreFirstEntry: false);
          if ((children != null) && (children.length > 0)) {
            if (data.children == null)
              data = PlatformFile(path: data.path,
                                  name: data.name,
                                  bytes: data.bytes,
                                  children: children);
            else
              data.children.addAll(children);
          }
        }
      }
    }
  });
}

Uint8List mergeFiles(List<dynamic> data) {
  if (data == null) return null;
  var result = <int>[];

  data.forEach((element) {
    if (element is Uint8List)
      result.addAll(element);
    else if (element is String)
      result.addAll(Uint8List.fromList(element.toString().codeUnits));
  });
  return Uint8List.fromList(result);
}