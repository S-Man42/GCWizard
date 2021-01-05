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
import 'dart:math';

double _DEFAULT_RADIUS = 161.0;

class MapPointEditor extends StatefulWidget {
  final GCWMapPoint mapPoint;

  const MapPointEditor({
    Key key,
    this.mapPoint
  }) : super(key: key);

  @override
  MapPointEditorState createState() => MapPointEditorState();
}

class MapPointEditorState extends State<MapPointEditor> {
  var _nameController;

  var _currentRadius = _DEFAULT_RADIUS;
  HSVColor _currentMarkerColorPickerColor;
  HSVColor _currentCircleColorPickerColor;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.mapPoint.markerText ?? '');

    if (widget.mapPoint.hasCircle()) {
      _currentRadius = widget.mapPoint.circle.radius;
    }

    _currentMarkerColorPickerColor = HSVColor.fromColor(widget.mapPoint.color);
    if (widget.mapPoint.hasCircle() && !widget.mapPoint.circleColorSameAsPointColor)
      _currentCircleColorPickerColor = HSVColor.fromColor(widget.mapPoint.circle.color);
    else
      _currentCircleColorPickerColor = HSVColor.fromColor(widget.mapPoint.color);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWTextDivider(
          text: 'Marker'
        ),
        GCWTextField(
          hintText: 'Enter Markertext',
          controller: _nameController,
          onChanged: (text) {
            widget.mapPoint.markerText = text;
            widget.mapPoint.update();
          },
        ),
        GCWCoords(
          title: 'Coordinate',
          coordinates: widget.mapPoint.point,
          coordsFormat: widget.mapPoint.coordinateFormat,
          onChanged: (ret) {
            setState(() {
              widget.mapPoint.coordinateFormat = ret['coordsFormat'];
              widget.mapPoint.point = ret['value'];
            });
          },
        ),
        GCWTextDivider(
          text: 'Marker Color'
        ),
        Container(
          child: HSVPicker(
            color: _currentMarkerColorPickerColor,
            onChanged: (color) {
              setState(() {
                _currentMarkerColorPickerColor = color;
                widget.mapPoint.color = _currentMarkerColorPickerColor.toColor();
              });
            },
          ),
          padding: EdgeInsets.only(
            bottom: 20.0
          ),
        ),
        GCWTextDivider(
          text: 'Circle'
        ),
        GCWOnOffSwitch(
          title: 'Has Circle',
          value: widget.mapPoint.hasCircle(),
          onChanged: (value) {
            setState(() {
              if (value) {
                widget.mapPoint.circle = GCWMapCircle(
                  radius: _currentRadius,
                );
              } else {
                widget.mapPoint.circle = null;
              }

              widget.mapPoint.update();
            });
          },
        ),
        widget.mapPoint.hasCircle()
          ? Column(
              children: [
                GCWDistance(
                  value: widget.mapPoint.circle.radius,
                  onChanged: (value) {
                    _currentRadius = value;
                    widget.mapPoint.circle.radius = _currentRadius;
                    widget.mapPoint.update();
                  },
                ),
                GCWOnOffSwitch(
                  title: 'Circle same Color as Marker',
                  value: widget.mapPoint.circleColorSameAsPointColor,
                  onChanged: (value) {
                    setState(() {
                      widget.mapPoint.circleColorSameAsPointColor = value;
                      widget.mapPoint.update();
                    });
                  },
                ),
                widget.mapPoint.circleColorSameAsPointColor ? Container()
                  : Container(
                      child: HSVPicker(
                        color: _currentCircleColorPickerColor,
                        onChanged: (color) {
                          setState(() {
                            _currentCircleColorPickerColor = color;
                            widget.mapPoint.circle.color = _currentCircleColorPickerColor.toColor();
                          });
                        },
                      ),
                      padding: EdgeInsets.only(
                        bottom: 20.0
                      ),
                    ),
              ],
            )
            : Container(),
      ]
    );
  }
}