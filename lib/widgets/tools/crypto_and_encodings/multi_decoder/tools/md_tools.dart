import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_rotation.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_hashes.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_numeralbases.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_ascii.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_alphabet_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_rot5.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_rot47.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_rot18.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_base.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_bcd.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_gc_code.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';

final List<String> mdtToolsRegistry = [
  MDT_INTERNALNAMES_ROTATION,
  MDT_INTERNALNAMES_ROT5,
  MDT_INTERNALNAMES_ROT18,
  MDT_INTERNALNAMES_ROT47,
  MDT_INTERNALNAMES_REVERSE,
  MDT_INTERNALNAMES_ATBASH,
  MDT_INTERNALNAMES_ALPHABETVALUES,
  MDT_INTERNALNAMES_ASCII,
  MDT_INTERNALNAMES_NUMERALBASES,
  MDT_INTERNALNAMES_BASE,
  MDT_INTERNALNAMES_BACON,
  MDT_INTERNALNAMES_GCCODE,
  MDT_INTERNALNAMES_BCD,
  MDT_INTERNALNAMES_HASHES,
];

final _initialOptions = <String, Map<String, dynamic>>{
  MDT_INTERNALNAMES_ALPHABETVALUES: {MDT_ALPHABETVALUES_OPTION_ALPHABET: 'alphabet_name_az'},
  MDT_INTERNALNAMES_BACON: {MDT_BACON_OPTION_MODE: 'ab'},
  MDT_INTERNALNAMES_BASE: {MDT_BASE_OPTION_BASEFUNCTION: 'base_base64'},
  MDT_INTERNALNAMES_BCD: {MDT_BCD_OPTION_BCDFUNCTION: 'bcd_original'},
  MDT_INTERNALNAMES_GCCODE: {MDT_GCCODE_OPTION_MODE: 'id_to_gccode'},
  MDT_INTERNALNAMES_HASHES : {MDT_HASHES_OPTION_HASHFUNCTION: 'hashes_md5'},
  MDT_INTERNALNAMES_NUMERALBASES : {MDT_NUMERALBASES_OPTION_FROM: 16},
  MDT_INTERNALNAMES_ROTATION : {MDT_ROTATION_OPTION_KEY: 13},
};

_multiDecoderToolOptionToGCWMultiDecoderToolOptions(List<MultiDecoderToolOption> mdtOptions) {
  var gcwOptions = <String, dynamic>{};

  mdtOptions.forEach((option) {
    gcwOptions.putIfAbsent(option.name, () => option.value);
  });

  return gcwOptions;
}

GCWMultiDecoderTool multiDecoderToolToGCWMultiDecoderTool(BuildContext context, MultiDecoderTool mdtTool) {
  GCWMultiDecoderTool gcwTool;

  var options = _initialOptions[mdtTool.internalToolName] ?? <String, dynamic>{};
  if (mdtTool.options != null && mdtTool.options.length > 0)
    options = _multiDecoderToolOptionToGCWMultiDecoderToolOptions(mdtTool.options);

  switch (mdtTool.internalToolName) {
    case MDT_INTERNALNAMES_ALPHABETVALUES:
      gcwTool = MultiDecoderToolAlphabetValues(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ASCII:
      gcwTool = MultiDecoderToolASCII(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ATBASH:
      gcwTool = MultiDecoderToolAtbash(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_BACON:
      gcwTool = MultiDecoderToolBacon(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_BASE:
      gcwTool = MultiDecoderToolBase(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_BCD:
      gcwTool = MultiDecoderToolBCD(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_GCCODE:
      gcwTool = MultiDecoderToolGCCode(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_HASHES:
      gcwTool = MultiDecoderToolHashes(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_NUMERALBASES:
      gcwTool = MultiDecoderToolNumeralBases(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_REVERSE:
      gcwTool = MultiDecoderToolReverse(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROT18:
      gcwTool = MultiDecoderToolROT18(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROT47:
      gcwTool = MultiDecoderToolROT47(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROT5:
      gcwTool = MultiDecoderToolROT5(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROTATION:
      gcwTool = MultiDecoderToolRotation(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
  }

  return gcwTool;
}