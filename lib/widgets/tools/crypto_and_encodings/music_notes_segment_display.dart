import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/music_notes.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  bLabel: false,
  hashLabel: false,
  '5h': false,
  '4hs': false,
  '4h': false,
  '3hs': false,
  '3h': false,
  '2hs': false,
  '2h': false,
  '1hs': false,
  '1h': false,
  '5s': false,
  '5': false,
  '4s': false,
  '4': false,
  '3s': false,
  '3': false,
  '2s': false,
  '2': false,
  '1s': false,
  '1': false,
  '-1hs': false,
  '-1h': false,
  '-2hs': false,
  '-2h': false,
  '-3hs': false,
  '-3h': false,
  '-4hs': false,
  '-4h': false,
  '-5hs': false,

    h1: true,
    h2: true,
    h3: true,
    h4: true,
    h5: true,
    nh1: true,
    nh2: true,
    nh3: true,
    nh4: true,
};

const _NOTES_RELATIVE_DISPLAY_WIDTH = 360;
const _NOTES_RELATIVE_DISPLAY_HEIGHT = 430;
const _NOTES_RELATIVE_DISPLAY_SHOW_LEVEL = 180;

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
              var LINE_OFFSET = size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 10.0;
              var LINE_DISTANCE = size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 30.0;
              var NOTE_X1 = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH *
                  ((size.height >= _NOTES_RELATIVE_DISPLAY_SHOW_LEVEL) ? (90 - 25) : 90);
              var NOTE_X2 = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH *
                  ((size.height >= _NOTES_RELATIVE_DISPLAY_SHOW_LEVEL) ? (90 + 25) : 90);

              paint.color = Colors.grey;
              //print('paint segments: ' + currentSegments.toString() + " size: " + size.toString());

              var pathL = Path();
              if (currentSegments[h5])
                pathL.addPath(_createLine(true, size, Offset(0, 0 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[h4])
                pathL.addPath(_createLine(true, size, Offset(0, 1 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[h3])
                pathL.addPath(_createLine(true, size, Offset(0, 2 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[h2])
                pathL.addPath(_createLine(true, size, Offset(0, 3 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[h1])
                pathL.addPath(_createLine(true, size, Offset(0, 4 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              pathL.addPath(_createLine(false, size, Offset(0, 5 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              pathL.addPath(_createLine(false, size, Offset(0, 6 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              pathL.addPath(_createLine(false, size, Offset(0, 7 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              pathL.addPath(_createLine(false, size, Offset(0, 8 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              pathL.addPath(_createLine(false, size, Offset(0, 9 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[nh1])
                pathL.addPath(_createLine(true, size, Offset(0, 10 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[nh2])
                pathL.addPath(_createLine(true, size, Offset(0, 11 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[nh3])
                pathL.addPath(_createLine(true, size, Offset(0, 12 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));
              if (currentSegments[nh4])
                pathL.addPath(_createLine(true, size, Offset(0, 13 * LINE_DISTANCE + LINE_OFFSET)), Offset(0, 0));

              canvas.touchCanvas.drawPath(pathL, paint);

              var active = currentSegments[hashLabel];
              if (active || (size.height >= _NOTES_RELATIVE_DISPLAY_SHOW_LEVEL)) {
                pathL = _createHash(size, Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 20.0, 6 * LINE_DISTANCE + LINE_OFFSET));
                paint.color = active ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

                canvas.touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
                  setSegmentState(hashLabel, !currentSegments[hashLabel]);
                  if (currentSegments[hashLabel]) setSegmentState(bLabel, false);
                });
              }

              active = currentSegments[bLabel];
              if (active || (size.height >= _NOTES_RELATIVE_DISPLAY_SHOW_LEVEL)) {
                pathL = _createB(size, Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 20.0, 10 * LINE_DISTANCE + LINE_OFFSET));
                paint.color = active ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

                canvas.touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
                  setSegmentState(bLabel, !currentSegments[bLabel]);
                  if (currentSegments[bLabel]) setSegmentState(hashLabel, false);
                });
              }

              _drawNote('5h', _createNote(size, Offset(NOTE_X1, 0 * LINE_DISTANCE + LINE_OFFSET)),
                   size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('4hs', _createNote(size, Offset(NOTE_X2, 0.5 * LINE_DISTANCE + LINE_OFFSET)),
                   size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('4h', _createNote(size, Offset(NOTE_X1, 1 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('3hs', _createNote(size, Offset(NOTE_X2, 1.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('3h', _createNote(size, Offset(NOTE_X1, 2 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('2hs', _createNote(size, Offset(NOTE_X2, 2.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('2h', _createNote(size, Offset(NOTE_X1, 3 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('1hs', _createNote(size, Offset(NOTE_X2, 3.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('1h', _createNote(size, Offset(NOTE_X1, 4 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('5s', _createNote(size, Offset(NOTE_X2, 4.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('5', _createNote(size, Offset(NOTE_X1, 5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('4s', _createNote(size, Offset(NOTE_X2, 5.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('4', _createNote(size, Offset(NOTE_X1, 6 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('3s', _createNote(size, Offset(NOTE_X2, 6.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('3', _createNote(size, Offset(NOTE_X1, 7 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('2s', _createNote(size, Offset(NOTE_X2, 7.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('2', _createNote(size, Offset(NOTE_X1, 8 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('1s', _createNote(size, Offset(NOTE_X2, 8.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('1', _createNote(size, Offset(NOTE_X1, 9 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-1hs', _createNote(size, Offset(NOTE_X2, 9.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-1h', _createNote(size, Offset(NOTE_X1, 10 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-2hs', _createNote(size, Offset(NOTE_X2, 10.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-2h', _createNote(size, Offset(NOTE_X1, 11 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-3hs', _createNote(size, Offset(NOTE_X2, 11.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-3h', _createNote(size, Offset(NOTE_X1, 12 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-4hs', _createNote(size, Offset(NOTE_X2, 12.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-4h', _createNote(size, Offset(NOTE_X1, 13 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
              _drawNote('-5hs', _createNote(size, Offset(NOTE_X2, 13.5 * LINE_DISTANCE + LINE_OFFSET)),
                  size, canvas, paint, currentSegments, setSegmentState);
            });

  static _drawNote(String note, Path path, Size size, GCWTouchCanvas canvas, Paint paint,
      Map<String, bool> currentSegments, Function setSegmentState) {
    var active = currentSegments[note];
    paint.color = active ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    if (active || (size.height >= _NOTES_RELATIVE_DISPLAY_SHOW_LEVEL))
      canvas.touchCanvas.drawPath(path, paint, onTapDown: (tapDetail) {
        _setNotesState(note, currentSegments, setSegmentState);
      });
  }

  static _setNotesState(String tappedNote, Map<String, bool> currentSegments, Function setSegmentState) {
    var newState  = !currentSegments[tappedNote];
    if (newState) {
      for (var i = 1; i <= 5; i++) {
        setSegmentState(i.toString(), false);
        setSegmentState(i.toString() + 's', false);
        setSegmentState('-' + i.toString(), false);
        setSegmentState('-' + i.toString() + 's', false);
        setSegmentState(i.toString() + 'h', false);
        setSegmentState(i.toString() + 'hs', false);
        setSegmentState('-' + i.toString() + 'h', false);
        setSegmentState('-' + i.toString() + 'hs', false);
      }
    }
    setSegmentState(tappedNote, newState);
  }

  static Path _createLine(bool shortLine, Size size, Offset offset) {
    var path = Path();
    if (shortLine) {
      var rect = Rect.fromCenter(
          center: Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 180, 0.0),
          width: size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 60,
          height: max(1.0, size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 2));
      path.addRect(rect);
    } else {
      var rect = Rect.fromCenter(
          center: Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 180, 0.0),
          width: size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 80,
          height: max(1.0, size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 2));
      path.addRect(rect);
    }
    path = path.shift(offset);
    return path;
  }

  static Path _createNote(Size size, Offset offset) {
    var path = Path();
    var rect = Rect.fromCenter(center: offset,
               width:  max(3, size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 50),
               height: max(2, size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 30));
    path.addOval(rect);

    return path;
  }

  static Path _createHash(Size size, Offset offset) {
    var outerSize = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 35.0;
    var overLength = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 4.0;
    var overLengthCorr = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 3.0;
    var angle = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 10.0;
    var width = max(1.0, size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 4.0);

    var path = Path();
    var rect = Rect.fromCenter(center: Offset(-outerSize/2 + 2  + overLength, angle/2),
        width:  width,
        height: outerSize);
    path.addRect(rect);
    rect = Rect.fromCenter(center: Offset(outerSize/2 - 2 - overLength, - angle/2),
        width:  width,
        height: outerSize);
    path.addRect(rect);

    var pathL = Path();
    pathL.moveTo(-(outerSize/2 + overLength),  (overLengthCorr + angle/2) - width/2);
    pathL.lineTo( (outerSize/2 + overLength), -(overLengthCorr + angle/2) - width/2);
    pathL.lineTo( (outerSize/2 + overLength), -(overLengthCorr + angle/2) + width/2);
    pathL.lineTo(-(outerSize/2 + overLength),  (overLengthCorr + angle/2) + width/2);
    pathL.close();
    path.addPath(pathL, Offset(0, -outerSize/2 + overLength + 3));
    path.addPath(pathL, Offset(0,  outerSize/2 - overLength - 4));

    path = path.shift(offset);
    return path;
  }

  static Path _createB(Size size, Offset offset) {
    var outerSize = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 35.0;
    var overLength = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 4.0;
    var overLengthCorr = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 3.0;
    var angle = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 10.0;
    var width = max(1.0, size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 4.0);

    var path = Path();
    var rect = Rect.fromCenter(center: Offset(-outerSize/2 + 2  + overLength, angle/2),
        width:  width,
        height: outerSize);
    path.addRect(rect);
    rect = Rect.fromCenter(center: Offset(outerSize/2 - 2 - overLength, - angle/2),
        width:  width,
        height: outerSize);
    path.addRect(rect);

    var pathL = Path();
    pathL.moveTo(-(outerSize/2 + overLength),  (overLengthCorr + angle/2) - width/2);
    pathL.lineTo( (outerSize/2 + overLength), -(overLengthCorr + angle/2) - width/2);
    pathL.lineTo( (outerSize/2 + overLength), -(overLengthCorr + angle/2) + width/2);
    pathL.lineTo(-(outerSize/2 + overLength),  (overLengthCorr + angle/2) + width/2);
    pathL.close();
    path.addPath(pathL, Offset(0, -outerSize/2 + overLength + 3));
    path.addPath(pathL, Offset(0,  outerSize/2 - overLength - 4));

    path = path.shift(offset);
    return path;
  }
}
