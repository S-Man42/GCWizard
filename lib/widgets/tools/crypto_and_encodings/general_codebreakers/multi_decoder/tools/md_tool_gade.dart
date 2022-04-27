import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_GADE = 'gade_title';

class MultiDecoderToolGade extends GCWMultiDecoderTool {
  MultiDecoderToolGade({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            requiresKey: true,
            internalToolName: MDT_INTERNALNAMES_GADE,
            onDecode: (String input, String key) {
              var result = buildGade(key, input);
              return result?.item2 == null || result?.item2?.isEmpty ? null : result?.item2;
            },
            options: options);
}
