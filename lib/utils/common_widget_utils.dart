import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/logic/binary2image.dart';
import 'package:gc_wizard/utils/logic_utils/common_utils.dart';
import 'package:prefs/prefs.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

String className(Widget widget) {
  return widget.runtimeType.toString();
}

String printErrorMessage(BuildContext context, String message) {
  return i18n(context, 'common_error') + ': ' + i18n(context, message);
}

defaultFontSize() {
  var fontSize = Prefs.get(PREFERENCE_THEME_FONT_SIZE);

  if (fontSize < FONT_SIZE_MIN) {
    Prefs.setDouble(PREFERENCE_THEME_FONT_SIZE, FONT_SIZE_MIN.toDouble());
    return FONT_SIZE_MIN;
  }

  if (fontSize > FONT_SIZE_MAX) {
    Prefs.setDouble(PREFERENCE_THEME_FONT_SIZE, FONT_SIZE_MAX.toDouble());
    return FONT_SIZE_MAX;
  }

  return fontSize;
}

WidgetSpan superscriptedTextForRichText(String text, {TextStyle textStyle}) {
  var style = textStyle ?? gcwTextStyle();

  return WidgetSpan(
      child: Transform.translate(
          offset: Offset(0.0, -1 * defaultFontSize() / 2.0),
          child: Text(text, style: style.copyWith(fontSize: defaultFontSize() / 1.4))));
}

WidgetSpan subscriptedTextForRichText(String text, {TextStyle textStyle}) {
  var style = textStyle ?? gcwTextStyle();

  return WidgetSpan(
      child: Transform.translate(
          offset: Offset(0.0, defaultFontSize() / 4.0),
          child: Text(text, style: style.copyWith(fontSize: defaultFontSize() / 1.4))));
}

/* Takes string input. If "_foo_" or "^bar^" exists, a RichText widget with
   sub- or superscripted TextSpans will be created,
   otherwise the input will be returned as String
*/
buildSubOrSuperscriptedRichTextIfNecessary(String input) {
  var supSubRegExp = RegExp(r'(\^(.+?)\^|_(.+?)_)');

  if (supSubRegExp.hasMatch(input)) {
    var textSpans = <InlineSpan>[];

    var lastEnd = 0;
    supSubRegExp.allMatches(input).forEach((element) {
      textSpans.add(TextSpan(text: input.substring(lastEnd, element.start)));

      var widgetSpan;
      if (element.group(1).startsWith('_')) {
        widgetSpan = subscriptedTextForRichText(element.group(1).replaceAll('_', ''));
      } else {
        widgetSpan = superscriptedTextForRichText(element.group(1).replaceAll('^', ''));
      }

      textSpans.add(widgetSpan);
      lastEnd = element.end;
    });

    if (lastEnd < input.length) {
      textSpans.add(TextSpan(text: input.substring(lastEnd)));
    }

    return RichText(text: TextSpan(style: gcwTextStyle(), children: textSpans));
  } else {
    return input;
  }
}

String textControllerInsertText(String input, String currentText, TextEditingController textController) {
  var cursorPosition = max(textController.selection.end, 0);

  currentText = currentText.substring(0, cursorPosition) + input + currentText.substring(cursorPosition);
  textController.text = currentText;
  textController.selection = TextSelection.collapsed(offset: cursorPosition + input.length);

  return currentText;
}

String textControllerDoBackSpace(String currentText, TextEditingController textController) {
  var cursorPosition = max(textController.selection.end, 0);
  if (cursorPosition == 0) return currentText;

  currentText = currentText.substring(0, cursorPosition - 1) + currentText.substring(cursorPosition);
  textController.text = currentText;
  textController.selection = TextSelection.collapsed(offset: cursorPosition - 1);

  return currentText;
}

double maxScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - 100;
}

Future<bool> launchUrl(Uri url) async {
  return urlLauncher.launchUrl(url, mode: urlLauncher.LaunchMode.externalApplication);
}

Future<Uint8List> input2Image(ImageData imageData)  async {
  var width = 0.0;
  var height = 0.0;

  if (imageData == null || imageData.lines == null || imageData.colors == null) return null;

  imageData.lines.forEach((line) {
    width = max(width, line.length.toDouble());
    height++;
  });
  width = width * imageData.pointSize + 2 * imageData.bounds;
  height = height * imageData.pointSize + 2 * imageData.bounds;

  final canvasRecorder = PictureRecorder();
  final canvas = Canvas(canvasRecorder, Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Color(imageData.colors.values.first) //Colors.white
    ..style = PaintingStyle.fill;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
  for (int row = 0; row < imageData.lines.length; row++) {
    for (int column = 0; column < imageData.lines[row].length; column++) {
      paint.color = Color(imageData.colors.values.first); // Colors.white
      if (imageData.colors.containsKey(imageData.lines[row][column]))
        paint.color = Color(imageData.colors[imageData.lines[row][column]]);

      if (imageData.lines[row][column] != '0')
        canvas.drawRect(
            Rect.fromLTWH(column * imageData.pointSize + imageData.bounds, row * imageData.pointSize + imageData.bounds,
                imageData.pointSize, imageData.pointSize), paint);
    }
  }

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ImageByteFormat.png);

  return trimNullBytes(data.buffer.asUint8List());
}
