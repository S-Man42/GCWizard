import 'dart:convert';
import 'dart:typed_data';

import 'rar_decoder.dart';

class RarFile {
  String name;
  String path;
  List<String> hierarchy;
  Uint8List content;
  Uint8List extra;
  int _flags;
  int _compressionInfo;
  String parent;
  List<RarFile> children = [];

  int get compressionVersion => _compressionInfo & 0x003f;

  bool get solidFlag => (_compressionInfo & 0x0040) == 1;

  int get compressionMethod => _compressionInfo & 0x0380;

  bool get isDirectory => (_flags & 1) == 1;

  RarFile(FILE_SERVICE_BLOCK block) {
    hierarchy = utf8.decode(block.NAME).split('/');
    path = utf8.decode(block.NAME);
    name = hierarchy.last;
    parent = (hierarchy.length > 1) ? hierarchy.sublist(0, hierarchy.length - 1).join('/') : null;
    extra = block.EXTRA_AREA;
    content = block.DATA_AREA;
    _flags = block.FILE_FLAGS;
    _compressionInfo = block.COMPRESSION_INFO;
  }
}
