import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';

abstract class GCWMultiDecoderTool {
  final int id;
  String name;
  final String internalToolName;
  final Function onDecode;
  final GCWMultiDecoderToolConfiguration configurationWidget;
  final bool requiresKey;
  final bool optionalKey;
  Map<String, dynamic> options = {};

  GCWMultiDecoderTool(
      {Key key,
      this.id,
      this.name,
      this.internalToolName,
      this.onDecode,
      this.requiresKey: false,
      this.optionalKey: false,
      this.configurationWidget,
      this.options});
}
