import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/base/hsv_picker.dart';

class MapPolylineEditor extends StatefulWidget {
  final dynamic geodetic;

  const MapPolylineEditor({
    Key key,
    this.geodetic
  }) : super(key: key);

  @override
  MapPolylineEditorState createState() => MapPolylineEditorState();
}

class MapPolylineEditorState extends State<MapPolylineEditor> {
  HSVColor _currentColorPickerColor;

  @override
  void initState() {
    super.initState();

    if (widget.geodetic is GCWMapPolyline)
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

                if (widget.geodetic is GCWMapPolyline)
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