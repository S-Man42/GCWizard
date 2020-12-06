import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';

class MDTCaesar extends GCWMultiDecoderTool {

  MDTCaesar({Key key, MultiDecoderToolState state, String input, Map<String, dynamic> parameters}) :
    super(
      key: key,
      state: state,
      decodeFunction: Rotator().rotate(),
      parameters: parameters,
      configurationWidget: Column(
        children: [
          GCWABCSpinner(
            onChanged: (value) {
              parameters['key'] = value;
            },
          )
        ]
      )
    );
}