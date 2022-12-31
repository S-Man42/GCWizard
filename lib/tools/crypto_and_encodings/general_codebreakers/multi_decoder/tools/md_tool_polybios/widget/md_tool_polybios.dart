import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/logic/polybios.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/common_widgets/gcw_alphabetmodification_dropdownbutton/widget/gcw_alphabetmodification_dropdownbutton.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_playfair/widget/md_tool_playfair.dart';

const MDT_INTERNALNAMES_POLYBIOS = 'multidecoder_tool_polybios_title';
const MDT_POLYBIOS_OPTION_MODE = 'multidecoder_tool_polybios_option_mode';

class MultiDecoderToolPolybios extends GCWMultiDecoderTool {
  MultiDecoderToolPolybios({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_POLYBIOS,
            onDecode: (String input, String key) {
              var polybiosOutput = decryptPolybios(input, key,
                  mode: PolybiosMode.AZ09, modificationMode: _parseStringToEnum(options[MDT_POLYBIOS_OPTION_MODE]));
              return polybiosOutput == null ? null : polybiosOutput.output;
            },
            requiresKey: true,
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_POLYBIOS_OPTION_MODE: GCWAlphabetModificationDropDownButton(
                suppressTitle: true,
                value: _parseStringToEnum(options[MDT_POLYBIOS_OPTION_MODE]),
                onChanged: (newValue) {
                  options[MDT_POLYBIOS_OPTION_MODE] = alphabetModeName(newValue);
                },
              )
            }));
}

AlphabetModificationMode _parseStringToEnum(String item) {
  return AlphabetModificationMode.values.firstWhere((e) => alphabetModeName(e) == item);
}
