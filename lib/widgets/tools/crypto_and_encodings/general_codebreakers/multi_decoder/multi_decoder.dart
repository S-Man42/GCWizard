import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/persistence/multi_decoder/json_provider.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder_configuration.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_coordinate_formats.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tools.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

//import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/substitution_breaker.dart';
//import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/vigenere_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoderX.dart';

// class MultiDecoderJobData {
//   final List<GCWMultiDecoderTool> mdtTools;
//   final BuildContext context;
//   final String input;
//
//   MultiDecoderJobData({
//     this.mdtTools = null,
//     this.context = null,
//     this.input = ''
//   });
// }

class MultiDecoder extends StatefulWidget {
  @override
  MultiDecoderState createState() => MultiDecoderState();
}

class MultiDecoderState extends State<MultiDecoder> {
  var _controller;
  List<GCWMultiDecoderTool> _mdtTools;

  String _currentInput = '';
  Widget _currentOutput;

  var _firstBuild = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);

    refreshMultiDecoderTools();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _refreshMDTTools() {
    _mdtTools = multiDecoderTools.map((mdtTool) {
      return multiDecoderToolToGCWMultiDecoderTool(context, mdtTool);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_firstBuild && multiDecoderTools.length == 0) {
      initializeMultiToolDecoder(context);
      _firstBuild = false;
    }

    _refreshMDTTools();

    if (_currentOutput == null)
      _initOutput();

    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Container(
                child: GCWTextField(
                  controller: _controller,
                  onChanged: (text) {
                    _currentInput = text;
                    if (_currentInput == null || _currentInput.length == 0) {
                      setState(() {
                        _currentOutput = null;
                      });
                    }
                  },
                ),
                padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
              )
            ),
            GCWIconButton(
              iconData: Icons.settings,
              onPressed: () {
                Navigator.push(context, NoAnimationMaterialPageRoute(
                  builder: (context) => GCWTool(
                    tool: MultiDecoderConfiguration(),
                    toolName: i18n(context, 'multidecoder_configuration_title')
                  )
                ))
                .whenComplete(() {
                  setState(() {
                    _currentOutput = null;
                  });
                });
              },
            )
          ],
        ),
        _buildSubmitButton(),
        _currentOutput
      ],
    );
  }

  Widget _buildSubmitButton() {
    return GCWSubmitButton(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center (
                child: Container(
                  child: GCWAsyncExecuter(
                    isolatedFunction: calculateOutputAsync,
                    parameter: _buildJobData(),
                    onReady: (data) => _showOutput(data),
                    isOverlay: true,
                  ),
                  height: 220,
                  width: 150,
                ),
              );
            },
          );
        }
    );
  }

  _toolTitle(BuildContext context, GCWMultiDecoderTool tool) {
    var optionValues = tool.options.values.map((value) {
      var result = value;

      if (tool.internalToolName == MDT_INTERNALNAMES_COORDINATEFORMATS) {
        result = getCoordinateFormatByKey(value).name;
      }

      return i18n(context, result.toString()) ?? result;
    }).join(', ');

    var result = tool.name;
    if (optionValues != null && optionValues.length > 0)
      result += ' ($optionValues)';

    return result;
  }

  _initOutput() {
    _currentOutput = Column(
      children: _mdtTools.map((tool) {
        return GCWTextDivider(text: _toolTitle(context, tool));
      }).toList()
    );
  }

  Future<GCWAsyncExecuterParameters> _buildJobData() async {
    return GCWAsyncExecuterParameters(
        MultiDecoderJobData(
            mdtTools : _mdtTools,
            context: context,
            input: _currentInput
        )
    );
  }

  // void _calculateOutputAsync(dynamic jobData) async {
  //   var output = _calculateOutput(
  //       jobData.mdtTools,
  //       jobData.context,
  //       jobData.parameters.input
  //   );
  //
  //   jobData.sendAsyncPort.send(output);
  // }

  // _calculateOutput(List<GCWMultiDecoderTool> mdtTools, BuildContext context, String input) {
  //   var results = mdtTools.map((tool) {
  //     var result;
  //
  //     try {
  //       result = 'ww'; //tool.onDecode(input);
  //     } catch(e){}
  //
  //     if (result == null || result.toString().length == 0)
  //       return Container();
  //
  //     return GCWOutput(
  //       title: 'xx', //_toolTitle(context, tool),
  //       child: result,
  //     );
  //   }).toList();
  //
  //   return Column(
  //     children: results
  //   );
  // }

  _showOutput(Widget output) {
    _currentOutput = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}

// void _calculateOutputAsync1(dynamic jobData) async {
//   var output = _calculateOutput(
//       jobData.mdtTools,
//       jobData.context,
//       jobData.parameters.input
//   );
//
//   jobData.sendAsyncPort.send(output);
// }

// _calculateOutput(List<GCWMultiDecoderTool> mdtTools, BuildContext context, String input) {
//   var results = mdtTools.map((tool) {
//     var result;
//
//     try {
//       result = tool.onDecode(input);
//     } catch(e){}
//
//     if (result == null || result.toString().length == 0)
//       return Container();
//
//     return GCWOutput(
//       title: _toolTitle(context, tool),
//       child: result,
//     );
//   }).toList();
//
//   return Column(
//       children: results
//   );
// }

_toolTitle(BuildContext context, GCWMultiDecoderTool tool) {
  var optionValues = tool.options.values.map((value) {
    var result = value;

    if (tool.internalToolName == MDT_INTERNALNAMES_COORDINATEFORMATS) {
      result = getCoordinateFormatByKey(value).name;
    }

    return i18n(context, result.toString()) ?? result;
  }).join(', ');

  var result = tool.name;
  if (optionValues != null && optionValues.length > 0)
    result += ' ($optionValues)';

  return result;
}

