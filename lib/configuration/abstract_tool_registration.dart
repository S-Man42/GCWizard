import 'package:flutter/material.dart';
import 'reflectors/gcw_tool_reflector.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';

@gcwToolReflector
abstract class AbstractToolRegistration {
  Widget get tool;
  String get i18nPrefix;
  List<ToolCategory> get categories;
  List<String> get searchKeys;
}