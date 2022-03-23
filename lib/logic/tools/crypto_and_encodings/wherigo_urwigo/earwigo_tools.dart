import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readestring.dart';

enum EARWIGO_DEOBFUSCATION {WWB_DEOBF, GSUB_WIG}

String deobfuscateEarwigoText(String text, EARWIGO_DEOBFUSCATION tool) {
  if (text == null || text.isEmpty) return '';

  switch (tool) {
    case EARWIGO_DEOBFUSCATION.GSUB_WIG: return gsub_wig(text);
    case EARWIGO_DEOBFUSCATION.WWB_DEOBF: return wwb_deobf(text);
  }
}

String obfuscateEarwigoText(String text, EARWIGO_DEOBFUSCATION tool) {
  switch (tool) {
    case EARWIGO_DEOBFUSCATION.GSUB_WIG: return gsub_wig_obfuscation(text);
    case EARWIGO_DEOBFUSCATION.WWB_DEOBF: return wwb_deobf_obfuscation(text);
  }
}

String gsub_wig_obfuscation(String text) {
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

String wwb_deobf_obfuscation(String str) {
  if (str == null || str.isEmpty) return '';

  String result = '';
  String rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~";
  int plen = rot_palette.length;

  var magic = {
    ["\x01"]: "B",
    ["\x02"]: "R",
    ["\x03"]: ""
  };
  String x = '';
  int d = 0;

  str = str.replaceAll('\\001', '\x01').replaceAll('\\002', '\x02').replaceAll('\\003', '\x03');
  str = str.replaceAll('<', '\\004').replaceAll('>', '\\005').replaceAll('&', '\\006');

  for (int i = 0; i < str.length; i++) {
    String c = str[i];
    int p = find(rot_palette, c);
    if (p != -1) {
      int jump = (i % 8) + 9;
      p = p + jump;
      if (p > plen) p = p - plen;
      if (p - 1 >= 0)
        c = rot_palette[p - 1];
    } else {
      x = magic[c];
      if (x != null)
        c = x;
    }
    d++;
    if (c.codeUnitAt(0) > 127)
      d++;
    result = result + c;
  }
  result = result.replaceAll('\\004', '<').replaceAll('\\005', '>').replaceAll('\\006', '&');
  return result;
}