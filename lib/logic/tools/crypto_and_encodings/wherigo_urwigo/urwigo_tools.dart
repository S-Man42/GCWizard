import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readestring.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readustring.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/ucommons.dart';

String breakUrwigoHash(int input) {
  if (input == null) return '';
  if (input < 0 || input >= 65535) return '';

  for (int i = 1; i <= 5; i++) {
    var out = findHash(input, i);
    if (out != null && out.isNotEmpty) return out;
  }

  return null;
}

String deobfuscateUrwigoText(String text, String dtable) {
  if (text == null || text.isEmpty) return '';

  if (dtable == null || dtable.isEmpty) return '';

  if (dtable == 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~')
    return gsub_wig(text);
  else
    return readustring(text, dtable) ?? '';
}

String obfuscateUrwigoText(String text, String dtable) {
  if (text == null || text.isEmpty) return '';

  if (dtable == null || dtable.isEmpty) return '';

  var searchReplace = {
    8 : "\\b",      // x08   backspace
    11 : "\\v",     // x0B   vertical tab
    7 : "\\a",      // x07   alarm beep
    9 : "\\t",      // \t    tab
    13 : "\\r",     // \r    carriage return
    10 : "\\n",     // \n    line feed
    12 : "\\f",     // \f    form feed
    92 : "\\\\",    // \\    backslash
//    "\"" : "\\\"",  // \
  };

  String result = '';

  List<int> dtableCodeUnits = luaStringToString(dtable).codeUnits;

  int codeUnit = 0;
  text.split('').forEach((char) {
    if (char.codeUnitAt(0) < dtableCodeUnits.length) {
      codeUnit = 1 + dtableCodeUnits.indexOf(char.codeUnitAt(0));
    } else {
      codeUnit = 1 + char.codeUnitAt(0);
    }
    if (searchReplace[codeUnit] == null)
      if (32 <= codeUnit && codeUnit <= 127)
        result = result + String.fromCharCode(codeUnit);
      else
        result = result + '\\' + codeUnit.toString().padLeft(3, '0');

    else
      result = result + searchReplace[codeUnit];
  });

  return result;
}