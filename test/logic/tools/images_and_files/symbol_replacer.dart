import "package:flutter_test/flutter_test.dart";
import 'dart:ui' as ui;
import 'package:image/image.dart' as Image;

import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:path/path.dart' as path;
import 'package:gc_wizard/logic/tools/images_and_files/symbol_replacer.dart';

main() async {
  var imageHashing =ImageHashing();
  print(path.join('D:', 'bmp0.bmp'));
  var image1 = await readImage(path.join('D:', 'bmp0.bmp'));
  var image2 = await readImage(path.join('D:', 'bmp1.bmp'));
  var hash1 = imageHashing.AverageHash(image1);
  var hash2 = imageHashing.AverageHash(image2);
  print(hash1 );
  print(hash2);
  print(imageHashing.Similarity(hash1, hash2));

}

//0: 7854277754429112078
//1: -1737396032347322401
//similarity: 100

//0: 7854277754429112078
//1: 16709348041362229215
//similarity: 50

//0: 7854277754429112078
//1: 1737396032347322400
//similarity: 50

Future<Image.Image> readImage(String _path) async {
  var bytes = await readByteDataFromFile(_path);

  return Image.decodeImage(bytes);
}