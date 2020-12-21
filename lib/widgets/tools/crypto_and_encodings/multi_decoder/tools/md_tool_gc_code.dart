import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gc_code.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

const MDT_INTERNALNAMES_GCCODE = 'gc_code';
const MDT_GCCODE_OPTION_MODE = 'mode';

class MultiDecoderToolGCCode extends GCWMultiDecoderTool {

  MultiDecoderToolGCCode({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options, BuildContext context}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_GCCODE,
      onDecode: (input) {
        if (options[MDT_GCCODE_OPTION_MODE] == 'id_to_gccode')
          return idToGCCode(int.tryParse(input));
        else
          return gcCodeToID(input);
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_GCCODE_OPTION_MODE: GCWTwoOptionsSwitch(
            value: options[MDT_GCCODE_OPTION_MODE] == 'id_to_gccode' ? GCWSwitchPosition.left : GCWSwitchPosition.right,
            leftValue: 'id_to_gccode',
            rightValue: 'gccode_to_id',
            onChanged: (value) {
              options[MDT_GCCODE_OPTION_MODE] = value == GCWSwitchPosition.left ? 'id_to_gccode' : 'gccode_to_id';
            },
          )
        }
      )
    );
}