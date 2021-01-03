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

var _DEFAULT_RADIUS = 161.0;

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

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.mapPoint.markerText ?? '');

    if (widget.mapPoint.hasCircle()) {
      _currentRadius = widget.mapPoint.circle.radius;
    }
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
        GCWTextDivider(
          text: 'Marker Color'
        ),
        GCWColorRGB(
          color: RGB(
            widget.mapPoint.color.red.toDouble(),
            widget.mapPoint.color.green.toDouble(),
            widget.mapPoint.color.blue.toDouble()
          ),
          onChanged: (color) {
            setState(() {
              widget.mapPoint.color = Color.fromARGB(
                255,
                color.red.round(),
                color.green.round(),
                color.blue.round()
              );
            });
          },
        ),
        GCWTextDivider(
          text: 'Circle'
        ),
        GCWOnOffSwitch(
          title: 'Umkreis',
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
                  : GCWColorRGB(
                      color: RGB(
                        widget.mapPoint.circle.color.red.toDouble(),
                        widget.mapPoint.circle.color.green.toDouble(),
                        widget.mapPoint.circle.color.blue.toDouble()
                      ),
                      onChanged: (color) {
                        setState(() {
                          widget.mapPoint.circle.color = Color.fromARGB(
                            255,
                            color.red.round(),
                            color.green.round(),
                            color.blue.round()
                          );
                        });
                      },
                    ),
              ],
            )
            : Container(),
      ]
    );
  }
}