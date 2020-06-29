import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astonomy/moon_position.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astonomy/moon_rise_set.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astonomy/sun_position.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astonomy/sun_rise_set.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class AstronomySelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWToolWidget> _toolList =
      Registry.toolList.where((element) {
        return [
          className(SunRiseSet()),
          className(SunPosition()),
          className(MoonRiseSet()),
          className(MoonPosition()),
        ].contains(className(element.tool));
      }).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}