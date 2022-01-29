import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readestring.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readustring.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/ucommons.dart';

String breakUrwigoHash(int input) {
  if (input == null) return '';

  for (int i = 4; i <= 7; i++) {
    var out = findHash(input, len: i);
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
