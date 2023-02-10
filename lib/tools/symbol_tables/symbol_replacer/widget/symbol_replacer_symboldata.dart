import 'dart:typed_data';

import 'package:flutter/src/widgets/framework.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/logic/symbol_table_data.dart';

class SymbolReplacerSymbolTableViewData {
  final String symbolKey;
  final icon;
  final toolName;
  final description;
  _SymbolReplacerSymbolTableData? data;

  SymbolReplacerSymbolTableViewData({
    required this.symbolKey,
    required this.icon,
    required this.toolName,
    required this.description,
    this.data});

  Future<_SymbolReplacerSymbolTableData?> initialize(BuildContext context) async {
    var originalData = SymbolTableData(context, symbolKey);
    await originalData.initialize(importEncryption: false);

    data = _SymbolReplacerSymbolTableData(originalData);
    return Future.value(data);
  }
}

class _SymbolReplacerSymbolTableData {
  String? symbolKey;
  late List<Map<String, SymbolReplacerSymbolData>> images;

  _SymbolReplacerSymbolTableData(SymbolTableData data) {
    this.images = data.images.map((Map<String, SymbolData> elem) {
      Map<String, SymbolReplacerSymbolData> _tempMap = {};
      elem.forEach((String key, SymbolData value) {
        _tempMap.putIfAbsent(key, () => SymbolReplacerSymbolData(value));
      });

      return _tempMap;
    }).toList();
  }
}

class SymbolReplacerSymbolData {
  Uint8List? bytes;
  String? displayName;

  SymbolReplacerSymbolData(SymbolData data) {
    this.bytes = data.bytes;
    this.displayName = data.displayName;
  }
}
