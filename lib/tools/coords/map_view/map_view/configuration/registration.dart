import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/map_view/map_view/widget/map_view.dart';

class MapViewRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_openmap';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_mapview',
  ];

  @override
  Widget tool = MapView();
}