import 'dart:io';
import 'dart:typed_data';

class VINT {
  final List<int> _ints = [];

  int get result => merge(Uint8List.fromList(_ints), true);

  VINT.fromFile(RandomAccessFile file) {
    bool continuationFlag = false;
    do {
      // Read byte
      int byte = file.readByteSync();

      // Clear the most significant bit [continuation_flag] and add to list of integers
      _ints.add(byte & ~(0x80));

      // Get the most significant bit (continuation_flag)
      continuationFlag = (byte & 0x80 != 0) ? true : false;
    } while (continuationFlag);
  }

  VINT.fromList(Uint8List list) {
    int index = 0;
    bool continuationFlag = false;
    do {
      // Read byte
      int byte = list[index++];

      // Clear the most significant bit [continuation_flag] and add to list of integers
      _ints.add(byte & ~(0x80));

      // Get the most significant bit (continuation_flag)
      continuationFlag = (byte & 0x80 != 0) ? true : false;
    } while (continuationFlag);
    list.removeRange(0, index);
  }
}


int merge(Uint8List list, [bool littleEndian = false]) {
  return Uint8List.fromList(littleEndian ? list.reversed.toList() : list)
      .reduce((value, newElement) => newElement | (value << 8));
}

