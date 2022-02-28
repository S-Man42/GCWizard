import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/readestring.dart';

String deobfuscateEarwigoText(String text) {
  if (text == null || text.isEmpty) return '';

  return gsub_wig(text);
}

