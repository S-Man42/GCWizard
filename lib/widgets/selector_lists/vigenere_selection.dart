import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class VigenereSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWTool> _toolList =
      Registry.toolList.where((element) {
        return [
          className(Vigenere()),
          className(VigenereBreaker()),
          className(Trithemius()),
          className(Gronsfeld()),
        ].contains(className(element.tool));
      }).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}