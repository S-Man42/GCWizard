import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/reflector.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';

abstract class AbstractToolRegistration {
  Widget get tool;
  String get i18nPrefix;
  List<ToolCategory> get categories;
  List<String> get searchKeys;
}