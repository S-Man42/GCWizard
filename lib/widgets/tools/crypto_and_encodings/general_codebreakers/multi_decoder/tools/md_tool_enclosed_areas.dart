import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/enclosed_areas.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

import '../gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ENCLOSEDAREAS = 'multidecoder_tool_enclosedareas_title';
const MDT_ENCLOSEDAREAS_OPTION_MODE = 'multidecoder_tool_bacon_option_mode';


class MultiDecoderToolEnclosedAreas extends GCWMultiDecoderTool {
  MultiDecoderToolEnclosedAreas({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ENCLOSEDAREAS,
            onDecode: (String input, String key) {
              if (withKey(key)) return null;
              return decodeEnclosedAreas(input, options[MDT_ENCLOSEDAREAS_OPTION_MODE] == 'enclosedareas_with4');
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ENCLOSEDAREAS_OPTION_MODE: GCWTwoOptionsSwitch(
                value: options[MDT_ENCLOSEDAREAS_OPTION_MODE] == 'enclosedareas_with4' ? GCWSwitchPosition.left : GCWSwitchPosition.right,
                notitle: true,
                leftValue: i18n(context, 'enclosedareas_with4'),
                rightValue: i18n(context, 'enclosedareas_without4'),
                onChanged: (value) {
                  options[MDT_ENCLOSEDAREAS_OPTION_MODE] = value == GCWSwitchPosition.left ? 'enclosedareas_with4' : 'enclosedareas_without4';
                },
              )
            }));
}
