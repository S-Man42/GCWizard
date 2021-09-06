import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/zamonian_numbers.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';

class ZamonianNumbers extends SymbolTable {
  ZamonianNumbers({Key key})
      : super(
    key: key,
    symbolKey: 'zamonian',
    onDecrypt: (input) => decodeZamonian(input),
    onEncrypt: (input) => encodeZamonian(input),
    alwaysIgnoreUnknown: true
  );
}