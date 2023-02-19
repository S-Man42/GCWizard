part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

void deObfuscateAllTexts() {
  LUAFile = LUAFile.replaceAll('([[', '(').replaceAll(']])', ')');
  RegExp(r'' + obfuscatorFunction + '\\(".*?"\\)').allMatches(LUAFile).forEach((obfuscatedText) {
    var group = obfuscatedText.group(0);
    if (group == null) return;

    LUAFile = LUAFile.replaceAll(group, '"' + deObfuscateText(group, obfuscatorFunction, obfuscatorTable) + '"');
  });

  RegExp(r'' + obfuscatorFunction + '\\((.|\\s)*?\\)').allMatches(LUAFile).forEach((obfuscatedText) {
    var group = obfuscatedText.group(0);
    if (group == null) return;

    LUAFile = LUAFile.replaceAll(
        group,
        '"' +
            deObfuscateText(group.replaceAll(obfuscatorFunction + '(', '').replaceAll(')', ''), obfuscatorFunction,
                obfuscatorTable) +
            '"');
  });
}

void checkAndGetObfuscatorURWIGO(List<String> lines) {
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();

    if (RegExp(r'(local dtable = ")').hasMatch(lines[i])) {
      obfuscatorFunction = lines[i - 2].trim().substring(9);
      for (int j = obfuscatorFunction.length - 1; j > 0; j--) {
        if (obfuscatorFunction[j] == '(') {
          obfuscatorFunction = obfuscatorFunction.substring(0, j);
          j = 0;
        }
      }
      obfuscatorFound = true;

      obfuscatorTable = lines[i].trim().substring(0, lines[i].length - 1);
      obfuscatorTable = obfuscatorTable.trimLeft().replaceAll('local dtable = "', '');

      i = lines.length;
    }
  }
}

void checkAndGetObfuscatorWWBorGSUB() {
  if (RegExp(r'(WWB_deobf)').hasMatch(LUAFile)) {
    obfuscatorFunction = 'WWB_deobf';
    obfuscatorTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~';
    obfuscatorFound = true;
    RegExp(r'WWB_deobf\(".*?"\)').allMatches(LUAFile).forEach((obfuscatedText) {
      var group = obfuscatedText.group(0);
      if (group == null) return;

      LUAFile = LUAFile.replaceAll(group, '"' + deObfuscateText(group, obfuscatorFunction, obfuscatorTable) + '"');
    });
  } else if (RegExp(r'(gsub_wig)').hasMatch(LUAFile)) {
    obfuscatorFunction = 'gsub_wig';
    obfuscatorTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~';
    obfuscatorFound = true;
    RegExp(r'gsub_wig\(".*?"\)').allMatches(LUAFile).forEach((obfuscatedText) {
      var group = obfuscatedText.group(0);
      if (group == null) return;

      LUAFile = LUAFile.replaceAll(group, '"' + deObfuscateText(group, obfuscatorFunction, obfuscatorTable) + '"');
    });
  }
}

