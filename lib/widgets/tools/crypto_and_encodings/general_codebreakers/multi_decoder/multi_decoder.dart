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
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder_configuration.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_coordinate_formats.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tools.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class MultiDecoder extends StatefulWidget {
  @override
  MultiDecoderState createState() => MultiDecoderState();
}

class MultiDecoderState extends State<MultiDecoder> {
  var _controller;
  List<GCWMultiDecoderTool> mdtTools;

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
    mdtTools = multiDecoderTools.map((mdtTool) {
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
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        _currentOutput
      ],
    );
  }

  _toolTitle(GCWMultiDecoderTool tool) {
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
        children: mdtTools.map((tool) {
          return GCWTextDivider(text: _toolTitle(tool));
        }).toList()
    );
  }

  _calculateOutput() {
    var results = mdtTools.map((tool) {
      var result;

      try {
        result = tool.onDecode(_currentInput);
      } catch(e){}

      if (result == null || result.toString().length == 0)
        return Container();

      return GCWOutput(
        title: _toolTitle(tool),
        child: result,
      );
    }).toList();

    _currentOutput = Column(
        children: results
    );
  }
}