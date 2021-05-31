import 'package:exif/exif.dart';
import "package:flutter_test/flutter_test.dart";

import 'test_util.dart';

main() async {
  // for (FileSample sample in readSampleTest2()) {
  //   test(sample.file.path, () async {
  //     await runSamplesTest(sample.file);
  //   });
  // }

  test('test-mark', () async {
    var fileSamples = readSampleTest2();
    var file = fileSamples[0].file;
    var tags = await readExifFromFile(file);
    expect(tags.length, isNonZero);
  });
}
