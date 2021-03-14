import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_REVERSE = 'multidecoder_tool_reverse_title';

class MultiDecoderToolReverse extends GCWMultiDecoderTool {
  MultiDecoderToolReverse({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_REVERSE,
            onDecode: (input) {
              return reverse(input);
            },
            options: options);
}
