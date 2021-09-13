import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'1': false, '4': false, '2': false, '5': false, '3': false, '6': false};

const _MURRAY_RELATIVE_DISPLAY_WIDTH = 50;
const _MURRAY_RELATIVE_DISPLAY_HEIGHT = 100;
const _MURRAY_RADIUS = 10.0;

class MurraySegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  MurraySegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
      : super(
      key: key,
      initialSegments: _INITIAL_SEGMENTS,
      segments: segments,
      readOnly: readOnly,
      onChanged: onChanged,
      type: SegmentDisplayType.CUSTOM,
      customPaint: (GCWTouchCanvas canvas, Size size, Map<String, bool> currentSegments, Function setSegmentState, Color segment_color_on, Color segment_color_off) {
        var paint = defaultSegmentPaint();
        var SEGMENTS_COLOR_ON = segment_color_on;
        var SEGMENTS_COLOR_OFF = segment_color_off;

        var circles = {
          '1': [15, 20],
          '2': [35, 20],
          '3': [15, 50],
          '4': [35, 50],
          '5': [15, 80],
          '6': [35, 80]
        };

        circles.forEach((key, value) {
          paint.color = currentSegments[key] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

          var pointSize = size.height / _MURRAY_RELATIVE_DISPLAY_HEIGHT * _MURRAY_RADIUS;

          canvas.touchCanvas.drawCircle(
              Offset(size.width / _MURRAY_RELATIVE_DISPLAY_WIDTH * value[0],
                  size.height / _MURRAY_RELATIVE_DISPLAY_HEIGHT * value[1]),
              pointSize,
              paint, onTapDown: (tapDetail) {
            setSegmentState(key, !currentSegments[key]);
          });

          if (size.height < 50)
            return;

        });

      });
}
