import 'package:gc_wizard/utils/alphabets.dart';

List<String>? _createTable(int version, {bool classic = false}) {
  if (![1, 2].contains(version)) { return null; }

  String alphabet = alphabet_AZ.keys.join('');
  if (classic) {alphabet = alphabet.replaceAll(RegExp('[JKUW]'), '');}

  String head = alphabet.substring(0, alphabet.length ~/ 2);
  String initialLine = alphabet.substring(alphabet.length ~/ 2);

  List<String> table = [head, initialLine];
  String line = initialLine;
  for (int i = 0; i < head.length - 1; i++) {
    (version == 1)
        ? line = line[line.length - 1] + line.substring(0, line.length - 1)
        : line = line.substring(1) + line[0];
    table.add(line);
  }
  return table;
}

String togglePorta(String text, String key, { int version = 1, bool classic = false }) {
  List<String>? table = _createTable(version, classic: classic);

  if (text.isEmpty || key.isEmpty || table == null) { return ""; }

  String output = '';
  int rowLength = table[0].length;
  text = text.toUpperCase().replaceAll(RegExp('[^A-Z]'), '');
  key = key.toUpperCase().replaceAll(RegExp('[^A-Z]'), '');

  if (classic) {
    text = text.replaceAll(RegExp('[JKUW]'), '');
    key = key.replaceAll(RegExp('[JKUW]'), '');
  }

  for (var i = 0; i < text.length; i++) {
    var row = ((key[i % key.length].codeUnitAt(0) - 65) ~/ 2) % rowLength + 1;
    (table[row].contains(text[i]))
        ? output += table[0][table[row].indexOf(text[i])]
        : output += table[row][table[0].indexOf(text[i])];
  }
  return output;
}