import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_rgb.dart';
import 'package:gc_wizard/tools/science_and_technology/ral_color_codes/logic/ral_color_codes.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/tools/common/base/gcw_button/widget/gcw_button.dart';
import 'package:gc_wizard/tools/common/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';
import 'package:gc_wizard/tools/common/base/gcw_output_text/widget/gcw_output_text.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/common/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/color_tool/widget/color_tool.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';
import 'package:gc_wizard/tools/utils/no_animation_material_page_route/widget/no_animation_material_page_route.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/text_only01andspace_textinputformatter/widget/text_only01andspace_textinputformatter.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/text_onlydigitsandspace_textinputformatter/widget/text_onlydigitsandspace_textinputformatter.dart';

class RALColorCodes extends StatefulWidget {
  @override
  RALColorCodesState createState() => RALColorCodesState();
}

class RALColorCodesState extends State<RALColorCodes> {
  var _currentValue;
  List<Map<String, String>> _colors;

  @override
  void initState() {
    super.initState();

    _colors = RAL_COLOR_CODES
        .map((key, value) {
          var val = Map<String, String>.from(value);
          val.putIfAbsent('key', () => key);

          return MapEntry(key, val);
        })
        .values
        .toList();

    _colors.sort((a, b) => a['key'].compareTo(b['key']));
    _currentValue = _colors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDownButton(
            value: _currentValue,
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
              });
            },
            items: _colors.map((color) {
              return GCWDropDownMenuItem(value: color, child: color['key']);
            }).toList()),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var rgbColor = HexCode(_currentValue['colorcode']).toRGB();

    var name = _currentValue['name'];
    if (name == null || name.isEmpty) name = 'common_unknown';

    var children = columnedMultiLineOutput(context, [
      ['Name', i18n(context, name)],
      ['Hex Color Code', _currentValue['colorcode']],
    ]);

    children.add(Container(
      margin: EdgeInsets.only(top: 10 * DEFAULT_MARGIN),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: themeColors().mainFont(), width: 2),
        shape: BoxShape.rectangle,
        color: Color.fromRGBO(rgbColor.red.round(), rgbColor.green.round(), rgbColor.blue.round(), 1.0),
      ),
    ));

    children.add(GCWButton(
      text: i18n(context, 'ralcolorcodes_showincolorpicker'),
      onPressed: () => _showElement(rgbColor),
    ));

    return Column(children: children);
  }

  _showElement(RGB color) {
    Navigator.of(context).push(NoAnimationMaterialPageRoute(
        builder: (context) => GCWTool(tool: ColorTool(color: color), i18nPrefix: 'colors')));
  }
}
