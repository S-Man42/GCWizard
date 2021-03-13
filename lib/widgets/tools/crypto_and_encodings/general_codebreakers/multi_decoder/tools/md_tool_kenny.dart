import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_KENNY = 'multidecoder_tool_kenny_title';

class MultiDecoderToolKenny extends GCWMultiDecoderTool {
  MultiDecoderToolKenny({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_KENNY,
            onDecode: (input) {
              return decryptKenny(input, ['m', 'p', 'f'], true);
            },
            options: options);
}
