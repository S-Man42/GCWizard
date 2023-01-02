import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/logic/phone_models.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/logic/vanity.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_stateful_dropdownbutton/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_VANITYMULTITAP = 'multidecoder_tool_vanitymultitap_title';
const MDT_VANITYMULTITAP_OPTION_PHONEMODEL = 'multidecoder_tool_vanitymultitap_option_phonemodel';

class MultiDecoderToolVanityMultitap extends GCWMultiDecoderTool {
  //artifact from 1.5.0
  static String _ensureBackwardsCompatibility(String modelName) {
    switch (modelName) {
      case 'Nokia':
      case 'Samsung':
        return NAME_PHONEMODEL_SIMPLE_SPACE_0;
      case 'Siemens':
        return NAME_PHONEMODEL_SIMPLE_SPACE_1;
      default:
        return modelName;
    }
  }

  MultiDecoderToolVanityMultitap({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_VANITYMULTITAP,
            onDecode: (String input, String key) {
              var model;

              var modelName = _ensureBackwardsCompatibility(options[MDT_VANITYMULTITAP_OPTION_PHONEMODEL]);

              switch (modelName) {
                case NAME_PHONEMODEL_SIMPLE_SPACE_0:
                  model = PHONEMODEL_SIMPLE_SPACE_0;
                  break;
                case NAME_PHONEMODEL_SIMPLE_SPACE_1:
                  model = PHONEMODEL_SIMPLE_SPACE_1;
                  break;
                case NAME_PHONEMODEL_SIMPLE_SPACE_HASH:
                  model = PHONEMODEL_SIMPLE_SPACE_HASH;
                  break;
                case NAME_PHONEMODEL_SIMPLE_SPACE_ASTERISK:
                  model = PHONEMODEL_SIMPLE_SPACE_ASTERISK;
                  break;
              }

              return decodeVanityMultitap(input, model, PhoneInputLanguage.UNSPECIFIED)['output'];
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_VANITYMULTITAP_OPTION_PHONEMODEL: GCWStatefulDropDownButton(
                  value: _ensureBackwardsCompatibility(options[MDT_VANITYMULTITAP_OPTION_PHONEMODEL]),
                  onChanged: (newValue) {
                    options[MDT_VANITYMULTITAP_OPTION_PHONEMODEL] = newValue;
                  },
                  items: [
                    NAME_PHONEMODEL_SIMPLE_SPACE_0,
                    NAME_PHONEMODEL_SIMPLE_SPACE_1,
                    NAME_PHONEMODEL_SIMPLE_SPACE_HASH,
                    NAME_PHONEMODEL_SIMPLE_SPACE_ASTERISK,
                  ].map((model) {
                    return GCWDropDownMenuItem(value: model, child: i18n(context, model));
                  }).toList()),
            }));
}
