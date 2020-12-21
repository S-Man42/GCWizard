import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MULTIDECODERTOOL_INTERNALNAMES_ROTATION = 'rotation';

class MultiDecoderToolRotation extends GCWMultiDecoderTool {

  MultiDecoderToolRotation({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MULTIDECODERTOOL_INTERNALNAMES_ROTATION,
      onDecode: (input) {
        return Rotator().rotate(input, options['key']);
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          'key': GCWABCSpinner(
            value: options['key'],
            onChanged: (value) {
              options['key'] = value;
            },
          )
        }
      )
    );
}