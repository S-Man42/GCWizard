import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'l1': false, 'l4': false, 'l2': false, 'l5': false, 'l3': false, 'r1': false, 'r4': false, 'r2': false, 'r5': false, '3r': false};

const _SEMAPHORE_RELATIVE_DISPLAY_WIDTH = 50;
const _SEMAPHORE_RELATIVE_DISPLAY_HEIGHT = 100;
const _SEMAPHORE_RADIUS = 10.0;

class SemaphoreSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  SemaphoreSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
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

        var shutters = {
          '1': [ 5, 20],
          '2': [25, 20],
          '3': [ 5, 50],
          '4': [25, 50],
          '5': [ 5, 80],
          '6': [25, 80]
        };

        shutters.forEach((key, value) {
          paint.color = currentSegments[key] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

          var pointSize = size.height / _SEMAPHORE_RELATIVE_DISPLAY_HEIGHT * _SEMAPHORE_RADIUS;

          canvas.touchCanvas.drawRect(
              Offset(size.width / _SEMAPHORE_RELATIVE_DISPLAY_WIDTH * value[0],
                  size.height / _SEMAPHORE_RELATIVE_DISPLAY_HEIGHT * value[1]) &
              Size(pointSize * 3, pointSize * 2),
              paint, onTapDown: (tapDetail) {
            setSegmentState(key, !currentSegments[key]);
          });

          if (size.height < 50)
            return;

        });

      });
}
