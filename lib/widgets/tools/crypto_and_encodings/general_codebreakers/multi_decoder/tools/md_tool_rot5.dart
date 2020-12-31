import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ROT5 = 'multidecoder_tool_rot5_title';

class MultiDecoderToolROT5 extends GCWMultiDecoderTool {

  MultiDecoderToolROT5({Key key, int id, String name, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      internalToolName: MDT_INTERNALNAMES_ROT5,
      onDecode: (input) {
        return Rotator().rot5(input);
      },
      options: options
    );
}