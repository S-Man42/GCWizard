import 'dart:typed_data';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

const HIDDEN_FILE_IDENTIFIER = '<<!!!HIDDEN_FILE!!!>>';

List<PlatformFile> hiddenData(PlatformFile data, { bool calledFromSearchMagicBytes = false, int fileIndex = 0}) {
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
      case FileType.TAR:
        imageLength = tarFileSize(bytes);
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

    List<PlatformFile> children;
    if (fileClass(detectedFileType) == FileClass.ARCHIVE)
      children = extractArchive(PlatformFile(bytes: resultBytes));

    resultBytes = trimNullBytes(resultBytes);
    if (resultBytes.length > 0) {
      var fileCounter = fileIndex + resultList.length;
      var result = PlatformFile(
          name: HIDDEN_FILE_IDENTIFIER + '_$fileCounter',
          bytes: resultBytes,
          children: children
      );

      resultList.add(result);
    }

    if (calledFromSearchMagicBytes) break;
  }

  if (!calledFromSearchMagicBytes) {
    var fileTypeList = <FileType>[FileType.JPEG, FileType.PNG, FileType.GIF, FileType.ZIP, FileType.RAR, FileType.TAR];

    resultList.asMap().forEach((index, result) {
      if (index == 0 && result.fileClass != FileClass.ARCHIVE)
        return;

      if ((result.children == null) || (result.children.length == 0))
        _searchMagicBytes(result, fileTypeList);
      else
        result.children.forEach((element) {_searchMagicBytes(element, fileTypeList);});
    });
  }
  return resultList;
}

_searchMagicBytes(PlatformFile data, List<FileType> fileTypeList) {
  fileTypeList.forEach((fileType) {
    var magicBytesList = magicBytes(fileType);
    magicBytesList.forEach((magicBytes) {
      var bytes = data.bytes;
      if (bytes == null)
        return;

      for (int i = 1; i < bytes.length; i++) {
        if (bytes[i] == magicBytes[0] && ((i + magicBytes.length) <= bytes.length)) {
          var validMagicBytes = true;
          for (int offset = 1; offset < magicBytes.length; offset++) {
            if (bytes[i + offset] != magicBytes[offset]) {
              validMagicBytes = false;
              break;
            }
          }

          if (validMagicBytes) {
            var bytesOffset = magicBytesOffset(fileType) ?? 0;
            if (i - bytesOffset >= 0) {
              var children = hiddenData(PlatformFile(bytes: bytes.sublist(i - bytesOffset)),
                  calledFromSearchMagicBytes: true,
                  fileIndex: data.children.length + 1);
              if ((children != null) && (children.length > 0)) {
                if (data.children != null)
                  data.children.addAll(children);
              }
            }
          }
        }
      }
    });
  });
}

Uint8List mergeFiles(List<dynamic> data) {
  if (data == null) return null;
  var result = <int>[];

  data.forEach((element) {
    if (element is Uint8List)
      result.addAll(trimNullBytes(element));
    else if (element is String)
      result.addAll(Uint8List.fromList(element.toString().codeUnits));
  });

  return trimNullBytes(Uint8List.fromList(result));
}