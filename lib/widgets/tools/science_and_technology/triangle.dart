import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/triangle.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Triangle extends StatefulWidget {
  @override
  TriangleState createState() => TriangleState();
}

class TriangleState extends State<Triangle> {
  TextEditingController _AxController;
  TextEditingController _AyController;
  TextEditingController _BxController;
  TextEditingController _ByController;
  TextEditingController _CxController;
  TextEditingController _CyController;

  var _currentAxInput = '';
  var _currentAyInput = '';
  var _currentBxInput = '';
  var _currentByInput = '';
  var _currentCxInput = '';
  var _currentCyInput = '';

  @override
  void initState() {
    super.initState();
    _AxController = TextEditingController(text: _currentAxInput);
    _AyController = TextEditingController(text: _currentAyInput);
    _BxController = TextEditingController(text: _currentBxInput);
    _ByController = TextEditingController(text: _currentByInput);
    _CxController = TextEditingController(text: _currentCxInput);
    _CyController = TextEditingController(text: _currentCyInput);
  }

  @override
  void dispose() {
    _AxController.dispose();
    _AyController.dispose();
    _BxController.dispose();
    _ByController.dispose();
    _CxController.dispose();
    _CyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
                child: Container(
                  child: GCWText(
                    text: 'A',
                  ),
                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWTextField(
                    hintText: 'X',
                    controller: _AxController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),],
                    onChanged: (text) {
                      setState(() {
                        _currentAxInput = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWTextField(
                    hintText: 'Y',
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),],
                    controller: _AyController,
                    onChanged: (text) {
                      setState(() {
                        _currentAyInput = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN),
                )
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                  child: GCWText(
                    text: 'B',
                  ),
                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWTextField(
                    hintText: 'X',
                    controller: _BxController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),],
                    onChanged: (text) {
                      setState(() {
                        _currentBxInput = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWTextField(
                    hintText: 'Y',
                    controller: _ByController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),],
                    onChanged: (text) {
                      setState(() {
                        _currentByInput = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN),
                )
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                  child: GCWText(
                    text: 'C',
                  ),
                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWTextField(
                    hintText: 'X',
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),],
                    controller: _CxController,
                    onChanged: (text) {
                      setState(() {
                        _currentCxInput = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWTextField(
                    hintText: 'Y',
                    controller: _CyController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),],
                    onChanged: (text) {
                      setState(() {
                        _currentCyInput = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN),
                )
            ),
          ],
        ),
        GCWTextDivider(text: i18n(context, 'common_output')),
        _buildOutput(context)
      ]
    );
  }

  Widget _buildOutput(BuildContext context) {

    if (double.tryParse(_currentAxInput) != null &&
        double.tryParse(_currentAyInput) != null &&
        double.tryParse(_currentBxInput) != null &&
        double.tryParse(_currentByInput) != null &&
        double.tryParse(_currentCxInput) != null &&
        double.tryParse(_currentCyInput) != null) {

      XYZPoint A = XYZPoint(
          x: double.parse(_currentAxInput),
          y: double.parse(_currentAyInput),
          z: 0.0
      );
      XYZPoint B = XYZPoint(
          x: double.parse(_currentBxInput),
          y: double.parse(_currentByInput),
          z: 0.0
      );
      XYZPoint C = XYZPoint(
          x: double.parse(_currentCxInput),
          y: double.parse(_currentCyInput),
          z: 0.0
      );

      XYZPoint sides = triangleSides(A, B, C);
      XYZPoint angles = triangleAngles(A, B, C);
      XYZPoint centroid = triangleCentroid(A, B, C);
      XYZPoint altitude = triangleAltitude(A, B, C);
      XYZCircle innercircle = triangleInnerCircle(A, B, C);
      XYZCircle outercircle = triangleOuterCircle(A, B, C);

      var output = [
        [i18n(context, 'triangle_output_sides'),
          sides.x.toStringAsFixed(3),
          sides.y.toStringAsFixed(3),
          sides.z.toStringAsFixed(3)],
        [i18n(context, 'triangle_output_angles'),
          angles.x.toStringAsFixed(3),
          angles.y.toStringAsFixed(3),
          angles.z.toStringAsFixed(3)],
        [i18n(context, 'triangle_output_circumference'), triangleCircumference(A, B, C).toStringAsFixed(3), null, null],
        [i18n(context, 'triangle_output_area'), triangleArea(A, B, C).toStringAsFixed(3), null, null],
        [i18n(context, 'triangle_output_points'), null, null, null],
        [i18n(context, 'triangle_output_centroid'),
          centroid.x.toStringAsFixed(3),
          centroid.y.toStringAsFixed(3),
          null],
        [i18n(context, 'triangle_output_altitude'),
          altitude.x.toStringAsFixed(3),
          altitude.y.toStringAsFixed(3),
          null],
        [i18n(context, 'triangle_output_innercircle'),
          innercircle.x.toStringAsFixed(3),
          innercircle.y.toStringAsFixed(3),
          innercircle.r.toStringAsFixed(3),],
        [i18n(context, 'triangle_output_outercircle'),
          outercircle.x.toStringAsFixed(3),
          outercircle.y.toStringAsFixed(3),
          outercircle.r.toStringAsFixed(3),],
      ];
      return Column(
          children: columnedMultiLineOutput(context, output),
      );
    } else
      return GCWOutputText(
        text: i18n(context, 'triangle_hint_data_missing'),
      );
  }
}
