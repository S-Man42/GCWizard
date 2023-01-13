import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_stateful_dropdown.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/logic/keyboard.dart';

const MDT_INTERNALNAMES_KEYBOARDNUMBERS = 'multidecoder_tool_keyboardnumbers_title';
const MDT_KEYBOARDNUMBERS_OPTION_TYPE = 'multidecoder_tool_keyboardnumbers_type';

class MultiDecoderToolKeyboardNumbers extends GCWMultiDecoderTool {
  MultiDecoderToolKeyboardNumbers({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_KEYBOARDNUMBERS,
            onDecode: (String input, String key) {
              return keyboardNumbersByName[options[MDT_KEYBOARDNUMBERS_OPTION_TYPE]](input).trim();
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_KEYBOARDNUMBERS_OPTION_TYPE: GCWStatefulDropDown(
                value: options[MDT_KEYBOARDNUMBERS_OPTION_TYPE],
                onChanged: (newValue) {
                  options[MDT_KEYBOARDNUMBERS_OPTION_TYPE] = newValue;
                },
                items: keyboardNumbersByName
                    .map((name, function) {
                      return MapEntry(name, GCWDropDownMenuItem(value: name, child: i18n(context, name)));
                    })
                    .values
                    .toList(),
              )
            }));
}
