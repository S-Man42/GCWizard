import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data_specialsorts.dart';

final SYMBOLTABLES_ASSETPATH = 'assets/symbol_tables/';

class _SymbolTableConstants {
  final IMAGE_SUFFIXES = RegExp(r'\.(png|jpg|bmp|gif)', caseSensitive: false);
  final ARCHIVE_SUFFIX = RegExp(r'\.(zip)', caseSensitive: false);

  final CONFIG_FILENAME = 'config.file';
  final CONFIG_SPECIALMAPPINGS = 'special_mappings';
  final CONFIG_TRANSLATE = 'translate';
  final CONFIG_TRANSLATION_PREFIX = 'translation_prefix';
  final CONFIG_CASESENSITIVE = 'case_sensitive';
  final CONFIG_SPECIALSORT = 'special_sort';
  final CONFIG_IGNORE = 'ignore';

  final Map<String, String> CONFIG_SPECIAL_CHARS = {
    "ampersand": "&",
    "asterisk": "*",
    "apostrophe": "'",
    "apostrophe_in": "'",
    "apostrophe_out": "'",
    "backslash": "\\",
    "backtick": "`",
    "brace_close": "}",
    "brace_open": "{",
    "bracket_close": "]",
    "bracket_open": "[",
    "bullet": "•",
    "caret": "^",
    "cedille": "¸",
    "cent": "¢",
    "colon": ":",
    "comma": ",",
    "copyright": "©",
    "cross": "†",
    "dash": "-",
    "degree": "°",
    "division": "÷",
    "dollar": "\$",
    "dot": ".",
    "doublecross": "‡",
    "ellipse": "…",
    "equals": "=",
    "euro": "€",
    "exclamation": "!",
    "function": "ƒ",
    "greaterthan": ">",
    "guillemet_in": "«",
    "guillemet_out": "»",
    "hard_space": " ",
    "hashtag": "#",
    "high_1": "¹",
    "high_2": "²",
    "high_3": "³",
    "high_a": "ª",
    "hyphen": "-",
    "inverted_exclamation": "¡",
    "inverted_question": "¿",
    "lessthan": "<",
    "middle_dot": "·",
    "minus": "-",
    "my": "µ",
    "number": "N°",
    "not": "¬",
    "one_fourth": "¼",
    "one_half": "½",
    "open_pipe": "¦",
    "paragraph": "§",
    "parentheses_open": "(",
    "parentheses_close": ")",
    "parentheses": "()",
    "percent": "%",
    "pi": "π",
    "pipe": "|",
    "plus": "+",
    "plus_minus": "±",
    "pound": "£",
    "promille": "‰",
    "quotation": "\"",
    "quotation_in": "“",
    "quotation_out": "”",
    "question": "?",
    "register": "®",
    "semicolon": ";",
    "slash": "/",
    "space": " ",
    "tilde": "~",
    "times": "×",
    "three_fourth": "¾",
    "trademark": "™",
    "trema": "¨",
    "underscore": "_",
    "web_at": "@",
    "yen": "¥",
    "A_acute": "Á",
    "A_grave": "À",
    "A_circumflex": "Â",
    "A_ring": "Å",
    "A_tilde": "Ã",
    "AE_together": "Æ",
    "AE_umlaut": "Ä",
    "C_acute": "Ć",
    "C_cedille": "Ç",
    "E_acute": "É",
    "E_circumflex": "Ê",
    "E_grave": "È",
    "E_eth": "Ð",
    "E_trema": "Ë",
    "I_acute": "Í",
    "I_grave": "Ì",
    "I_circumflex": "Î",
    "I_trema": "Ï",
    "N_acute": "Ń",
    "N_tilde": "Ñ",
    "O_acute": "Ó",
    "O_grave": "Ò",
    "O_circumflex": "Ô",
    "O_slash": "Ø",
    "O_tilde": "Õ",
    "OE_together": "Œ",
    "OE_umlaut": "Ö",
    "R_acute": "Ŕ",
    "S_acute": "Ś",
    "S_caron": "Š",
    "SZ_umlaut": "ß",
    "T_thorn": "Þ",
    "U_acute": "Ú",
    "U_circumflex": "Û",
    "U_grave": "Ù",
    "UE_umlaut": "Ü",
    "Y_acute": "Ý",
    "Y_trema": "Ÿ",
    "Z_acute": "Ź",
    "Z_caron": "Ž",
    "a_acute": "á",
    "a_circumflex": "â",
    "a_grave": "à",
    "a_ring": "å",
    "a_tilde": "ã",
    "ae_umlaut": "ä",
    "ae_together": "æ",
    "c_cedille": "ç",
    "e_acute": "é",
    "e_circumflex": "ê",
    "e_grave": "è",
    "e_eth": "ð",
    "e_trema": "ë",
    "i_acute": "í",
    "i_circumflex": "î",
    "i_grave": "ì",
    "i_trema": "ï",
    "n_tilde": "ñ",
    "o_acute": "ó",
    "o_circumflex": "o",
    "o_grave": "ò",
    "o_slash": "ø",
    "o_tilde": "õ",
    "oe_together": "œ",
    "oe_umlaut": "ö",
    "t_thorn": "þ",
    "s_caron": "š",
    "u_acute": "ú",
    "u_circumflex": "û",
    "u_grave": "ù",
    "ue_umlaut": "ü",
    "y_acute": "ý",
    "y_trema": "ÿ",
    "z_caron": "ž",
  };
}

class SymbolData {
  final String path;
  final List<int> bytes;
  bool primarySelected = false;
  bool secondarySelected = false;
  final String displayName;

