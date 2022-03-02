import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/wherigo_urwigo/earwigo_text_deobfuscation.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/wherigo_urwigo/urwigo_hashbreaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/wherigo_urwigo/urwigo_text_deobfuscation.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/wherigo_urwigo/wherigo_analyze.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class WherigoSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(UrwigoHashBreaker()),
        className(UrwigoTextDeobfuscation()),
        className(EarwigoTextDeobfuscation()),
        className(WherigoAnalyze()), ]
          .contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
