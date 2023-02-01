import 'dart:io' as io;
import 'dart:typed_data';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/common/gcw_file.dart';
import 'package:gc_wizard/common/file_utils.dart';
import 'package:gc_wizard/tools/images_and_files/hidden_data/logic/hidden_data.dart';
import 'package:path/path.dart' as path;

var testDirPath = 'test/tools/images_and_files/hidden_data/resources/';

Uint8List _getFileData(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

String _fileDescription(GCWFile file) {
  var output = '';

  if (file == null) return '';
  output += (file.name != null ? file.name : '') + ', ';
  var fileType = getFileType(file.bytes);
  output += (fileType != null ? fileType.name : '') + ', ';
  output += (file.bytes != null ? file.bytes.length.toString() : '0') + ' bytes, ';

  return output;
}

String _fileStructureToString(List<GCWFile> structure, {int offset = 0}) {
  var output = '';

  if (structure == null) return null;

  structure.forEach((file) {
    var description  = _fileDescription(file);
    if (description != null)
      output += ''.padRight(offset, ' ') + description;
    if (file.children != null)
      output += '\n' + _fileStructureToString(file.children, offset: offset + 4);
  });

  return output;
}

void main() {
  group("hidden_data.hiddenData:", () {
    List<Map<String, dynamic>> _inputsToExpected = [

      {'input' : 'hidden.zip', 'expectedOutput' :
          'hidden.zip, ZIP, 164 bytes, \n'
          '    hidden.TXT, TXT, 6 bytes, \n'
          ''},
      {'input' : 'hidden1.jpg', 'expectedOutput' : 'hidden1.jpg, JPEG, 1489 bytes, '},
      {'input' : 'hidden2.jpg', 'expectedOutput' : 'hidden2.jpg, JPEG, 87428 bytes, '},
      {'input' : 'hidden3.jpg', 'expectedOutput' : 'hidden3.jpg, JPEG, 1489 bytes, '},
      {'input' : 'hidden4.jpg', 'expectedOutput' :
          'hidden4.jpg, JPEG, 4193 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, ZIP, 313 bytes, \n'
          '        QuickResponse.bin, TXT, 0 bytes, \n'
          ''},
      {'input' : 'hidden5.jpg', 'expectedOutput' : 'hidden5.jpg, JPEG, 31459 bytes, '},
      {'input' : 'hidden6.jpg', 'expectedOutput' : 'hidden6.jpg, JPEG, 41805 bytes, '},
      {'input' : 'hidden7.jpg', 'expectedOutput' :
          'hidden7.jpg, JPEG, 23557 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, ZIP, 11729 bytes, \n'
          '        lat.mp3, MP3, 31857 bytes, \n'
          '            <<!!!HIDDEN_FILE!!!>>_2, JPEG, 14942 bytes, \n'
          '            <<!!!HIDDEN_FILE!!!>>_3, JPEG, 2551 bytes, \n'
          '            <<!!!HIDDEN_FILE!!!>>_4, JPEG, 2551 bytes, \n'
          '            <<!!!HIDDEN_FILE!!!>>_5, ZIP, 16893 bytes, \n'
          '                lon.txt, TXT, 63 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_6, JPEG, 1670 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_7, JPEG, 1670 bytes, \n'
          ''},
      {'input' : 'hidden8.jpg', 'expectedOutput' :
          'hidden8.jpg, JPEG, 53827 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, ZIP, 2264 bytes, \n'
          '        Lorem Ipsum.txt, TXT, 4501 bytes, \n'
          ''},
      {'input' : 'hidden9.jpg', 'expectedOutput' :
          'hidden9.jpg, JPEG, 237081 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, ZIP, 178 bytes, \n'
          '        secret.txt, TXT, 10 bytes, \n'
          ''},
      {'input' : 'hidden10.jpg', 'expectedOutput' :
          'hidden10.jpg, JPEG, 239449 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, PNG, 2532 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_2, TXT, 14 bytes, \n'
          ''},
      {'input' : 'hidden11.png', 'expectedOutput' :
          'hidden11.png, PNG, 239599 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, JPEG, 236903 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_2, ZIP, 164 bytes, \n'
          '        secret.txt, TXT, 10 bytes, \n'
          ''},
      {'input' : 'hidden12.png', 'expectedOutput' :
          'hidden12.png, PNG, 726398 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, ZIP, 1130 bytes, \n'
          '        Rtsel.txt, TXT, 5525 bytes, \n'
          ''},
      {'input' : 'hidden13.jpg', 'expectedOutput' :
          'hidden13.jpg, JPEG, 53827 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, ZIP, 2264 bytes, \n'
          '        Lorem Ipsum.txt, TXT, 4501 bytes, \n'
          ''},
      {'input' : 'hidden14.tar.bz2', 'expectedOutput' :
          'hidden14.tar.bz2, BZIP2, 107211 bytes, \n'
          '    hidden14.tar, TAR, 118784 bytes, \n'
          '        homerl.jpg, JPEG, 71128 bytes, \n'
          '        Temp.zip, ZIP, 45060 bytes, \n'
          '            donald.jpg, JPEG, 17708 bytes, \n'
          '            garfield.jpg, JPEG, 27696 bytes, \n'
          ''},
      {'input' : 'hidden15.jpg', 'expectedOutput' :
          'hidden15.jpg, JPEG, 243577 bytes, \n'
          '    <<!!!HIDDEN_FILE!!!>>_1, TXT, 104345 bytes, \n'
          ''},

      {'input' : 'nano.png', 'expectedOutput' : 'hidden1.jpg, JPEG, 1489 bytes, '},
      {'input' : 'QuickResponse.jpg', 'expectedOutput' : 'hidden1.jpg, JPEG, 1489 bytes, '},

      {'input' : 'sample.tar.gz', 'expectedOutput' : 'hidden1.jpg, JPEG, 1489 bytes, '},
      {'input' : 'test1.rar.zip', 'expectedOutput' : 'hidden1.jpg, JPEG, 1489 bytes, '},
      {'input' : 'teufel.png', 'expectedOutput' : 'hidden1.jpg, JPEG, 1489 bytes, '},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await hiddenData(GCWFile(name: elem['input'], bytes:_getFileData(elem['input'])));
        expect(_fileStructureToString(_actual), elem['expectedOutput']);
      });
    });
  });
}