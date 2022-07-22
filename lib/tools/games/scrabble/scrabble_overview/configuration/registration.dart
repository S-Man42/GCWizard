import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/games/scrabble/scrabble_overview/widget/scrabble_overview.dart';

class ScrabbleOverviewRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'scrabbleoverview';

  @override
  List<String> searchKeys = [
    'games_scrabble',
  ];

  @override
  Widget tool = ScrabbleOverview();
}