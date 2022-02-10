import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_default.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_paint_data.dart';

Canvas paintSymbolTableEncryptionPuzzle(SymbolTablePaintData paintData) {
  paintData.borderWidth = 0.0;
  return paintSymbolTableEncryptionDefault(paintData);
}