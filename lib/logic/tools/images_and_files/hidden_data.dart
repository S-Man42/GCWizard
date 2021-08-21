import 'dart:typed_data';

import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

List<PlatformFile> hiddenData(PlatformFile data) {
  if (data == null)
    return [];

  var resultList = <PlatformFile>[];
  var fileCounter = 0;

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
        return resultList;
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

    if (fileCounter > 0) {
      var children;
      if (fileClass(detectedFileType) == FileClass.ARCHIVE) {
        children = extractArchive(PlatformFile(bytes: resultBytes));
      }

      var result = PlatformFile(
        name: 'hidden_file_$fileCounter.${fileExtension(detectedFileType)}',
        bytes: resultBytes,
        children: children
      );

      resultList.add(result);
    }

    fileCounter++;
  }

  return resultList;
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