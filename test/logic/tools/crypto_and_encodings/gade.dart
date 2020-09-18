import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gade.dart';

void main() {
  group("Gade.buildGade:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : 'a = 0\nb = 1\nc = 2\nd = 3\ne = 4\nf = 5\ng = 6\nh = 7\ni = 8\nj = 9\n'},
      {'input' : 'd', 'expectedOutput' : 'a = 0\nb = 1\nc = 2\nd = 3\ne = 4\nf = 5\ng = 6\nh = 7\ni = 8\nj = 9\n'},
      {'input' : '1', 'expectedOutput' : 'a = 1\nb = 0\nc = 2\nd = 3\ne = 4\nf = 5\ng = 6\nh = 7\ni = 8\nj = 9\n'},
      {'input' : '1945 56 876 18', 'expectedOutput' : 'a = 1\nb = 1\nc = 4\nd = 5\ne = 5\nf = 6\ng = 6\nh = 7\ni = 8\nj = 8\nk = 9\nl = 0\nm = 2\nn = 3\n'},
      {'input' : '12345 56m2 3 678 245 2346 2345 245 324 2 4325 2345 23 24 3 3 32 3', 'expectedOutput' : 'a = 1\nb = 2\nc = 2\nd = 2\ne = 2\nf = 2\ng = 2\nh = 2\ni = 2\nj = 2\nk = 2\nl = 2\nm = 2\nn = 2\no = 3\np = 3\nq = 3\nr = 3\ns = 3\nt = 3\nu = 3\nv = 3\nw = 3\nx = 3\ny = 3\nz = 3\n'},
    ];


    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = buildGade(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}