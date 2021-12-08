import 'dart:typed_data';

import 'vint.dart';

class Record {
  int size;
  int type;

  Record(Uint8List list) {
    size = VINT.fromList(list).result;
    type = VINT.fromList(list).result;
  }
}

class FileEncryption {
  Record header;
  int version; // vint  0
  int flags; // vint  3
  int kdf_count; // 1 byte  15
  int salt; // 16 bytes  155, 174, 90, 241, 142, 25, 221, 158, 100, 169, 176, 200, 60, 216, 77, 163
  int iv; // 16 bytes  245, 65, 228, 101, 246, 0, 154, 224, 32, 47, 115, 92, 207, 125, 112, 134
  int check_value; // 12 bytes 99, 133, 127, 218, 35, 87, 250, 141, 50, 57, 103, 183

  FileEncryption(Uint8List extra, this.header) {
    version = VINT.fromList(extra).result;
    flags = VINT.fromList(extra).result;
  }
}
