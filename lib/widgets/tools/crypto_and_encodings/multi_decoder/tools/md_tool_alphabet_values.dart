import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/alphabet_values.dart' as logic;
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

const MDT_INTERNALNAMES_ALPHABETVALUES = 'alphabetvalues';
const MDT_ALPHABETVALUES_OPTION_ALPHABET = 'alphabet';

class MultiDecoderToolAlphabetValues extends GCWMultiDecoderTool {

  MultiDecoderToolAlphabetValues({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options, BuildContext context}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_ALPHABETVALUES,
      onDecode: (String input) {
        var alphabet = availableAlphabets().firstWhere((alphabet) => alphabet.key == options['alphabet']).alphabet;

        return logic.AlphabetValues(alphabet: alphabet).valuesToText(
          input.split(RegExp(r'[^0-9]')).map((value) => int.tryParse(value)).toList()
        );
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_ALPHABETVALUES_OPTION_ALPHABET: GCWStatefulDropDownButton(
            value: options['alphabet'],
            items: availableAlphabets().map((alphabet) {
              return GCWDropDownMenuItem(
                value: alphabet.key,
                child: alphabet.type == AlphabetType.STANDARD ? i18n(context, alphabet.key) : alphabet.name
              );
            }).toList(),
            onChanged: (value) {
              options['alphabet'] = value;
            },
          )
        }
      )
    );
}