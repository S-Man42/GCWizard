import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readestring.dart';

String deobfuscateEarwigoText(String text) {
  if (text == null || text.isEmpty) return '';

  return gsub_wig(text);
}

String obfuscateEarwigoText(String text) {
  if (text == null || text.isEmpty) return '';

  String result = '';
  String rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~";
  int plen = rot_palette.length;
  for (int i = 0; i < text.length; i++) {
    String c = text[i];
    int p = find(rot_palette, c);
    int jump = (i % 8) + 9;
    if (p != -1) {
      if ((p - 1) < jump) {
        p = p + plen;
      }
      p = p - jump;
      c = rot_palette[p - 1];
    }
    result = result + c;
  }
  ;

  return result;
}
