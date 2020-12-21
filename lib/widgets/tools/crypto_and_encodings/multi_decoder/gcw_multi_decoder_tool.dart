import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/enigma.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_dropdownbutton.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

enum MultiDecoderToolState {DECODE, CONFIGURATION}

abstract class GCWMultiDecoderTool {
  final int id;
  String name;
  final String internalToolName;
  final Function onDecode;
  final GCWMultiDecoderToolConfiguration configurationWidget;
  final MultiDecoderToolState state;
  Map<String, dynamic> options = {};

  GCWMultiDecoderTool({
    Key key,
    this.id,
    this.name,
    this.internalToolName,
    this.state,
    this.onDecode,
    this.configurationWidget,
    this.options
  });
}