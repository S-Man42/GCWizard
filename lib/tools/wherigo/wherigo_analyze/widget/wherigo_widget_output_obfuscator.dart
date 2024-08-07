part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/widget/wherigo_analyze.dart';

List<List<String>> _buildWidgetToDisplayObfuscatorData(BuildContext context, List<List<String>> data) {
  List<List<String>> result = [];

  if (WherigoCartridgeLUAData.ObfuscatorTable.isEmpty) {
    return [
      [i18n(context, 'wherigo_header_obfuscatorfunction'), '']
    ];
  }

  if (WHERIGOExpertMode) {
    result = _buildOutputListOfObfuscatorDataExpertMode(context, data);
  } else {
    result = _buildOutputListOfObfuscatorDataUserMode(context, data);
  }

 return result;
}

// if (WherigoCartridgeLUAData.ObfuscatorTable != '')
//   GCWOutput(
//     title: i18n(context, 'wherigo_header_obfuscatorfunction'),
//     child: WherigoCartridgeLUAData.ObfuscatorFunction,
//     suppressCopyButton: (WherigoCartridgeLUAData.ObfuscatorFunction == 'NO_OBFUSCATOR'),
//   ),
// if (WherigoCartridgeLUAData.ObfuscatorTable != '')
//   GCWOutput(
//     title: 'dTable',
//     child: GCWOutputText(
//       text: WherigoCartridgeLUAData.ObfuscatorTable,
//       style: gcwMonotypeTextStyle(),
//     ),
//   ),

List<List<String>> _buildOutputListOfObfuscatorDataUserMode(BuildContext context, List<List<String>> data) {
  List<List<String>> result = [];
  for (int i = 0; i < data[0].length; i++) {
    result.add([i18n(context, 'wherigo_header_obfuscatorfunction'), data[0][i]]);
    result.add(['dTable', data[1][i]]);
  }
  return result;
}

List<List<String>> _buildOutputListOfObfuscatorDataExpertMode(BuildContext context, List<List<String>> data) {
  List<List<String>> result = [];
  for (int i = 0; i < data[0].length; i++) {
    result.add([i18n(context, 'wherigo_header_obfuscatorfunction'), data[0][i]]);
    result.add(['dTable', data[1][i]]);
  }
  return result;
}


