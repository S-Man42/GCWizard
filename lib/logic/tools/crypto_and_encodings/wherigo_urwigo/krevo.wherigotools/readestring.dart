int _find(String palette, String char) {
  for (int i = 0; i < palette.length; i++)
    if (palette[i] == char)
      return (i + 1);
  return -1;
}

String gsub_wig(String str){
  String result = '';
  String rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~";
  int plen = rot_palette.length;
  var magic = { ["\001"] : "B", ["\002"] : "R", ["\003"] : "" };
  String x;

  str = str.replaceAll('nbsp;', ' ').replaceAll('&lt;', '\004').replaceAll('&gt;', '\005').replaceAll('&amp;', '\006');

  for (int i = 0; i < str.length; i++) {
    String c = str[i];
    int p = _find(rot_palette, c);
    if (p != -1) {
      int jump = (i % 8) + 9;
      p = p + jump;
      if (plen < p)
        p = p - plen;
      c = rot_palette[p - 1];
    }
    else {
      x = magic[c];
      if (x != null)
        c = x;
    }
    result = result + c;
  }
  result = result.replaceAll('\004', '&lt;').replaceAll('\005', '&gt;').replaceAll('\006', '&amp;');
  return result;
}

