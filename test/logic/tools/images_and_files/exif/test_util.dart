import 'dart:io';
import 'dart:io' as io;

import 'package:path/path.dart' as Path;

var testDirPath = 'test/resources/exif/';

List<FileSystemEntity> readSamples() {
  Directory dir = new io.Directory(testDirPath);
  Set<String> allowedExtensions = {'.jpg', '.tiff'};
  var files = dir.listSync(recursive: true).where((file) => (allowedExtensions.contains(Path.extension(file.path))));
  return files;
}

List<FileSample> readSampleTest1() {
  String _path = Path.join(testDirPath, 'test1.jpg');
  File _file = File(_path);
  return [FileSample(_file, 37.885, -122.6225)];
}

List<FileSample> readSampleTest2() {
  String _path = Path.join(testDirPath, 'test2.jpg');
  File _file = File(_path);
  return [FileSample(_file, 0, 0)];
}

class FileSample {
  File file;
  double expectedLatitude;
  double expectedLongitude;

  FileSample(this.file, this.expectedLatitude, this.expectedLongitude);
}
