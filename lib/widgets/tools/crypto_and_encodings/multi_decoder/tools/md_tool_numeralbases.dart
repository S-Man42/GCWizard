import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/widgets/common/gcw_numeralbase_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_NUMERALBASES = 'multidecoder_tool_numeralbases_title';
const MDT_NUMERALBASES_OPTION_FROM = 'multidecoder_tool_numeralbases_option_from';

class MultiDecoderToolNumeralBases extends GCWMultiDecoderTool {

  MultiDecoderToolNumeralBases({Key key, int id, String name, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      internalToolName: MDT_INTERNALNAMES_NUMERALBASES,
      onDecode: (input) {
        return convertBase(input, options[MDT_NUMERALBASES_OPTION_FROM], 10);
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_NUMERALBASES_OPTION_FROM: GCWNumeralBaseSpinner(
            value: options[MDT_NUMERALBASES_OPTION_FROM],
            onChanged: (value) {
              options[MDT_NUMERALBASES_OPTION_FROM] = value;
            },
          )
        }
      )
    );
}