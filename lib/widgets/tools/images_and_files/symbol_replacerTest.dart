// import 'package:flutter/material.dart';
// import 'package:gc_wizard/i18n/app_localizations.dart';
// import 'package:gc_wizard/theme/theme.dart';
// import 'package:gc_wizard/theme/theme_colors.dart';
// import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_symbol_matrix.dart';
// import 'package:prefs/prefs.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/quadgrams.dart';
// import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/substitution_breaker.dart';
// import 'package:gc_wizard/logic/tools/images_and_files/symbol_replacer.dart';
// import 'package:gc_wizard/widgets/registry.dart';
// import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
// import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
// import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
// import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
// import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
// import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
// import 'package:gc_wizard/widgets/common/gcw_tool.dart';
// import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
// import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/substitution_breaker.dart';
// import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_tool.dart';
// import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
// import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
// import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
// import 'package:gc_wizard/widgets/utils/file_picker.dart';
// import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;
//
// const _ALERT_COUNT_SELECTIONS = 50;
//
// class SymbolReplacer extends StatefulWidget {
//   final local.PlatformFile platformFile;
//   final String symbolKey;
//   final List<Map<String, SymbolData>> imageData;
//
//   const SymbolReplacer({Key key, this.platformFile, this.symbolKey, this.imageData}) : super(key: key);
//
//   @override
//   SymbolReplacerState createState() => SymbolReplacerState();
// }
//
// class SymbolReplacerState extends State<SymbolReplacer> {
//
//   List<Map<String, SymbolData>> images = [];
//   List<String> selectedSymbolTables = [];
//
//   SymbolImage _symbolImage;
//   local.PlatformFile _platformFile;
//   double _blackLevel = 50.0;
//   double _similarityLevel = 100.0;
//   double _similarityCompareLevel = 80.0;
//   var _currentSimpleMode = GCWSwitchPosition.left;
//   List<GCWDropDownMenuItem> _compareSymbolItems;
//   var _gcwTextStyle = gcwTextStyle();
//   var _descriptionTextStyle = gcwDescriptionTextStyle();
//   SymbolTableViewData _currentSymbolTableViewData;
//   var _quadgrams = Map<SubstitutionBreakerAlphabet, Quadgrams>();
//   var _isLoading = <bool>[false];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _initializeImages();
//   }
//
//
//   Future _initializeImages() async {
//     //AssetManifest.json holds the information about all asset files
//     final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//
//     final imagePaths = manifestMap.keys
//         .where((String key) => key.contains(_pathKey()) && key.contains(_LOGO_NAME))
//         .toList();
//
//     if (imagePaths.isEmpty) return;
//
//     for (String imagePath in imagePaths) {
//       final data = await DefaultAssetBundle.of(context).load(imagePath);
//       var key = _symbolKey(imagePath);
//
//       images.add({key: SymbolData(path: imagePath, bytes: data.buffer.asUint8List(), displayName: i18n(context, 'symboltables_${key}_title'))});
//     }
//
//     images.sort((a, b) {
//       return a.values.first.displayName.compareTo(b.values.first.displayName);
//     });
//
//     setState((){});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (images == null || images.isEmpty)
//       return Container();
//
//     final mediaQueryData = MediaQuery.of(context);
//     var countColumns = mediaQueryData.orientation == Orientation.portrait
//         ? Prefs.get('symboltables_countcolumns_portrait')
//         : Prefs.get('symboltables_countcolumns_landscape');
//
//     return Column(
//       children: <Widget>[
//         GCWTextDivider(
//           text: i18n(context, 'symboltablesexamples_selecttables'),
//           suppressTopSpace: true,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: GCWButton(
//                 text: i18n(context, 'symboltablesexamples_selectall'),
//                 margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
//                 onPressed: () {
//                   setState(() {
//                     images.forEach((image) {
//                       var data = image.values.first;
//                       data.primarySelected = true;
//                       selectedSymbolTables.add(_symbolKey(data.path));
//                     });
//                   });
//                 },
//               )
//             ),
//             Container(width: DOUBLE_DEFAULT_MARGIN),
//             Expanded(
//                 child: GCWButton(
//                   text: i18n(context, 'symboltablesexamples_deselectall'),
//                   margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
//                   onPressed: () {
//                     setState(() {
//                       images.forEach((image) {
//                         var data = image.values.first;
//                         data.primarySelected = false;
//                         selectedSymbolTables = <String>[];
//                       });
//                     });
//                   },
//                 )
//             ),
//           ],
//         ),
//         Expanded (
//           child: SingleChildScrollView(
//             child: GCWSymbolSymbolMatrix(
//               imageData: images,
//               countColumns: countColumns,
//               mediaQueryData: mediaQueryData,
//               onChanged: () => setState((){}),
//               selectable: true,
//               allowOverlays: false,
//               onSymbolTapped: (String tappedText, SymbolData imageData) {
//                 if (imageData.primarySelected) {
//                   selectedSymbolTables.add(_symbolKey(imageData.path));
//                 } else {
//                   selectedSymbolTables.remove(_symbolKey(imageData.path));
//                 }
//               },
//             )
//           )
//         ),
//         GCWButton(
//           text: i18n(context, 'symboltablesexamples_submitandnext'),
//           margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
//           onPressed: () {
//             if (selectedSymbolTables.length <= _ALERT_COUNT_SELECTIONS) {
//               _openInSymbolSearch();
//             } else {
//               showGCWAlertDialog(context, i18n(context, 'symboltablesexamples_manyselections_title'),
//                   i18n(context, 'symboltablesexamples_manyselections_text', parameters: [selectedSymbolTables.length]), () => _openInSymbolSearch(),
//                   cancelButton: true);
//
//               return;
//             }
//           },
//         )
//       ],
//     );
//   }
//
//   Widget _buildAdvancedModeControl(BuildContext context) {
//     return Column(children: <Widget>[
//       GCWSlider(
//           title: i18n(context, 'symbol_replacer_similarity_level'),
//           value: _similarityLevel,
//           min: 0,
//           max: 100,
//           onChangeEnd: (value) {
//             _similarityLevel = value;
//             _replaceSymbols(false);
//           }
//       ),
//       GCWSlider(
//           title: i18n(context, 'symbol_replacer_black_level'),
//           value: _blackLevel,
//           min: 0,
//           max: 100,
//           onChangeEnd: (value) {
//             _blackLevel = value;
//             _replaceSymbols(true);
//           }
//       ),
//       _buildSymbolTableDropDown(),
//     ]);
//   }
//
//   Widget _buildSymbolTableDropDown() {
//     return Column(children: <Widget>[
//       GCWTextDivider(text: i18n(context, 'symbol_replacer_symbol_table')),
//       GCWDropDownButton(
//         value: _currentSymbolTableViewData,
//         onChanged: (value) async {
//           _currentSymbolTableViewData = value;
//           if ((_currentSymbolTableViewData is SymbolTableViewData) && (_currentSymbolTableViewData.data == null) ){
//             await _currentSymbolTableViewData.initialize(context);
//           }
//
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _replaceSymbols(false);
//           });
//         },
//         items: _compareSymbolItems,
//         selectedItemBuilder: (BuildContext context) {
//           return _compareSymbolItems.map((item) {
//             return _buildDropDownMenuItem(
//                 (item.value is SymbolTableViewData)
//                     ? (item.value as SymbolTableViewData).icon
//                     : null,
//                 (item.value is SymbolTableViewData)
//                     ? (item.value as SymbolTableViewData).toolName
//                     : i18n(context, 'symbol_replacer_no_symbol_table'),
//                 null);
//           }).toList();
//         },
//       ),
//       GCWSlider(
//           title: i18n(context, 'symbol_replacer_similarity_level'),
//           value: _similarityCompareLevel,
//           min: 0,
//           max: 100,
//           onChangeEnd: (value) {
//             _similarityCompareLevel = value;
//             _replaceSymbols(false);
//           }
//       ),
//     ]);
//   }
//
//   Future<GCWAsyncExecuterParameters> _buildSubstitutionBreakerJobData() async {
//
//     if (_symbolImage == null) return null;
//     if (_symbolImage.symbolGroups == null) return null;
//
//     var quadgrams = await SubstitutionBreakerState.loadQuadgramsAssets(SubstitutionBreakerAlphabet.GERMAN, context, _quadgrams, _isLoading);
//     if (_symbolImage.symbolGroups.length > quadgrams.alphabet.length) {
//       showToast('Too many groups');
//       return null;
//     }
//
//     var input = '';
//     _symbolImage.lines.forEach((line) {
//       line.symbols.forEach((symbol) {
//         var index = _symbolImage.symbolGroups.indexOf(symbol.symbolGroup);
//         input += symbol.symbolGroup == null ? '' : quadgrams.alphabet[index];
//       });
//       input += '\r\n';
//     });
//     input = input.trim();
//
//     return GCWAsyncExecuterParameters(SubstitutionBreakerJobData(input: input, quadgrams: quadgrams));
//   }
//
//   _showSubstitutionBreakerOutput(SubstitutionBreakerResult output) {
//     if (output == null) return;
//
//     if (output.errorCode == SubstitutionBreakerErrorCode.OK) {
//       for (int i = 0; i < _symbolImage.symbolGroups.length; i++)
//         _symbolImage.symbolGroups[i].text = output.key[i].toUpperCase();
//     }
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _replaceSymbols(false);
//     });
//   }
//
//   Widget _buildDropDownMenuItem(dynamic icon, String toolName, String description) {
//     return Row( children: [
//       Container(
//         child: (icon != null) ? icon : Container(width: 50),
//         margin: EdgeInsets.only(left: 2, top:2, bottom: 2, right: 10),
//       ),
//       Expanded(child:
//       Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(toolName, style: _gcwTextStyle),
//             (description != null) ? Text(description, style: _descriptionTextStyle) : Container(),
//           ])
//       )
//     ]);
//   }
//
//   _replaceSymbols(bool useAsyncExecuter) async {
//
//     useAsyncExecuter = ((useAsyncExecuter ||
//         (_symbolImage?.symbolGroups == null) ||
//         (_symbolImage.symbolGroups.isEmpty)) &&
//         _platformFile?.bytes.length > 100000);
//
//     if (!useAsyncExecuter) {
//       var _jobData = await _buildJobDataReplacer();
//
//       _showOutput(await replaceSymbolsAsync(_jobData));
//     } else {
//       await showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return Center(
//             child: Container(
//               child: GCWAsyncExecuter(
//                 isolatedFunction: replaceSymbolsAsync,
//                 parameter: _buildJobDataReplacer(),
//                 onReady: (data) => _showOutput(data),
//                 isOverlay: true,
//               ),
//               height: 220,
//               width: 150,
//             ),
//           );
//         },
//       );
//     }
//   }
//
//   Future<GCWAsyncExecuterParameters> _buildJobDataReplacer() async {
//     return GCWAsyncExecuterParameters(
//         ReplaceSymbolsInput(
//             image: _platformFile?.bytes,
//             blackLevel: _blackLevel.toInt(),
//             similarityLevel: _similarityLevel,
//             symbolImage: _symbolImage,
//             compareSymbols: _currentSymbolTableViewData?.data?.images,
//             similarityCompareLevel: _similarityCompareLevel
//         )
//     );
//   }
//
//   _showOutput(SymbolImage output) {
//     _symbolImage = output;
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() { });
//     });
//   }
// }
//
// class SymbolTableViewData {
//   final String symbolKey;
//   final icon;
//   final toolName;
//   final description;
//   SymbolTableData data;
//
//   SymbolTableViewData({this.symbolKey, this.icon, this.toolName, this.description, this.data});
//
//   Future initialize(BuildContext context) async {
//     var symbolTableData = SymbolTableData(context, symbolKey);
//     await symbolTableData.initialize();
//     data = symbolTableData;
//   }
// }
