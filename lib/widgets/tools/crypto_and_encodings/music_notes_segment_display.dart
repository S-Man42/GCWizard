import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'l1': false,
  'l2': false,
  'l3': false,
  'l4': false,
  'l5': false,
  'r1': false,
  'r2': false,
  'r3': false,
  'r4': false,
  'r5': false
};

const _NOTES_RELATIVE_DISPLAY_WIDTH = 360; //110;
const _NOTES_RELATIVE_DISPLAY_HEIGHT = 360; //100;

class NotesSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;
  final bool tapeStyle;

  NotesSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged, this.tapeStyle: false})
      : super(
            key: key,
            initialSegments: _INITIAL_SEGMENTS,
            segments: segments,
            readOnly: readOnly,
            onChanged: onChanged,
            type: SegmentDisplayType.CUSTOM,
            customPaint: (GCWTouchCanvas canvas, Size size, Map<String, bool> currentSegments, Function setSegmentState,
                Color segment_color_on, Color segment_color_off) {
              var paint = defaultSegmentPaint();
              var SEGMENTS_COLOR_ON = segment_color_on;
              var SEGMENTS_COLOR_OFF = segment_color_off;
              var LINE_OFFSET = 10;
              var LINE_DISTANCE = 20;
              var NOTE_X1 = 120;
              var NOTE_X2 = 150;


              paint.color = Colors.grey;

              var pathL = Path();
              pathL.addPath(_createLine(true, size), Offset(0, 0 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(true, size), Offset(0, 1 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(true, size), Offset(0, 2 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(false, size), Offset(0, 3 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(false, size), Offset(0, 4 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(false, size), Offset(0, 5 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(false, size), Offset(0, 6 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(false, size), Offset(0, 7 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(true, size), Offset(0, 8 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(true, size), Offset(0, 9 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createLine(true, size), Offset(0, 10 * LINE_DISTANCE + LINE_OFFSET));

              canvas.touchCanvas.drawPath(pathL, paint);

              pathL = Path();
              pathL.addPath(_createHash(size), Offset(70, 50));
              pathL.addPath(_createNote(size), Offset(NOTE_X1, 7 * LINE_DISTANCE + LINE_OFFSET));
              pathL.addPath(_createNote(size), Offset(NOTE_X1, 9 * LINE_DISTANCE + LINE_OFFSET/2));
              pathL.addPath(_createNote(size), Offset(NOTE_X2, 1 * LINE_DISTANCE + LINE_OFFSET));

              paint.color = currentSegments['l1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF; //SEGMENTS_COLOR_OFF
              canvas.touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
                setSegmentState('r1', !currentSegments['r1']);
                if (currentSegments['r1']) {
                  setSegmentState('r2', false);
                  setSegmentState('r3', false);
                  setSegmentState('r4', false);
                  setSegmentState('r5', false);
                }
              });
            });
  
  static resetOtherNotes(string allowedNote) {
    for (var i = 1; i<= 5; i++) {
      setSegmentState(i.toString(), false);
      setSegmentState(i.toString() & 's', false);
      setSegmentState('-' & i.toString(), false);
      setSegmentState('-' & i.toString() & 's', false);
      setSegmentState(i.toString() & 'h', false);
      setSegmentState(i.toString() & 's', false);
      setSegmentState('-' & i.toString() & 'h', false);
      setSegmentState('-' & i.toString() & 's', false);
    }
  }

  static Path _createLine(bool shortLine, Size size) {
    var path = Path();
    if (shortLine) {
      var rect = Rect.fromCenter(
          center: Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 180, 0.0),
          width: 40,
          height: 2);
      path.addRect(rect);
    } else {
      var rect = Rect.fromCenter(
          center: Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 180, 0.0),
          width: _NOTES_RELATIVE_DISPLAY_WIDTH.toDouble(),
          height: 2);
      path.addRect(rect);
    }
    return path;
  }

  static Path _createNote(Size size) {
    var path = Path();
    var rect = Rect.fromCenter(center: Offset(0.0, 0.0),
               width:  size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 50,
               height: size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 30);
    path.addOval(rect);

    return path;
  }

  static Path _createHash(Size size) {
    const innerSize = 30.0;
    const overLength = 10.0;
    const angle = 10.0;
    const width = 4.0;

    var path = Path();
    var rect = Rect.fromCenter(center: Offset(-innerSize/2, width/2),
        width:  width,
        height: innerSize);
    path.addRect(rect);
    rect = Rect.fromCenter(center: Offset(innerSize/2, - width/2),
        width:  width,
        height: innerSize);
    path.addRect(rect);

    path.moveTo(-(innerSize/2 + overLength), -(innerSize/2 - angle));
    path.lineTo((innerSize/2 + overLength), -innerSize/2);
    path.lineTo((innerSize/2 + overLength), -innerSize/2 + width);
    path.lineTo(-(innerSize/2 + overLength), -(innerSize/2 - angle) + width);
    path.close();

    path.moveTo(-(innerSize/2 + overLength), innerSize/2);
    path.lineTo((innerSize/2 + overLength), (innerSize/2 - angle));
    path.lineTo((innerSize/2 + overLength), (innerSize/2 - angle) - width);
    path.lineTo(-(innerSize/2 + overLength), innerSize/2 - width);
    path.close();

    return path;
  }
}
