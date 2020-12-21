import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

const MDT_INTERNALNAMES_BCD = 'bcd';
const MDT_BCD_OPTION_BCDFUNCTION = 'bcdFunction';

class MultiDecoderToolBCD extends GCWMultiDecoderTool {

  BuildContext context;

  MultiDecoderToolBCD({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options, this.context}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_BCD,
      onDecode: (input) {
        return decodeBCD(input, BCD_TYPES[options[MDT_BCD_OPTION_BCDFUNCTION]]);
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_BCD_OPTION_BCDFUNCTION: GCWStatefulDropDownButton(
            value: options[MDT_BCD_OPTION_BCDFUNCTION],
            onChanged: (newValue) {
              options[MDT_BCD_OPTION_BCDFUNCTION] = newValue;
            },
            items: BCD_TYPES.entries.map((baseFunction) {
              return GCWDropDownMenuItem(
                value: baseFunction.key,
                child: i18n(context, baseFunction.key + '_title'),
              );
            }).toList(),
          ),
        }
      )
    );
}