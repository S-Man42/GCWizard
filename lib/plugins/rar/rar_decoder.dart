// source code from https://github.com/omarahmad293/rar_dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'rarFile.dart';
import 'vint.dart';


class RAR5 {
  static const SIGNATURE = 0x0001071A21726152; //[0x52, 0x61, 0x72, 0x21, 0x1A, 0x07, 0x01, 0x00];
  MAIN_ARCHIVE_HEADER MAIN_HEAD;
  ARCHIVE_ENCRYPTION ARCHIVE_ENCRYPTION_BLOCK;
  List<FILE_SERVICE_BLOCK> SERVICE_BLOCKS = [];
  List<RarFile> _files = [];
  END_OF_ARCHIVE END_OF_ARCHIVE_BLOCK;

  List<RarFile> hierarchy = [];

  String get comment => utf8.decode(SERVICE_BLOCKS.first?.DATA_AREA);

  get files => _files;

  RAR5(path) {
    var file = File(path);
    var randomAccessFile = file.openSync(mode: FileMode.read);

    var signature = merge(randomAccessFile.readSync(8), true);
    if (signature != SIGNATURE) {
      throw RAR5Exception('Wrong signature');
    }

    // assert(signature == [0x52, 0x61, 0x72, 0x21, 0x1A, 0x07, 0x00].merge(true),
    //     '$path is not a .rar file version 4.');

    while (randomAccessFile.positionSync() < randomAccessFile.lengthSync()) {
      var header = Header(randomAccessFile);

      // Check HEAD_TYPE and create a block object accordingly
      switch (header.HEAD_TYPE) {
        case 1:
          MAIN_HEAD = MAIN_ARCHIVE_HEADER(randomAccessFile, header);
          break;
        case 2:
          FILE_SERVICE_BLOCK block = FILE_SERVICE_BLOCK(randomAccessFile, header);
          RarFile file = RarFile(block);
          _files.add(file);
          break;
        case 3:
          SERVICE_BLOCKS.add(FILE_SERVICE_BLOCK(randomAccessFile, header));
          break;
        case 4:
          ARCHIVE_ENCRYPTION_BLOCK = ARCHIVE_ENCRYPTION(randomAccessFile, header);
          break;
        case 5:
          END_OF_ARCHIVE_BLOCK = END_OF_ARCHIVE(randomAccessFile, header);
          break;
        default:
          throw Exception('Unknown block');
      }
    }
    _createHierarchy();
    randomAccessFile.closeSync();
  }

  /// Joins files inside a directory to their parent directory
  void _createHierarchy() {
    List<RarFile> removed = [];
    for (RarFile file in _files) {
      if (removed.contains(file)) {
        continue;
      }
      if (file.parent != null) {
        int i = _files.indexWhere((f) => f.path == file.parent);
        _files[i].children.add(file);
        removed.add(file);
      }
    }
    for (RarFile r in removed) {
      _files.remove(r);
    }
  }

  /// Prints file hierarchy inside the archive
  void showFiles([List<RarFile> listOfNodes, int level]) {
    if (listOfNodes == null) {
      listOfNodes = _files;
    }

    if (level == null) {
      level = 0;
    }
    for (var file in listOfNodes) {
      print('${'\t' * level}${file.name}');

      if (!file.children.isEmpty) {
        showFiles(file.children, level + 1);
      }
    }
  }
}

class Header {
  int HEAD_CRC; // 4 bytes
  int HEAD_TYPE; // vint
  int HEAD_FLAGS; // vint
  int HEAD_SIZE; // vint

  Header(RandomAccessFile file) {
    HEAD_CRC = merge(file.readSync(4), true);
    HEAD_SIZE = VINT.fromFile(file).result;
    HEAD_TYPE = VINT.fromFile(file).result;
    HEAD_FLAGS = VINT.fromFile(file).result;
  }
}

abstract class Block {
  Header header;

  Block(this.header);
}

class MAIN_ARCHIVE_HEADER extends Block {
  int EXTRA_AREA_SIZE, ARCHIVE_FLAGS, VOLUME_NUMBER;
  var EXTRA_AREA;

  MAIN_ARCHIVE_HEADER(RandomAccessFile file, Header header) : super(header) {
    EXTRA_AREA_SIZE = (super.header.HEAD_FLAGS & 0x0001 != 0) ? VINT.fromFile(file).result : null;
    ARCHIVE_FLAGS = VINT.fromFile(file).result;
    VOLUME_NUMBER = (super.header.HEAD_FLAGS & 0x0002 != 0) ? VINT.fromFile(file).result : null;
    EXTRA_AREA = (super.header.HEAD_FLAGS & 0x0001 != 0) ? file.readSync(EXTRA_AREA_SIZE) : null;
  }
}

class FILE_SERVICE_BLOCK extends Block {
  int EXTRA_AREA_SIZE,
      DATA_SIZE,
      FILE_FLAGS,
      UNP_SIZE,
      ATTRIBUTES,
      MTIME,
      DATA_CRC,
      COMPRESSION_INFO,
      HOST_OS,
      NAME_SIZE;

  Uint8List EXTRA_AREA;

  Uint8List DATA_AREA, NAME;

  FILE_SERVICE_BLOCK(RandomAccessFile file, Header header) : super(header) {
    EXTRA_AREA_SIZE = (super.header.HEAD_FLAGS & 0x0001 != 0) ? VINT.fromFile(file).result : null;
    DATA_SIZE = (super.header.HEAD_FLAGS & 0x0002 != 0) ? VINT.fromFile(file).result : null;
    FILE_FLAGS = VINT.fromFile(file).result;
    UNP_SIZE = VINT.fromFile(file).result;
    ATTRIBUTES = VINT.fromFile(file).result;
    MTIME = (FILE_FLAGS & 0x0002 != 0) ? merge(file.readSync(4), true) : null;
    DATA_CRC = (FILE_FLAGS & 0x0004 != 0) ? merge(file.readSync(4), true) : null;
    COMPRESSION_INFO = VINT.fromFile(file).result;
    HOST_OS = VINT.fromFile(file).result;
    NAME_SIZE = VINT.fromFile(file).result;
    NAME = file.readSync(NAME_SIZE);
    EXTRA_AREA = (super.header.HEAD_FLAGS & 0x0001 != 0) ? file.readSync(EXTRA_AREA_SIZE) : null;
    DATA_AREA = (super.header.HEAD_FLAGS & 0x0002 != 0) ? file.readSync(DATA_SIZE) : null;
  }
}

class END_OF_ARCHIVE extends Block {
  int END_OF_ARCHIVE_FLAGS;

  END_OF_ARCHIVE(RandomAccessFile file, Header header) : super(header) {
    END_OF_ARCHIVE_FLAGS = VINT.fromFile(file).result;
  }
}

class ARCHIVE_ENCRYPTION extends Block {
  int ENCYRPTION_VERSION; // vint
  int ENCYRPTION_FLAGS; // vint
  int KDF_COUNT; // 1 byte
  int SALT; // 16 bytes
  int CHECK_VALUE; // 12 bytes

  ARCHIVE_ENCRYPTION(RandomAccessFile file, Header header) : super(header) {
    ENCYRPTION_VERSION = VINT.fromFile(file).result;
    ENCYRPTION_FLAGS = VINT.fromFile(file).result;
    KDF_COUNT = merge(file.readSync(1), true);
    SALT = merge(file.readSync(16), true);
    CHECK_VALUE = merge(file.readSync(12), true);
  }
}

class RAR5Exception implements Exception {
  String cause;

  RAR5Exception(this.cause);
}
