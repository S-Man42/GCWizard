import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/base/gcw_color_rgb.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_rgb.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/base/hsv_picker.dart';
import 'package:gc_wizard/logic/common/units/length.dart';

class GeodeticsEditor extends StatefulWidget {
  final dynamic geodetic;

  const GeodeticsEditor({
    Key key,
    this.geodetic
  }) : super(key: key);

  @override
  GeodeticsEditorState createState() => GeodeticsEditorState();
}

class GeodeticsEditorState extends State<GeodeticsEditor> {
  HSVColor _currentColorPickerColor;

  @override
  void initState() {
    super.initState();

    if (widget.geodetic is GCWMapGeodetic)
      _currentColorPickerColor = HSVColor.fromColor(widget.geodetic.color);
    if (widget.geodetic is GCWMapPolyGeodetics)
      _currentColorPickerColor = HSVColor.fromColor(widget.geodetic.color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWTextDivider(
          text: 'Line Color'
        ),
        Container(
          child: HSVPicker(
            color: _currentColorPickerColor,
            onChanged: (color) {
              setState(() {
                _currentColorPickerColor = color;

                if (widget.geodetic is GCWMapGeodetic)
                  widget.geodetic.color = _currentColorPickerColor.toColor();
                if (widget.geodetic is GCWMapPolyGeodetics)
                  widget.geodetic.color = _currentColorPickerColor.toColor();
              });
            },
          ),
          padding: EdgeInsets.only(
            bottom: 20.0
          ),
        )
      ]
    );
  }
}