import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_derivate.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';


const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE = 'multidecoder_tool_esotericlanguage_brainfk_derivate_title';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE = 'common_language';

const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK = 'brainfk_title';

class MultiDecoderToolEsotericLanguageBrainfkDerivate extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageBrainfkDerivate({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE,
            optionalKey: true,
            onDecode: (String input, String key) {
              switch (options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE]) {
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK:
                  try {
                    var result = interpretBrainfk(input, input: key);
                    return result.replaceAll(String.fromCharCode(0), "").isEmpty ? null : result;
                  } catch (e) {}
                  return null;
                default:
                  try {
                    if (BRAINFK_DERIVATES.values.contains(options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE])) {
                      var brainfkDerivate = getLanguageByName(options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE]);
                      if ((brainfkDerivate != null) && brainfkDerivate.isBrainfkDerivat(input)) {
                        var result = brainfkDerivate.interpretBrainfkDerivat(input, input : key);
                        return result?.replaceAll(String.fromCharCode(0), "").isEmpty ? null : result;
                      }
                    }
                  } catch (e) {}
                  return null;
              }
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE] = newValue;
                },
                items: _buildGCWDropDownMenuItems(context)

            )}));
}

BrainfkDerivate getLanguageByName(String name) {
  return switchMapKeyValue(BRAINFK_DERIVATES)[name];
}

List<GCWDropDownMenuItem> _buildGCWDropDownMenuItems(BuildContext context) {
  var list = BRAINFK_DERIVATES.entries.map((mode) {
    return GCWDropDownMenuItem(
        value: mode.key,
        child: mode.value,
      );
  }).toList();
  list.insertAll(0, [
      GCWDropDownMenuItem(
        value: MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK,
        child: i18n(context, MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK),
      )
  ]);
  return list;
}
