import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/games/catan/widget/catan.dart';

class CatanRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GAMES = [
    ToolCategory.GAMES
  ];

  @override
  String i18nPrefix = 'catan';

  @override
  List<String> searchKeys = [
    'catan',
  ];

  @override
  Widget tool = Catan();
}