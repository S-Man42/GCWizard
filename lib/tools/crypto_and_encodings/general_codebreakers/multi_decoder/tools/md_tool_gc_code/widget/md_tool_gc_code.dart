import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gc_code/logic/gc_code.dart';
import 'package:gc_wizard/tools/common/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';
import 'package:gc_wizard/tools/common/gcw_stateful_dropdownbutton/widget/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_GCCODE = 'multidecoder_tool_gccode_title';
const MDT_GCCODE_OPTION_MODE = 'multidecoder_tool_gccode_option_mode';
const MDT_GCCODE_OPTION_MODE_IDTOGCCODE = 'multidecoder_tool_gccode_option_mode_id.to.gccode';
const MDT_GCCODE_OPTION_MODE_GCCODETOID = 'multidecoder_tool_gccode_option_mode_gccode.to.id';

class MultiDecoderToolGCCode extends GCWMultiDecoderTool {
  MultiDecoderToolGCCode({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_GCCODE,
            onDecode: (String input, String key) {
              if (options[MDT_GCCODE_OPTION_MODE] == MDT_GCCODE_OPTION_MODE_IDTOGCCODE)
                return idToGCCode(int.tryParse(input));
              else
                return gcCodeToID(input);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_GCCODE_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_GCCODE_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_GCCODE_OPTION_MODE] = newValue;
                },
                items: [MDT_GCCODE_OPTION_MODE_IDTOGCCODE, MDT_GCCODE_OPTION_MODE_GCCODETOID].map((type) {
                  return GCWDropDownMenuItem(
                    value: type,
                    child: i18n(context, type),
                  );
                }).toList(),
              )
            }));
}
