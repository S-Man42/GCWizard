import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/music_notes.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

final _INITIAL_SEGMENTS = <String, bool>{
  bLabel: false,
  hashLabel: false,
  notePosition[0]: false,
  notePosition[1]: false,
  notePosition[2]: false,
  notePosition[3]: false,
  notePosition[4]: false,
  notePosition[5]: false,
  notePosition[6]: false,
  notePosition[7]: false,
  notePosition[8]: false,
  notePosition[9]: false,
  notePosition[10]: false,
  notePosition[11]: false,
  notePosition[12]: false,
  notePosition[13]: false,
  notePosition[14]: false,
  notePosition[15]: false,
  notePosition[16]: false,
  notePosition[17]: false,
  notePosition[18]: false,
  notePosition[19]: false,
  notePosition[20]: false,
  notePosition[21]: false,
  notePosition[22]: false,
  notePosition[23]: false,
  notePosition[24]: false,
  notePosition[25]: false,
  notePosition[26]: false,
  notePosition[27]: false,

  helpLine1: true,
  helpLine2: true,
  helpLine3: true,
  helpLine4: true,
  helpLine5: true,
  helpLineN1: true,
  helpLineN2: true,
  helpLineN3: true,
  helpLineN4: true,
};

const _NOTES_RELATIVE_DISPLAY_WIDTH = 380;
const _NOTES_RELATIVE_DISPLAY_HEIGHT = 445;


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
              var LINE_OFFSET_X = size.width  / _NOTES_RELATIVE_DISPLAY_WIDTH  * 50.0;
              var LINE_OFFSET_Y = size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 20.0;
              var LINE_DISTANCE = size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 30.0;

              var lines = [helpLine5, helpLine4, helpLine3, helpLine2, helpLine1, '', '', '', '', '', helpLineN1, helpLineN2, helpLineN3, helpLineN4];
              var pathL = Path();
              var counter = 0;
              paint.color = Colors.grey;
              lines.forEach((key) {
                if (key == '' || currentSegments[key])
                  pathL.addPath(_createLine(key != '', size,
                      Offset(0, counter * LINE_DISTANCE + LINE_OFFSET_Y), LINE_OFFSET_X, readOnly), Offset(0, 0));
                counter++;
              });
              canvas.touchCanvas.drawPath(pathL, paint);

              if (!readOnly || (readOnly && !_noteSelected(currentSegments))) {
                // if readOnly drawed in _drawNote (note position needed)
                _drawHash(hashLabel, _createHash(size,
                    Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 25.0, 5 * LINE_DISTANCE + LINE_OFFSET_Y)),
                    size, canvas, paint, readOnly, currentSegments, setSegmentState, SEGMENTS_COLOR_ON, SEGMENTS_COLOR_OFF);

                _drawB(bLabel, _createB(size,
                    Offset(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 25.0, 9 * LINE_DISTANCE + LINE_OFFSET_Y)),
                    size, canvas, paint, readOnly, currentSegments, setSegmentState, SEGMENTS_COLOR_ON, SEGMENTS_COLOR_OFF);
              }

              var notePositions = [-105, -35, 35, 105];
              counter = 0;
              notePosition.forEach((key) {
                var offsetX = size.width / _NOTES_RELATIVE_DISPLAY_WIDTH *
                    (readOnly
                        ?  _NOTES_RELATIVE_DISPLAY_WIDTH/2
                        : (_NOTES_RELATIVE_DISPLAY_WIDTH/2 + notePositions[(counter % 4).toInt()] + LINE_OFFSET_X));

                _drawNote(key, _createNote(size, Offset(offsetX, counter * 0.5 * LINE_DISTANCE + LINE_OFFSET_Y)),
                    size, canvas, paint, readOnly, currentSegments, setSegmentState, SEGMENTS_COLOR_ON, SEGMENTS_COLOR_OFF);
                counter ++;
              });
            });

  static _drawNote(String note, Path path, Size size, GCWTouchCanvas canvas, Paint paint, bool readOnly,
      Map<String, bool> currentSegments, Function setSegmentState, Color colorOn, Color colorOff) {
    var active = currentSegments[note];
    paint.color = active ? colorOn : colorOff;
    if (active || !readOnly) {
      canvas.touchCanvas.drawPath(path, paint);
      path.addRect(path.getBounds().inflate(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 10));
      paint.color = Colors.transparent;
      canvas.touchCanvas.drawPath(path, paint, onTapDown: (tapDetail) {
        _setNotesState(note, currentSegments, setSegmentState);
      });
    }

    if (active && readOnly) {
      var bounds = path.getBounds();
      _drawHash(hashLabel, _createHash(size,
          Offset(bounds.center.dx - size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 60, bounds.center.dy)),
          size, canvas, paint, readOnly,currentSegments, setSegmentState, colorOn, colorOff);

      _drawB(bLabel, _createB(size,
          Offset(bounds.center.dx - size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 60, bounds.center.dy)),
          size, canvas, paint, readOnly, currentSegments, setSegmentState, colorOn, colorOff);
    }
  }

  static _drawHash(String label, Path path, Size size, GCWTouchCanvas canvas, Paint paint, bool readOnly,
      Map<String, bool> currentSegments, Function setSegmentState, Color colorOn, Color colorOff) {
    var active = currentSegments[label];
    paint.color = active ? colorOn : colorOff;
    if (active || !readOnly) {
      canvas.touchCanvas.drawPath(path, paint);
      path.addRect(path.getBounds().inflate(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 10));
      paint.color = Colors.transparent;
      canvas.touchCanvas.drawPath(path, paint, onTapDown: (tapDetail) {
        setSegmentState(label, !currentSegments[label]);
        if (currentSegments[label]) setSegmentState(bLabel, false);
      });
    }
  }

  static _drawB(String label, Path path, Size size, GCWTouchCanvas canvas, Paint paint, bool readOnly,
      Map<String, bool> currentSegments, Function setSegmentState, Color colorOn, Color colorOff) {
    var active = currentSegments[label];
    paint.color = active ? colorOn : colorOff;
    if (active || !readOnly) {
      canvas.touchCanvas.drawPath(path, paint);
      path.addRect(path.getBounds().inflate(size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 10));
      paint.color = Colors.transparent;
      canvas.touchCanvas.drawPath(path, paint, onTapDown: (tapDetail) {
        setSegmentState(label, !currentSegments[label]);
        if (currentSegments[label]) setSegmentState(hashLabel, false);
      });
    }
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

  static Path _createLine(bool shortLine, Size size, Offset offset, double lineOffsetX, bool readOnly) {
    var path = Path();
    if (shortLine) {
      var rect = Rect.fromCenter(
          center: Offset(
              size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * (_NOTES_RELATIVE_DISPLAY_WIDTH/2 + (readOnly ? 0 : lineOffsetX)),
              0.0),
          width: readOnly
              ? size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 70
              : size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 260,
          height: max(1.0, size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 2));
      path.addRect(rect);
    } else {
      var rect = Rect.fromCenter(
          center: Offset(
              size.width / _NOTES_RELATIVE_DISPLAY_WIDTH *  (_NOTES_RELATIVE_DISPLAY_WIDTH/2 + (readOnly ? 0 : lineOffsetX)),
              0.0),
          width: size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 340,
          height: max(1.0, size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 2));
      path.addRect(rect);
    }
    path = path.shift(offset);
    return path;
  }

  static Path _createNote(Size size, Offset offset) {
    var path = Path();
    var rect = Rect.fromCenter(center: offset,
               width:  max(3, size.width / _NOTES_RELATIVE_DISPLAY_WIDTH * 45),
               height: max(2, size.height / _NOTES_RELATIVE_DISPLAY_HEIGHT * 28));
    path.addOval(rect);

    return path;
  }

  static Path _createHash(Size size, Offset offset) {
    var path = Path();
    var scale = 0.8 * size.width / _NOTES_RELATIVE_DISPLAY_WIDTH;

    path.moveTo(-19.201,-8.436);
    path.moveTo(-11.389,-12.587);
    path.lineTo(-11.389,-25.77);
    path.lineTo(-6.359,-25.77);
    path.lineTo(-6.359,-15.272);
    path.lineTo(6.385,-22.059);
    path.lineTo(6.385,-35.34);
    path.lineTo(11.414,-35.34);
    path.lineTo(11.414,-24.745);
    path.lineTo(19.227,-28.895);
    path.lineTo(19.227,-21.473);
    path.lineTo(11.414,-17.323);
    path.lineTo(11.414,4.454);
    path.lineTo(19.227,0.304);
    path.lineTo(19.227,7.726);
    path.lineTo(11.414,11.876);
    path.lineTo(11.414,26.232);
    path.lineTo(6.385,26.232);
    path.lineTo(6.385,14.562);
    path.lineTo(-6.359,21.349);
    path.lineTo(-6.359,34.679);
    path.lineTo(-11.389,34.679);
    path.lineTo(-11.389,24.035);
    path.lineTo(-19.201,28.185);
    path.lineTo(-19.201,20.763);
    path.lineTo(-11.389,16.613);
    path.lineTo(-11.389,-5.165);
    path.lineTo(-19.201,-1.014);
    path.lineTo(-19.201,-8.436);
    path.close();
    path.moveTo(-6.359,13.927);
    path.lineTo(6.385,7.14);
    path.lineTo(6.385,-14.637);
    path.lineTo(-6.359,-7.85);
    path.lineTo(-6.359,13.927);
    path.close();

    final translateM = Float64List.fromList([
      scale,     0,     0, 0,
      0,     scale,     0, 0,
      0,     0,     scale, 0,
      offset.dx, offset.dy, 0, 1]
    );
    return path.transform(translateM);
  }

  static Path _createB(Size size, Offset offset) {
    var path = Path();
    var scale = 0.8 * size.width / _NOTES_RELATIVE_DISPLAY_WIDTH;

    path.moveTo(1.234,15.737);
    path.lineTo(-4.796,17.079);
    path.lineTo(-8.447,17.436);
    path.lineTo(-10.509,17.494);
    path.lineTo(-12.364,17.494);
    path.lineTo(-12.364,-52.525);
    path.lineTo(-7.335,-52.525);
    path.lineTo(-7.335,-11.217);
    path.lineTo(-4.08,-13.717);
    path.lineTo(-1.72,-15.05);
    path.lineTo(2.046,-16.212);
    path.lineTo(5.018,-16.441);
    path.lineTo(7.643,-16.191);
    path.lineTo(9.95,-15.44);
    path.lineTo(13.563,-12.633);
    path.lineTo(15.243,-9.802);
    path.lineTo(15.785,-8.287);
    path.lineTo(16.453,-4.744);
    path.lineTo(16.542,-2.721);
    path.lineTo(16.263,0.778);
    path.lineTo(15.272,4.237);
    path.lineTo(12.011,9.345);
    path.lineTo(6.996,13.271);
    path.lineTo(1.234,15.737);
    path.close();
    path.moveTo(7.655,-6.212);
    path.lineTo(6.312,-9.044);
    path.lineTo(4.042,-10.948);
    path.lineTo(2.246,-11.539);
    path.lineTo(0.819,-11.656);
    path.lineTo(-3.453,-10.704);
    path.lineTo(-7.277,-8.333);
    path.lineTo(-7.335,14.858);
    path.lineTo(-3.716,14.192);
    path.lineTo(-0.572,12.978);
    path.lineTo(3.065,10.441);
    path.lineTo(4.262,9.169);
    path.lineTo(7.143,3.822);
    path.lineTo(8.035,-0.993);
    path.lineTo(8.095,-2.721);
    path.lineTo(7.868,-5.274);
    path.close();

    final translateM = Float64List.fromList([
      scale,     0,     0, 0,
      0,     scale,     0, 0,
      0,     0,     scale, 0,
      offset.dx, offset.dy, 0, 1]
    );
    return path.transform(translateM);
  }

  static bool _noteSelected(Map<String, bool> currentSegments) {
    var regExp = RegExp(r'^-?\d');
    return currentSegments.entries.any((element) {
      if (element.value == false) return false;
      return regExp.hasMatch(element.key);
    });
  }
}
