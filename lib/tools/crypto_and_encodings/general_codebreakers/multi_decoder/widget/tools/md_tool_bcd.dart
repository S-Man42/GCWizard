import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_stateful_dropdown.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';

const MDT_INTERNALNAMES_BCD = 'multidecoder_tool_bcd_title';
const MDT_BCD_OPTION_BCDFUNCTION = 'multidecoder_tool_bcd_option_bcdfunction';

class MultiDecoderToolBCD extends AbstractMultiDecoderTool {
  MultiDecoderToolBCD({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_BCD,
            onDecode: (String input, String key) {
              return decodeBCD(input, BCD_TYPES[options[MDT_BCD_OPTION_BCDFUNCTION]]);
            },
            options: options,
            configurationWidget: MultiDecoderToolConfiguration(widgets: {
              MDT_BCD_OPTION_BCDFUNCTION: GCWStatefulDropDown(
                value: options[MDT_BCD_OPTION_BCDFUNCTION],
                onChanged: (newValue) {
                  options[MDT_BCD_OPTION_BCDFUNCTION] = newValue;
                },
                items: BCD_TYPES.entries.map((baseFunction) {
                  return GCWDropDownMenuItem(
                    value: baseFunction.key,
                    child: i18n(context, baseFunction.key + '_title'),
                  );
                }).toList(),
              ),
            }));
}
