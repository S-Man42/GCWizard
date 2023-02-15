part of 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';

abstract class AbstractMultiDecoderTool {
  final int id;
  String name;
  final String internalToolName;
  final Object? Function(String, String) onDecode;
  final MultiDecoderToolConfiguration configurationWidget;
  final bool requiresKey;
  final bool optionalKey;
  Map<String, Object>? options = {};

  AbstractMultiDecoderTool(
      {Key? key,
      required this.id,
      required this.name,
      required this.internalToolName,
      required this.onDecode,
      this.requiresKey = false,
      this.optionalKey = false,
      required this.configurationWidget,
      this.options});
}
