import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/vanity_multitap.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/vanity_singletap.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/vanity_words_list.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/vanity_words_search.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class VanitySelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(VanitySingletap()),
        className(VanityMultitap()),
        className(VanityWordsList()),
        className(VanityWordsTextSearch()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
