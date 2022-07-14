import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_rgb.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/ral_color_codes.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/color_tool.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

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
