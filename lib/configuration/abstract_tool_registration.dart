import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/reflectors/gcw_tool_reflector.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';

const gcwToolReflector = const GCWToolReflector();

@gcwToolReflector
abstract class AbstractToolRegistration {
  Widget get tool;
  String get i18nPrefix;
  List<ToolCategory> get categories;
  List<String> get searchKeys;
}