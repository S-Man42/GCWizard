import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'a1': false, 'a2': false, 'a3': false, 'a4': false, 'b1': false, 'b2': false, 'b3': false, 'b4': false, 'c1': false, 'c2': false, 'c3': false, 'c4': false};

const _OHLSEN_RELATIVE_DISPLAY_WIDTH = 150;
const _OHLSEN_RELATIVE_DISPLAY_HEIGHT = 150;
const _OHLSEN_RADIUS = 10.0;

class OhlsenSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  OhlsenSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
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

        var shutterSegments = {
           '1': 'a1',
           '2': 'a2',
           '3': 'a3',
           '4': 'a4',
           '5': 'b1',
           '6': 'b2',
           '7': 'b3',
           '8': 'b4',
           '9': 'c1',
          '10': 'c2',
          '11': 'c3',
          '12': 'c4',
        };
        var shutters = {
           '1': [ 10,  40],
           '2': [ 10,  63],
           '3': [ 10, 100],
           '4': [ 10, 123],
           '5': [ 50,  40],
           '6': [ 50,  63],
           '7': [ 50, 100],
           '8': [ 50, 123],
           '9': [ 90,  40],
          '10': [ 90,  63],
          '11': [ 90, 100],
          '12': [ 90, 123],
        };
        var pointSize = size.height / _OHLSEN_RELATIVE_DISPLAY_HEIGHT * _OHLSEN_RADIUS;

        shutters.forEach((key, value) {
          canvas.touchCanvas.drawRect(
              Offset(size.width / _OHLSEN_RELATIVE_DISPLAY_WIDTH * (value[0] - 1),
                  size.height / _OHLSEN_RELATIVE_DISPLAY_HEIGHT * (value[1]) - 1) &
              Size(pointSize * 3 + 4, pointSize * 2 + 2),
              paint);

          if (size.height < 50)
            return;
        });

        shutters.forEach((key, value) {
          paint.color = currentSegments[shutterSegments[key]] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
          canvas.touchCanvas.drawRect(
              Offset(size.width / _OHLSEN_RELATIVE_DISPLAY_WIDTH * value[0],
                  size.height / _OHLSEN_RELATIVE_DISPLAY_HEIGHT * value[1]) &
              Size(pointSize * 3, pointSize * 2),
              paint, onTapDown: (tapDetail) {
                setSegmentState(shutterSegments[key], !currentSegments[shutterSegments[key]]);
              }
          );

          if (size.height < 50)
            return;
        });

      });
}
