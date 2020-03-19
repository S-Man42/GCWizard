import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base16.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base32.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base64.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base85.dart';
import 'package:gc_wizard/widgets/tools/encodings/brainfk/brainfk.dart';
import 'package:gc_wizard/widgets/tools/encodings/brainfk/ook.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class BrainfkSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWToolWidget> _toolList =
      Registry.toolList.where((element) {
        return [
          className(Brainfk()),
          className(Ook()),
        ].contains(className(element.tool));
      }).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}