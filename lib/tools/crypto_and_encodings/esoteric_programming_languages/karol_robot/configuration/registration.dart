import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/karol_robot/widget/karol_robot.dart';

class KarolRobotRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'karol_robot';

  @override
  List<String> searchKeys = [
    'esoteric_karol_robot',
  ];

  @override
  Widget tool = KarolRobot();
}