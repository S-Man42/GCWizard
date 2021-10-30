import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bacon.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_BACON = 'multidecoder_tool_bacon_title';
const MDT_BACON_OPTION_MODE = 'multidecoder_tool_bacon_option_mode';
const MDT_BACON_OPTION_MODE_01 = '01';
const MDT_BACON_OPTION_MODE_AB = 'AB';

class MultiDecoderToolBacon extends GCWMultiDecoderTool {
  MultiDecoderToolBacon({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_BACON,
            onDecode: (input) {
              return decodeBacon(input, false, options[MDT_BACON_OPTION_MODE] == MDT_BACON_OPTION_MODE_01);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_BACON_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_BACON_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_BACON_OPTION_MODE] = newValue;
                },
                items: [MDT_BACON_OPTION_MODE_01, MDT_BACON_OPTION_MODE_AB].map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode,
                    child: mode,
                  );
                }).toList(),
              )
            }));
}
