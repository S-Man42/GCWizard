import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/roman_numbers/chronogram.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_CHRONOGRAM = 'multidecoder_tool_chronogram_title';

class MultiDecoderToolChronogram extends GCWMultiDecoderTool {
  MultiDecoderToolChronogram({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_CHRONOGRAM,
            onDecode: (String input) {
              return recognizableChronogramInput(input);
            },
            options: options);
}

