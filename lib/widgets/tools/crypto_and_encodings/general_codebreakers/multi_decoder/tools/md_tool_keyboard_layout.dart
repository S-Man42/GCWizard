import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/keyboard.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_KEYBOARDLAYOUT = 'multidecoder_tool_keyboardlayout_title';
const MDT_KEYBOARDLAYOUT_OPTION_FROM = 'keyboard_from';
const MDT_KEYBOARDLAYOUT_OPTION_TO = 'keyboard_to';

class MultiDecoderToolKeybordLayout extends GCWMultiDecoderTool {
  MultiDecoderToolKeybordLayout({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_KEYBOARDLAYOUT,
            onDecode: (String input, String key) {
              if (input == null) return null;
              return encodeKeyboard(input, _parseStringToEnum(options[MDT_KEYBOARDLAYOUT_OPTION_FROM]),
                  _parseStringToEnum(options[MDT_KEYBOARDLAYOUT_OPTION_TO]));
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_KEYBOARDLAYOUT_OPTION_FROM: GCWStatefulDropDownButton(
                value: _parseStringToEnum(options[MDT_KEYBOARDLAYOUT_OPTION_FROM]),
                onChanged: (newValue) {
                  options[MDT_KEYBOARDLAYOUT_OPTION_FROM] = shortKeyboardName(newValue);
                },
                items: allKeyboards.map((keyboard) {
                  return GCWDropDownMenuItem(
                      value: keyboard.key,
                      child: i18n(context, keyboard.name),
                      subtitle: keyboard.example
                  );
                }).toList(),
              ),
              MDT_KEYBOARDLAYOUT_OPTION_TO: GCWStatefulDropDownButton(
                value: _parseStringToEnum(options[MDT_KEYBOARDLAYOUT_OPTION_TO]),
                onChanged: (newValue) {
                  options[MDT_KEYBOARDLAYOUT_OPTION_TO] = shortKeyboardName(newValue);
                },
                items: allKeyboards.map((keyboard) {
                  return GCWDropDownMenuItem(
                      value: keyboard.key,
                      child: i18n(context, keyboard.name),
                      subtitle: keyboard.example
                  );
                }).toList(),
              ),
            }));
}

enumKeyboardLayout _parseStringToEnum(String item) {
  return enumKeyboardLayout.values.firstWhere((e) => shortKeyboardName(e) == item);
}

String shortKeyboardName(enumKeyboardLayout item) {
  if (item == null) return null;
  return item.toString().replaceAll('enumKeyboardLayout.', '');
}

String keyboardOptionToNameLabel(String item) {
  var enumValue = _parseStringToEnum(item);
  return allKeyboards.where((keyboard) => keyboard.key == enumValue)?.first?.name;
}
