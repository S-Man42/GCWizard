import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/games/game_of_life/game_of_life/widget/game_of_life.dart';

class GameOfLifeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GAMES = [
    ToolCategory.GAMES
  ];

  @override
  String i18nPrefix = 'gameoflife';

  @override
  List<String> searchKeys = [
    'gameoflife',
  ];

  @override
  Widget tool = GameOfLife();
}