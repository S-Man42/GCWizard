import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/configuration/reflector.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/abaddon.dart';

@reflector
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