  SymbolData({this.path, this.bytes, this.displayName});
}

class SymbolTableData {
  final BuildContext _context;
  final String symbolKey;
  final _SymbolTableConstants _constants = _SymbolTableConstants();

  SymbolTableData(this._context, this.symbolKey);

  Map<String, dynamic> config;
  List<Map<String, SymbolData>> images;
  int maxSymbolTextLength = 0;

  var _translateables = [];
  var _sort;

  initialize() async {
    await _loadConfig();
    await _initializeImages();
  }

  bool isCaseSensitive() {
    return config[_constants.CONFIG_CASESENSITIVE] != null && config[_constants.CONFIG_CASESENSITIVE] == true;
  }

  String _pathKey() {
    return SYMBOLTABLES_ASSETPATH + symbolKey + '/';
  }

  _loadConfig() async {
    var file;
    try {
      file = await DefaultAssetBundle.of(_context).loadString(_pathKey() + _constants.CONFIG_FILENAME);
    } catch (e) {}

    if (file == null) file = '{}';

    config = json.decode(file);

    if (config[_constants.CONFIG_IGNORE] == null) config.putIfAbsent(_constants.CONFIG_IGNORE, () => <String>[]);

    if (config[_constants.CONFIG_SPECIALMAPPINGS] == null)
      config.putIfAbsent(_constants.CONFIG_SPECIALMAPPINGS, () => Map<String, String>());

    _constants.CONFIG_SPECIAL_CHARS.entries.forEach((element) {
      config[_constants.CONFIG_SPECIALMAPPINGS].putIfAbsent(element.key, () => element.value);
    });

    if (config[_constants.CONFIG_SPECIALSORT] == null || config[_constants.CONFIG_SPECIALSORT] == false) {
      _sort = defaultSymbolSort;
    } else {
      switch (symbolKey) {
        case "notes_names_altoclef":
          _sort = specialSortNoteNames;
          break;
        case "notes_names_bassclef":
          _sort = specialSortNoteNames;
          break;
        case "notes_names_trebleclef":
          _sort = specialSortNoteNames;
          break;
        case "notes_notevalues":
          _sort = specialSortNoteValues;
          break;
        case "notes_restvalues":
          _sort = specialSortNoteValues;
          break;
        case "trafficsigns_germany":
          _sort = specialSortTrafficSignsGermany;
          break;
        default:
          _sort = defaultSymbolSort;
          break;
      }
    }
  }

  String _createKey(String filename) {
    var imageKey = filenameWithoutSuffix(filename);
    imageKey = imageKey.replaceAll(RegExp(r'(^_*|_*$)'), '');

    var setTranslateable = false;

    String key;

    if (config[_constants.CONFIG_SPECIALMAPPINGS].containsKey(imageKey)) {
      key = config[_constants.CONFIG_SPECIALMAPPINGS][imageKey];
    } else if (config[_constants.CONFIG_TRANSLATE] != null && config[_constants.CONFIG_TRANSLATE].contains(imageKey)) {
      var translationPrefix = config[_constants.CONFIG_TRANSLATION_PREFIX];
      if (translationPrefix != null && translationPrefix.length > 0) {
        key = i18n(_context, translationPrefix + imageKey);
      } else {
        key = i18n(_context, 'symboltables_' + symbolKey + '_' + imageKey);
      }
      setTranslateable = true;
    } else {
      key = imageKey;
    }

    if (!isCaseSensitive()) key = key.toUpperCase();

    if (setTranslateable) _translateables.add(key);

    if (key.length > maxSymbolTextLength) maxSymbolTextLength = key.length;

    return key;
  }

  _initializeImages() async {
    //AssetManifest.json holds the information about all asset files
    final manifestContent = await DefaultAssetBundle.of(_context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains(_pathKey()))
        .where((String key) => _constants.ARCHIVE_SUFFIX.hasMatch(key))
        .toList();

    if (imagePaths.isEmpty) return;

    // Read the Zip file from disk.
    final bytes = await DefaultAssetBundle.of(_context).load(imagePaths.first);
    InputStream input = new InputStream(bytes.buffer.asByteData());
    // Decode the Zip file
    final archive = ZipDecoder().decodeBuffer(input);

    images = archive
        .map((file) {
          var key = _createKey(file.name);
          var imagePath = (file.isFile && _constants.IMAGE_SUFFIXES.hasMatch(file.name)) ? file.name : null;
          var value = imagePath;
          var data = file.content;

          return {key: SymbolData(path: value, bytes: data)};
        })
        .where((element) => !config[_constants.CONFIG_IGNORE].contains(element.keys.first.toLowerCase()))
        .where((element) => element.values.first.path != null)
        .toList();

    images.sort(_sort);
  }

  int defaultSymbolSort(Map<String, SymbolData> a, Map<String, SymbolData> b) {
    var keyA = a.keys.first;
    var keyB = b.keys.first;

    var intA = int.tryParse(keyA);
    var intB = int.tryParse(keyB);

    if (intA == null) {
      if (intB == null) {
        if (_translateables.contains(keyA)) {
          if (_translateables.contains(keyB)) {
            return keyA.compareTo(keyB);
          } else {
            return 1;
          }
        } else {
          if (_translateables.contains(keyB)) {
            return -1;
          } else {
            return keyA.compareTo(keyB);
          }
        }
      } else {
        return 1;
      }
    } else {
      if (intB == null) {
        return -1;
      } else {
        return intA.compareTo(intB);
      }
    }
  }
}

String filenameWithoutSuffix(String filename) {
  return filename.split('.').first;
}
