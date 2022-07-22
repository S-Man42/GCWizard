import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/general_tools/grid_generator/grid/widget/grid.dart';

class GridRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GAMES = [
    ToolCategory.GAMES
  ];

  @override
  String i18nPrefix = 'grid';

  @override
  List<String> searchKeys = [
    'grid',
  ];

  @override
  Widget tool = Grid();
}