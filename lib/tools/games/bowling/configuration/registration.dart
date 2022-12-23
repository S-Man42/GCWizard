import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/games/bowling/widget/bowling.dart';

class BowlingRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GAMES = [
    ToolCategory.GAMES
  ];

  @override
  String i18nPrefix = 'bowling';

  @override
  List<String> searchKeys = [
    'bowling',
  ];

  @override
  Widget tool = Bowling();
}