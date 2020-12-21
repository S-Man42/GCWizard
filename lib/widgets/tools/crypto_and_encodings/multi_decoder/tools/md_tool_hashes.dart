import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

const MDT_INTERNALNAMES_HASHES = 'hashes';
const MDT_HASHES_OPTION_HASHFUNCTION = 'hashFunction';

class MultiDecoderToolHashes extends GCWMultiDecoderTool {

  BuildContext context;

  MultiDecoderToolHashes({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options, this.context}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_HASHES,
      onDecode: (input) {
        return HASH_FUNCTIONS[options[MDT_HASHES_OPTION_HASHFUNCTION]](input);
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_HASHES_OPTION_HASHFUNCTION: GCWStatefulDropDownButton(
            value: options[MDT_HASHES_OPTION_HASHFUNCTION],
            onChanged: (newValue) {
              options[MDT_HASHES_OPTION_HASHFUNCTION] = newValue;
            },
            items: HASH_FUNCTIONS.entries.map((hashFunction) {
              return GCWDropDownMenuItem(
                value: hashFunction.key,
                child: i18n(context, hashFunction.key + '_title'),
              );
            }).toList(),
          ),
        }
      )
    );
}