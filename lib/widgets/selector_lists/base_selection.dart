import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base16.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base32.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base64.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base85.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class BaseSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(Base16()),
        className(Base32()),
        className(Base64()),
        className(Base85()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
