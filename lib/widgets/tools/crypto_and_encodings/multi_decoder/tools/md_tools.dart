import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tool_rotation.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';

List<String> mdtToolsRegistry = [
  MULTIDECODERTOOL_INTERNALNAMES_ROTATION
];

_multiDecoderToolOptionToGCWMultiDecoderToolOptions(List<MultiDecoderToolOption> mdtOptions) {
  var gcwOptions = <String, dynamic>{};

  mdtOptions.forEach((option) {
    gcwOptions.putIfAbsent(option.name, () => option.value);
  });

  return gcwOptions;
}

GCWMultiDecoderTool multiDecoderToolToGCWMultiDecoderTool(MultiDecoderTool mdtTool) {
  GCWMultiDecoderTool gcwTool;
  var options = _multiDecoderToolOptionToGCWMultiDecoderToolOptions(mdtTool.options);

  switch (mdtTool.internalToolName) {
    case MULTIDECODERTOOL_INTERNALNAMES_ROTATION: gcwTool = new MultiDecoderToolRotation(id: mdtTool.id, name: mdtTool.name, options: options);
  }

  return gcwTool;
}