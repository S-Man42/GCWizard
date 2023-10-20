import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_datatypes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_data.dart';

SoundfileData getSoundfileData(Uint8List bytes){
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return WAVContent(bytes);
    default: return SoundfileData(
        structure: [],
        PCMformat: 0,
        bits: 0,
        channels: 0,
        sampleRate: 0,
        duration: 0.0,
        amplitudesData: Uint8List.fromList([]));
  }
}

Future<MorseData> PCMamplitudes2Image({required double duration, required List<double> RMSperPoint, required double maxAmplitude, required int pointsize, required int hScalefactor, required int volume}) async {
  // https://planetcalc.com/8627/
  // PCM audio data is stored as a sequence of signal amplitude samples recorded at regular intervals.
  // One second of the low-quality 8kHz audio consists of 8000 amplitude samples.
  // To display every point of this fragment as is, you need at least an 8000-pixel wide display.
  // Therefore, we need an algorithm to reduce the visual representation of the waveform.
  //
  // The calculator uses the root mean square (RMS) algorithm to represent a sample set as a single line on the waveform graph.
  //
  // Determine the number of graph width points P
  // Determine the number of samples per point S=T/P, where T - total number of samples
  //
  // For every point, calculate RMS:    R= sqrt{ sum{n=1 to S} of s(n)^2}
  //
  //    where s(n) - is the n-th sample of a given point
  //
  // For every point, draw a vertical line from -R to R
  //
  // Audio amplitude samples are stored either as float or integer values in PCM format.
  // The calculator converts the integer amplitudes to float ones in range (-1...1) to represent the signal waveform on the graph uniformly.
  // PCM format can store two types of integer data. If the integer sample size is less or equal to 8 bits (one byte), it is stored as an unsigned value.
  // Otherwise (more than 8 bit), it's two's complement signed.
  // The calculator transforms 8-bit integer data to float in this way: (s(n)-128)/128.
  // The greater integer data (16, 24, or 32-bits long) is converted to float as s(n)/|int_min|.
  // |int_min| equals to 32768; 8388608 or 2147483648 for 16, 24 or 32-bit integer respectively.

  const BOUNDS = 10.0;

  var width = BOUNDS + RMSperPoint.length * hScalefactor + BOUNDS * 1.0;
  var height = BOUNDS + maxAmplitude + maxAmplitude + BOUNDS;

  var threshhold = maxAmplitude * volume / 10;

  List<bool> morseCode = [];

  int durationScaleH = RMSperPoint.length ~/ duration;
  int durationScaleV = maxAmplitude ~/ 100;

  final canvasRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill
    ..strokeWidth = pointsize.toDouble();

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  paint.color = Colors.white;
  paint.strokeWidth = pointsize.toDouble() * 2;
  canvas.drawLine(
      Offset(BOUNDS, height / 2),
      Offset(BOUNDS + width * pointsize, height / 2),
      paint);

  paint.color = Colors.orangeAccent;
  paint.strokeWidth = pointsize.toDouble();
  for (int column = 0; column < RMSperPoint.length; column++) {

    if (RMSperPoint[column] > threshhold) {
      morseCode.add(true);
    } else {
      morseCode.add(false);
    }

    canvas.drawLine(
        Offset(BOUNDS + 1 + column * hScalefactor, height / 2 - RMSperPoint[column] * durationScaleV),
        Offset(BOUNDS + 1 + column * hScalefactor, height / 2 + RMSperPoint[column] * durationScaleV),
        paint);

    if (column % durationScaleH == 0) {
      paint.color = Colors.red;
      paint.strokeWidth = pointsize.toDouble() * 2;
      canvas.drawLine(
          Offset(BOUNDS + 1 + column * hScalefactor, height / 2 - durationScaleV * 10),
          Offset(BOUNDS + 1 + column * hScalefactor, height / 2 + durationScaleV * 10),
          paint);
      paint.color = Colors.orangeAccent;
      paint.strokeWidth = pointsize.toDouble();
    }
  }

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return MorseData(MorseImage: trimNullBytes(data!.buffer.asUint8List()), MorseCode: morseCode);
}