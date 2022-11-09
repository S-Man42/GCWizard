import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

String formatResistorValue(double value) {
  var formatter = NumberFormat('0.####');
  return formatter.format(value) + ' ' + String.fromCharCode(937);
}

String formatResistorTolerancedValueInterval(List<double> valueInterval) {
  var formatter = NumberFormat('0.############');
  return formatter.format(valueInterval[0]) +
      ' ' +
      String.fromCharCode(937) +
      ' - ' +
      formatter.format(valueInterval[1]) +
      ' ' +
      String.fromCharCode(937);
}

String formatResistorTolerance(double tolerance) {
  var formatter = NumberFormat('0.##');
  return String.fromCharCode(177) + ' ' + formatter.format(tolerance * 100) + ' %';
}

RichText formatResistorTemperatureCoefficient(double temperatureCoefficient, TextStyle textStyle) {
  return RichText(
    text: TextSpan(
      style: textStyle,
      children: [
        TextSpan(text: temperatureCoefficient.floor().toString() + ' ' + String.fromCharCode(215) + ' 10'),
        superscriptedTextForRichText('-6', textStyle: textStyle),
        TextSpan(text: ' K'),
        superscriptedTextForRichText('-1', textStyle: textStyle),
      ]
    )
  );
}

RichText formatResistorMultiplier(double multiplier, TextStyle textStyle) {
  var valueExponential = multiplier.toStringAsExponential().split('e');
  var formatter = NumberFormat('###,###,###,##0.####');

  return RichText(
    text: TextSpan(
      style: textStyle,
      children: [
        TextSpan(text: String.fromCharCode(215) + ' 10'),
        superscriptedTextForRichText(valueExponential[1].replaceFirst('+', ''), textStyle: textStyle),
        TextSpan(text: ' = ${formatter.format(multiplier).replaceAll(',', ' ')}')
      ]
    ),
  );
}