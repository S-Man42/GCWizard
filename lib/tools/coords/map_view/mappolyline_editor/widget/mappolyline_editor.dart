import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/common/gcw_colorpicker/widget/gcw_colorpicker.dart';
import 'package:gc_wizard/tools/common/gcw_text_divider/widget/gcw_text_divider.dart';
import 'package:gc_wizard/tools/coords/map_view/gcw_map_geometries/widget/gcw_map_geometries.dart';

class MapPolylineEditor extends StatefulWidget {
  final dynamic polyline;

  const MapPolylineEditor({Key key, this.polyline}) : super(key: key);

  @override
  MapPolylineEditorState createState() => MapPolylineEditorState();
}

class MapPolylineEditorState extends State<MapPolylineEditor> {
  HSVColor _currentColorPickerColor;

  @override
  void initState() {
    super.initState();

    if (widget.polyline is GCWMapPolyline) _currentColorPickerColor = HSVColor.fromColor(widget.polyline.color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GCWTextDivider(text: i18n(context, 'coords_openmap_lineeditor_line_color')),
      Container(
        child: GCWColorPicker(
          hsvColor: _currentColorPickerColor,
          onChanged: (color) {
            setState(() {
              _currentColorPickerColor = color;

              if (widget.polyline is GCWMapPolyline) widget.polyline.color = _currentColorPickerColor.toColor();
            });
          },
        ),
        padding: EdgeInsets.only(bottom: 20.0),
      )
    ]);
  }
}
