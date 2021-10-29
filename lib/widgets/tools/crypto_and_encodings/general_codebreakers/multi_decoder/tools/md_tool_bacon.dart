import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bacon.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_BACON = 'multidecoder_tool_bacon_title';
const MDT_BACON_OPTION_MODE = 'multidecoder_tool_bacon_option_mode';

class MultiDecoderToolBacon extends GCWMultiDecoderTool {
  MultiDecoderToolBacon({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_BACON,
            onDecode: (String input, String key) {
              return decodeBacon(input, false, options[MDT_BACON_OPTION_MODE] == '01');
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_BACON_OPTION_MODE: GCWTwoOptionsSwitch(
                value: options[MDT_BACON_OPTION_MODE] == '01' ? GCWSwitchPosition.right : GCWSwitchPosition.left,
                notitle: true,
                leftValue: 'AB',
                rightValue: '01',
                onChanged: (value) {
                  options[MDT_BACON_OPTION_MODE] = value == GCWSwitchPosition.left ? 'AB' : '01';
                },
              )
            }));
}
