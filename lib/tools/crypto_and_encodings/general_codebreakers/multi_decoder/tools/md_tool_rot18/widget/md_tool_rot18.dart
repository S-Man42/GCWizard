import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/rotator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ROT18 = 'multidecoder_tool_rot18_title';

class MultiDecoderToolROT18 extends GCWMultiDecoderTool {
  MultiDecoderToolROT18({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ROT18,
            onDecode: (String input, String key) {
              return Rotator().rot18(input);
            },
            options: options);
}
