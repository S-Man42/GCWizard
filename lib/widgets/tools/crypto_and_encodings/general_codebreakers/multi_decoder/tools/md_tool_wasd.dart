import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wasd.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_WASD = 'multidecoder_tool_wasd_title';
const MDT_WASD_OPTION_SET = 'wasd_control_set';

class MultiDecoderToolWasd extends GCWMultiDecoderTool {
  MultiDecoderToolWasd({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_WASD,
            onDecode: (String input) {
              if (input == null) return null;
              return binary2image(decodeWASDGraphic(input, (options[MDT_WASD_OPTION_SET] as String).characters.toList()), false, false);
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_WASD_OPTION_SET: GCWStatefulDropDownButton(
                value: switchMapKeyValue(KEYBOARD_CONTROLS)[options[MDT_WASD_OPTION_SET]],
                onChanged: (newValue) {
                  options[MDT_WASD_OPTION_SET] = KEYBOARD_CONTROLS[newValue];
                },
                items: KEYBOARD_CONTROLS.entries.where((element) => element.key != WASD_TYPE.CUSTOM).map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: i18n(context, mode.value) ?? mode.value,
                  );
                }).toList(),
              ),
            }));
}

