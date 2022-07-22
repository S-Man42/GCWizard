import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder/widget/multi_decoder.dart';

class MultiDecoderRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GENERAL_CODEBREAKERS = [
    ToolCategory.GENERAL_CODEBREAKERS
  ];

  @override
  String i18nPrefix = 'multidecoder';

  @override
  List<String> searchKeys = [
    'multidecoder',
  ];

  @override
  Widget tool = MultiDecoder();
}