import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

abstract class GCWMultiDecoderTool {
  final int id;
  String name;
  final String internalToolName;
  final Function onDecode;
  final GCWMultiDecoderToolConfiguration configurationWidget;
  Map<String, dynamic> options = {};

  GCWMultiDecoderTool({
    Key key,
    this.id,
    this.name,
    this.internalToolName,
    this.onDecode,
    this.configurationWidget,
    this.options
  });
}