import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ROTATION = 'rotation';
const MDT_ROTATION_OPTION_KEY = 'key';

class MultiDecoderToolRotation extends GCWMultiDecoderTool {

  MultiDecoderToolRotation({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_ROTATION,
      onDecode: (input) {
        return Rotator().rotate(input, options[MDT_ROTATION_OPTION_KEY]);
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_ROTATION_OPTION_KEY: GCWABCSpinner(
            value: options[MDT_ROTATION_OPTION_KEY],
            onChanged: (value) {
              options[MDT_ROTATION_OPTION_KEY] = value;
            },
          )
        }
      )
    );
}