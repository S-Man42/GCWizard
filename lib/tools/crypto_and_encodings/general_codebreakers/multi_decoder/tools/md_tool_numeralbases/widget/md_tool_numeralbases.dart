import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/numeral_bases.dart';
import 'package:gc_wizard/tools/common/gcw_numeralbase_spinner/widget/gcw_numeralbase_spinner.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_NUMERALBASES = 'multidecoder_tool_numeralbases_title';
const MDT_NUMERALBASES_OPTION_FROM = 'multidecoder_tool_numeralbases_option_from';

class MultiDecoderToolNumeralBases extends GCWMultiDecoderTool {
  MultiDecoderToolNumeralBases({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_NUMERALBASES,
            onDecode: (String input, String key) {
              return input
                  .split(RegExp(r'\s+'))
                  .where((element) => element.length > 0)
                  .map((element) => convertBase(element, options[MDT_NUMERALBASES_OPTION_FROM], 10))
                  .join(' ');
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_NUMERALBASES_OPTION_FROM: GCWNumeralBaseSpinner(
                value: options[MDT_NUMERALBASES_OPTION_FROM],
                onChanged: (value) {
                  options[MDT_NUMERALBASES_OPTION_FROM] = value;
                },
              )
            }));
}
