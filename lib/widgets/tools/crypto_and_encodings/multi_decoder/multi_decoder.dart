import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/multi_decoder_configuration.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/persistence/multi_decoder/json_provider.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/persistence/multi_decoder/json_provider.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tools.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class MultiDecoder extends StatefulWidget {
  @override
  MultiDecoderState createState() => MultiDecoderState();
}

class MultiDecoderState extends State<MultiDecoder> {
  var _controller;
  List<GCWMultiDecoderTool> mdtTools;

  String _currentInput = '';

  Widget _currentOutput;

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
      return multiDecoderToolToGCWMultiDecoderTool(mdtTool);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                    toolName: 'Config'
                  )
                ));
              },
            )
          ],
        ),
        GCWButton(
          text: 'Calc',
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

  _initOutput() {
    _currentOutput = Column(
      children: mdtTools.map((tool) {
        return GCWTextDivider(text: tool.name);
      }).toList()
    );
  }

  _calculateOutput() {
    var results = mdtTools.map((tool) {
      try {
        var result = tool.onDecode(_currentInput);
        if (result == null || result.length == 0)
          result = 'ZONK';

        return GCWOutput(
          title: tool.name,
          child: result,
        );
      } catch(e) {}
    }).toList();

    _currentOutput = Column(
      children: results
    );
  }
}