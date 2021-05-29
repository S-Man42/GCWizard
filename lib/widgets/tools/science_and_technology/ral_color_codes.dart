import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_rgb.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/ral_color_codes.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_only01andspace_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_onlydigitsandspace_textinputformatter.dart';

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

    _colors = RAL_COLOR_CODES.map((key, value) {
      var val = Map<String, String>.from(value);
      val.putIfAbsent('key', () => key);

      return MapEntry(key, val);
    }).values.toList();

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
              return GCWDropDownMenuItem(
                  value: color,
                  child: color['key']
              );
            }).toList()),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var color = HexCode(_currentValue['colorcode']).toRGB();
    var children = columnedMultiLineOutput(context, [
      ['Name', _currentValue['name']],
      ['Hex Color Code', _currentValue['colorcode']],
    ]);

    print(color);

    children.add(
        Container(
          margin: EdgeInsets.only(top: 10 * DEFAULT_MARGIN),
          height: 200,
          width: 400,
          color: Color.fromRGBO(
              color.red.round(), color.green.round(), color.blue.round(), 1.0),
        )
    );

    return Column(
        children: children
    );
  }
}