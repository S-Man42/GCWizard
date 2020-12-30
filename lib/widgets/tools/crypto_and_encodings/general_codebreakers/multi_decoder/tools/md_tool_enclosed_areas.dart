import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/enclosed_areas.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ENCLOSEDAREAS = 'multidecoder_tool_enclosedareas_title';

class MultiDecoderToolEnclosedAreas extends GCWMultiDecoderTool {

  MultiDecoderToolEnclosedAreas({Key key, int id, String name, Map<String, dynamic> options}) :
    super(
      key: key,
      id: id,
      name: name,
      internalToolName: MDT_INTERNALNAMES_ENCLOSEDAREAS,
      onDecode: (input) {
        return decodeEnclosedAreas(input, true);
      },
      options: options
    );
}