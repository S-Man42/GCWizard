import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_CCITT1 = 'multidecoder_tool_ccitt1_title';
const MDT_CCITT1_OPTION_MODE = 'ccitt1_numeralbase';

const MDT_CCITT1_OPTION_MODE_DENARY = 'common_numeralbase_denary';
const MDT_CCITT1_OPTION_MODE_BINARY = 'common_numeralbase_binary';

class MultiDecoderToolCcitt1 extends GCWMultiDecoderTool {
  MultiDecoderToolCcitt1({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_CCITT1,
            onDecode: (String input, String key) {
              if (options[MDT_CCITT1_OPTION_MODE] == MDT_CCITT1_OPTION_MODE_BINARY) {
                return decodeCCITT(textToBinaryList(input).map((value) {
                  return int.tryParse(convertBase(value, 2, 10));
                }).toList(), TeletypewriterCodebook.CCITT_ITA1_EU);
              } else
                return decodeCCITT(textToIntList(input), TeletypewriterCodebook.CCITT_ITA1_EU);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_CCITT1_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_CCITT1_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_CCITT1_OPTION_MODE] = newValue;
                },
                items: [MDT_CCITT1_OPTION_MODE_DENARY, MDT_CCITT1_OPTION_MODE_BINARY].map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode,
                    child: i18n(context, mode),
                  );
                }).toList(),
              )
            }));
}
