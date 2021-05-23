import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data_specialsorts.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

final SYMBOLTABLES_ASSETPATH = 'assets/symbol_tables/';

class _SymbolTableConstants {
  final IMAGE_SUFFIXES = RegExp(r'\.(png|jpg|bmp|gif)', caseSensitive: false);
  final ARCHIVE_SUFFIX = RegExp(r'\.(zip)', caseSensitive: false);

  final CONFIG_FILENAME = 'config.file';
  final CONFIG_SPECIALMAPPINGS = 'special_mappings';
  final CONFIG_TRANSLATE = 'translate';
  final CONFIG_CASESENSITIVE = 'case_sensitive';
  final CONFIG_SPECIALSORT = 'special_sort';
  final CONFIG_IGNORE = 'ignore';

  final Map<String, String> CONFIG_SPECIAL_CHARS = {
    "space": " ",
    "asterisk": "*",
    "dash": "-",
    "colon": ":",
    "semicolon": ";",
    "dot": ".",
    "slash": "/",
    "apostrophe": "'",
    "apostrophe_in": "'",
    "apostrophe_out": "'",
    "parentheses_open": "(",
    "parentheses_close": ")",
    "guillemet_in": "«",
    "guillemet_out": "»",
    "quotation": "\"",
    "quotation_in": "\"",
    "quotation_out": "\"",
    "dollar": "\$",
    "percent": "%",
    "plus": "+",
    "question": "?",
    "exclamation": "!",
    "backslash": "\\",
    "copyright": "©",
    "comma": ",",
    "pound": "£",
    "equals": "=",
    "brace_open": "{",
    "brace_close": "}",
    "bracket_open": "[",
    "bracket_close": "]",
    "ampersand": "&",
    "hashtag": "#",
    "web_at": "@",
    "paragraph": "§",
    "caret": "^",
    "underscore": "_",
    "backtick": "`",
    "pipe": "|",
    "tilde": "~",
    "lessthan": "<",
    "greaterthan": ">",
    "euro": "€",
    "times": "×",
    "division": "÷",
    "inverted_question": "¿",
    "degree": "°",
    "AE_umlaut": "Ä",
    "OE_umlaut": "Ö",
    "UE_umlaut": "Ü",
    "SZ_umlaut": "ß",
    "A_acute": "Á",
    "A_grave": "À",
    "A_circumflex": "Â",
    "AE_together": "Æ",
    "C_cedille": "Ç",
    "C_acute": "Ć",
    "E_acute": "É",
    "E_grave": "È",
    "E_circumflex": "Ê",
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
    "OE_together": "Œ",
    "R_acute": "Ŕ",
    "S_acute": "Ś",
    "U_acute": "Ú",
    "U_grave": "Ù",
    "U_circumflex": "Û",
    "Z_acute": "Ź",
    "ae_umlaut": "ä",
    "ae_together": "æ",
    "oe_together": "œ",
    "oe_umlaut": "ö",
    "ue_umlaut": "ü",
    "n_tilde": "ñ",
  };
}

class SymbolData {
  final String path;
  final List<int> bytes;

  SymbolData({this.path = null, this.bytes = null});
}

class SymbolTableData {
  final BuildContext _context;
  final String _symbolKey;
  final _SymbolTableConstants _constants = _SymbolTableConstants();

  SymbolTableData(this._context, this._symbolKey);

  Map<String, dynamic> config;
  List<Map<String, SymbolData>> images;
  int maxSymbolTextLength = 0;

  var _translateables = [];
  var _sort;

  initialize() async {
    await _loadConfig();
    await _initalizeImages();
  }

  bool isCaseSensitive() {
    return config[_constants.CONFIG_CASESENSITIVE] != null && config[_constants.CONFIG_CASESENSITIVE] == true;
  }

  String _pathKey() {
    return SYMBOLTABLES_ASSETPATH + _symbolKey + '/';
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
      _sort = _defaultSort;
    } else {
      switch (_symbolKey) {
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
          _sort = _defaultSort;
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
      key = i18n(_context, 'symboltables_' + _symbolKey + '_' + imageKey);
      setTranslateable = true;
    } else {
      key = imageKey;
    }

    if (!isCaseSensitive()) key = key.toUpperCase();

    if (setTranslateable) _translateables.add(key);

    if (key.length > maxSymbolTextLength) maxSymbolTextLength = key.length;

    return key;
  }

  _initalizeImages() async {
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

          return {key: new SymbolData(path: value, bytes: data)};
        })
        .where((element) => !config[_constants.CONFIG_IGNORE].contains(element.keys.first.toLowerCase()))
        .where((element) => element.values.first.path != null)
        .toList();

    images.sort(_sort);
  }

  int _defaultSort(Map<String, SymbolData> a, Map<String, SymbolData> b) {
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
