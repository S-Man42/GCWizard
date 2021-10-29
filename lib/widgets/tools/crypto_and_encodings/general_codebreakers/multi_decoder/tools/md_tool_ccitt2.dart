import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt2.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_CCITT2 = 'multidecoder_tool_ccitt2_title';
const MDT_CCITT2_OPTION_MODE = 'ccitt2_numeralbase';

class MultiDecoderToolCcitt2 extends GCWMultiDecoderTool {
  MultiDecoderToolCcitt2({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_CCITT2,
            onDecode: (input) {
              if (options[MDT_CCITT2_OPTION_MODE] == 'binary') {
                return decodeCCITT2(textToBinaryList(input).map((value) {
                  return int.tryParse(convertBase(value, 2, 10));
                }).toList());
              } else
                return decodeCCITT2(textToIntList(input));
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_CCITT2_OPTION_MODE: GCWTwoOptionsSwitch(
                value: options[MDT_CCITT2_OPTION_MODE] == 'binary' ? GCWSwitchPosition.right : GCWSwitchPosition.left,
                notitle: true,
                leftValue: i18n(context, 'common_numeralbase_denary'),
                rightValue: i18n(context, 'common_numeralbase_binary'),
                onChanged: (value) {
                  options[MDT_CCITT2_OPTION_MODE] = value == GCWSwitchPosition.left ? 'denary' : 'binary';
                },
              )
            }));
}
