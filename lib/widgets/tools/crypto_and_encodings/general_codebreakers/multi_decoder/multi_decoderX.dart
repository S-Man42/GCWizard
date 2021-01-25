 import 'package:flutter/material.dart';
// import 'package:gc_wizard/i18n/app_localizations.dart';
// import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
// import 'package:gc_wizard/persistence/multi_decoder/json_provider.dart';
// import 'package:gc_wizard/persistence/multi_decoder/model.dart';
// import 'package:gc_wizard/theme/theme.dart';
// import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
// import 'package:gc_wizard/widgets/common/gcw_output.dart';
// import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
// import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
// import 'package:gc_wizard/widgets/common/gcw_tool.dart';
 import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
// import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder_configuration.dart';
// import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_coordinate_formats.dart';
// import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tools.dart';
// import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

//import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/substitution_breaker.dart';
//import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/vigenere_breaker.dart';

class MultiDecoderJobData {
  final List<GCWMultiDecoderTool> mdtTools; //
  final BuildContext context; //BuildContext
  final String input;

  MultiDecoderJobData({
    this.mdtTools = null,
    this.context = null,
    this.input = ''
  });
}


void calculateOutputAsync(dynamic jobData) async {
  var output = _calculateOutput(
      jobData.parameters.mdtTools,
      jobData.parameters.context,
      jobData.parameters.input
  );

  jobData.sendAsyncPort.send(output);
}

_calculateOutput(List<GCWMultiDecoderTool> mdtTools, BuildContext context, String input) {
  return Container();
  // var results = mdtTools.map((tool) {
  //   var result;
  //
  //   try {
  //     result = tool.onDecode(input);
  //   } catch(e){}
  //
  //   if (result == null || result.toString().length == 0)
  //     return Container();
  //
  //   return GCWOutput(
  //     title: "", //_toolTitle(context, tool),
  //     child: result,
  //   );
  // }).toList();
  //
  // return Column(
  //     children: results
  // );
}

// _toolTitle(BuildContext context, GCWMultiDecoderTool tool) {
//   var optionValues = tool.options.values.map((value) {
//     var result = value;
//
//     if (tool.internalToolName == MDT_INTERNALNAMES_COORDINATEFORMATS) {
//       result = getCoordinateFormatByKey(value).name;
//     }
//
//     return i18n(context, result.toString()) ?? result;
//   }).join(', ');
//
//   var result = tool.name;
//   if (optionValues != null && optionValues.length > 0)
//     result += ' ($optionValues)';
//
//   return result;
// }

