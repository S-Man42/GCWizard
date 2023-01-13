import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_stateful_dropdownbutton/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/logic/brainfk.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/logic/brainfk_derivative.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/utils/logic_utils/common_utils.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE =
    'multidecoder_tool_esotericlanguage_brainfk_derivate_title';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE = 'common_language';

const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK = 'brainfk_title';

class MultiDecoderToolEsotericLanguageBrainfkDerivate extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageBrainfkDerivate(
      {Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE,
            optionalKey: true,
            onDecode: (String input, String key) {
              if (options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE] ==
                  MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK) {
                try {
                  return interpretBrainfk(input, input: key);
                } catch (e) {
                  return null;
                }
              } else {
                var bfDerivatives = switchMapKeyValue(
                    BRAINFK_DERIVATIVES)[options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE]];
                if (bfDerivatives == null) return null;

                try {
                  return bfDerivatives.interpretBrainfkDerivatives(input, input: key);
                } catch (e) {
                  return null;
                }
              }
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE] = newValue;
                },
                items: ([MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK] + BRAINFK_DERIVATIVES.values.toList())
                    .map((language) {
                  return GCWDropDownMenuItem(
                    value: language,
                    child: i18n(context, language) ?? language,
                  );
                }).toList(),
              )
            }));
}
