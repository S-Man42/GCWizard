import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bacon.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_BACON = 'bacon';
const MDT_BACON_OPTION_MODE = 'mode';

class MultiDecoderToolBacon extends GCWMultiDecoderTool {

  MultiDecoderToolBacon({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_BACON,
      onDecode: (input) {
        return decodeBacon(input, false, options[MDT_BACON_OPTION_MODE] == '01');
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_BACON_OPTION_MODE: GCWTwoOptionsSwitch(
            value: options[MDT_BACON_OPTION_MODE] == 'ab' ? GCWSwitchPosition.left : GCWSwitchPosition.right,
            leftValue: 'AB',
            rightValue: '01',
            onChanged: (value) {
              options[MDT_BACON_OPTION_MODE] = value == GCWSwitchPosition.left ? 'ab' : '01';
            },
          )
        }
      )
    );
}