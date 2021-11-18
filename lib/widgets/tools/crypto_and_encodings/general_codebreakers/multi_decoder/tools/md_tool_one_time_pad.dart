import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/one_time_pad.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ONETIMEPAD = 'multidecoder_tool_onetimepad_title';
const MDT_ONETIMEPAD_OPTION_KEY = 'onetimepad_keyoffset';

class MultiDecoderToolOneTimePad extends GCWMultiDecoderTool {
  MultiDecoderToolOneTimePad({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ONETIMEPAD,
            onDecode: (String input, String key) {
              if (!withKey(key)) return null;
              return decryptOneTimePad(input, key, keyOffset: options[MDT_ONETIMEPAD_OPTION_KEY] - 1);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ONETIMEPAD_OPTION_KEY: GCWIntegerSpinner(
                value: options[MDT_ONETIMEPAD_OPTION_KEY],
                onChanged: (value) {
                  options[MDT_ONETIMEPAD_OPTION_KEY] = value;
                }
              ),
            }));
}
