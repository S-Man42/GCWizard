import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import '../widget/abaddon.dart';

class AbaddonRegistration implements AbstractToolRegistration {
  @override
  List<ToolCategory> categories = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'abaddon';

  @override
  List<String> searchKeys = [
    'abaddon',
  ];

  @override
  Widget tool = Abaddon();
}