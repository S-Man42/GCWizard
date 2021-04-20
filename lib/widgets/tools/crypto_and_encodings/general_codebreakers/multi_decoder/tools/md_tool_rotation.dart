import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ROTATION = 'multidecoder_tool_rotation_title';
const MDT_ROTATION_OPTION_KEY = 'multidecoder_tool_rotation_option_key';

class MultiDecoderToolRotation extends GCWMultiDecoderTool {
  MultiDecoderToolRotation({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ROTATION,
            onDecode: (input) {
              return Rotator().rotate(input, options[MDT_ROTATION_OPTION_KEY]);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ROTATION_OPTION_KEY: GCWABCSpinner(
                value: options[MDT_ROTATION_OPTION_KEY],
                onChanged: (value) {
                  options[MDT_ROTATION_OPTION_KEY] = value;
                },
              )
            }));
}
