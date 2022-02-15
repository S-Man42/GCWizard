import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK = 'brainfk_title';

class MultiDecoderToolEsotericLanguageBrainfk extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageBrainfk({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK,
            optionalKey: true,
            onDecode: (String input, String key) {
              try {
                var result = interpretBrainfk(input, input: key);
                return result.replaceAll(String.fromCharCode(0), "").isEmpty ? null : result;
              } catch (e) {}
              return null;
            },
            options: options);
  }
