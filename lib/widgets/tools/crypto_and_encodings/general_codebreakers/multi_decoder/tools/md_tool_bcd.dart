import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_BCD = 'multidecoder_tool_bcd_title';
const MDT_BCD_OPTION_BCDFUNCTION = 'multidecoder_tool_bcd_option_bcdfunction';

class MultiDecoderToolBCD extends GCWMultiDecoderTool {
  MultiDecoderToolBCD({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_BCD,
            onDecode: (input) {
              return decodeBCD(input, BCD_TYPES[options[MDT_BCD_OPTION_BCDFUNCTION]]);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_BCD_OPTION_BCDFUNCTION: GCWStatefulDropDownButton(
                value: options[MDT_BCD_OPTION_BCDFUNCTION],
                onChanged: (newValue) {
                  options[MDT_BCD_OPTION_BCDFUNCTION] = newValue;
                },
                items: BCD_TYPES.entries.map((baseFunction) {
                  return GCWDropDownMenuItem(
                    value: baseFunction.key + '_title',
                    child: i18n(context, baseFunction.key + '_title'),
                  );
                }).toList(),
              ),
            }));
}
