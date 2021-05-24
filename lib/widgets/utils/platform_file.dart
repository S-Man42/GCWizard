import 'dart:typed_data';

class PlatformFile {
  const PlatformFile({this.path, this.name, this.bytes});

  /// The absolute path for a cached copy of this file. It can be used to create a
  /// file instance with a descriptor for the given path.
  /// ```
  /// final File myFile = File(platformFile.path);
  /// ```
  final String path;

  /// File name including its extension.
  final String name;

  /// Byte data for this file. Particurlarly useful if you want to manipulate its data
  /// or easily upload to somewhere else.
  final Uint8List bytes;

  /// File extension for this file.
  String get extension => name?.split('.').last;
}
