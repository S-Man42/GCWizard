import 'dart:typed_data';

import 'package:gc_wizard/widgets/utils/file_utils.dart';

List<Uint8List> extraData(Uint8List data, {List<Uint8List> resultList}) {
  if (data == null) return resultList;
  int imageLength;

  switch (getFileType(data)) {
    case FileType.JPEG:
      imageLength = jpgImageSize(data);
      break;
    case FileType.PNG:
      imageLength = pngImageSize(data);
      break;
    case FileType.GIF:
      imageLength = gifImageSize(data);
      break;
    case FileType.BMP:
      imageLength = bmpImageSize(data);
      break;
    case FileType.ZIP:
      imageLength = zipFileSize(data);
      break;
    case FileType.RAR:
      imageLength = rarFileSize(data);
      break;
    case FileType.MP3:
      imageLength = mp3FileSize(data);
      break;
    default:
      return resultList;
  }

  if ((imageLength != null) && (imageLength > 0) && (data.length > imageLength)) {
    if (resultList == null) resultList = <Uint8List>[];
    // result data
    var result = data.sublist(imageLength);
    // remove result from sourece data
    data = data.sublist(0, imageLength);
    resultList = extraData(result, resultList: resultList);

    resultList.add(result);
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