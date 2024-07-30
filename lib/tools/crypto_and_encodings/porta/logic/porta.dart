
List<String>? _createTable(int version) {
  if (![1, 2].contains(version)) {
    return null;
  }

  String head = "ABCDEFGHIJKLM";
  String initialLine = "NOPQRSTUVWXYZ";
  List<String> table = [head, initialLine];
  String line = initialLine;
  for (int i = 0; i < 12; i++) {
    (version == 1)
        ? line = line[line.length - 1] + line.substring(0, line.length - 1)
        : line = line.substring(1) + line[0];
    table.add(line);
  }
  return table;
}

String togglePorta(String text, String key, { int version = 1 }) {
  var table = _createTable(version);

  if (text.isEmpty || key.isEmpty || table == null) { return ""; }

  String output = '';
  text = text.toUpperCase().replaceAll(RegExp('[^A-Z]'), '');
  key = key.toUpperCase().replaceAll(RegExp('[^A-Z]'), '');

  for (var i = 0; i < text.length; i++) {
    var row = ((key[i % key.length].codeUnitAt(0) - 65) ~/ 2) % 13 + 1;

    (table[row].contains(text[i]))
        ? output += table[0][table[row].indexOf(text[i])]
        : output += table[row][table[0].indexOf(text[i])];
  }
  return output;
}