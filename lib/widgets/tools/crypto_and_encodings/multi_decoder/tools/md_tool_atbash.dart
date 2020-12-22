import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ATBASH = 'multidecoder_tool_atbash_title';

class MultiDecoderToolAtbash extends GCWMultiDecoderTool {

  MultiDecoderToolAtbash({Key key, int id, String name, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      internalToolName: MDT_INTERNALNAMES_ATBASH,
      onDecode: (input) {
        return atbash(input);
      },
      options: options
    );
}