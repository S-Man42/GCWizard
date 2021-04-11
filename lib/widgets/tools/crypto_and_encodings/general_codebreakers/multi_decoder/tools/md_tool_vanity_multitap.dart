import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_VANITYMULTITAP = 'multidecoder_tool_vanitymultitap_title';
const MDT_VANITYMULTITAP_OPTION_PHONEMODEL = 'multidecoder_tool_vanitymultitap_option_phonemodel';

class MultiDecoderToolVanityMultitap extends GCWMultiDecoderTool {
  MultiDecoderToolVanityMultitap({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_VANITYMULTITAP,
            onDecode: (input) {
              return decodeVanityMultipleNumbers(
                  input, getPhoneModelByName(options[MDT_VANITYMULTITAP_OPTION_PHONEMODEL]));
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_VANITYMULTITAP_OPTION_PHONEMODEL: GCWStatefulDropDownButton(
                  value: options[MDT_VANITYMULTITAP_OPTION_PHONEMODEL],
                  onChanged: (newValue) {
                    options[MDT_VANITYMULTITAP_OPTION_PHONEMODEL] = newValue;
                  },
                  items: PHONE_MODELS.map((model) {
                    return GCWDropDownMenuItem(value: model.name, child: model.name);
                  }).toList()),
            }));
}
