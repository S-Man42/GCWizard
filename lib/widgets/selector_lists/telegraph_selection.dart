import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/schilling_cannstatt_telegraph.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/edelcrantz.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/murray.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/prussiatelegraph.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/wheatstone_cooke_5_needles.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class TelegraphSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(EdelcrantzTelegraph()),
        className(MurrayTelegraph()),
        className(PrussiaTelegraph()),
        className(GaussWeberTelegraph()),
        className(SchillingCannstattTelegraph()),
        className(WheatstoneCooke5NeedleTelegraph()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
