/**
 * Port from https://github.com/Krevo/WherigoTools/blob/master/readustring.php
 *
 * MIT License
 */


String _udecrypt(String str, String dtable) {
  var res = '';
  for (var i = 0; i < str.length; i++) {
    var b = str.codeUnits[i];
    if (b > 0 && b <= 127) {
      if ((b - 1) >= dtable.length) continue;
      res += dtable[b - 1];
    } else {
      res += str[i];
    }
  }
  
  return res;
}

String _luaStringToString(String luaStr) {
  var res = RegExp("\\\\[0-9]{3}").allMatches(luaStr);

  var searchReplace = {
    "\\b" : "\x08",
    "\\v" : "\x0B",
    "\\a" : "\x07",
    "\\t" : "\t",
    "\\r" : "\r",
    "\\n" : "\n",
    "\\f" : "\f",
    "\\\\" : "\\",
    "\\\"" : "\"",
  };

  for (var match in res) {
    var matched = match.group(0);
    var code = matched.substring(1);
    searchReplace.putIfAbsent(matched, () => String.fromCharCode(int.tryParse(code)));
  }
  
  var out = luaStr;
  searchReplace.entries.forEach((element) {
    out = out.replaceAll(element.key, element.value);
  });
  
  return out;
}

String readustring(String input, String dtable) {
  return _udecrypt(_luaStringToString(input), _luaStringToString(dtable));
}