import 'package:flutter/rendering.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_rgb.dart';
import 'package:gc_wizard/utils/logic_utils/constants.dart';

int fractionPartAsInteger(double value) {
  if (value == null) return null;
  var valueSplitted = value.toString().split('.');

  if (valueSplitted.length < 2)
    return 0;
  else
    return int.parse(valueSplitted[1]);
}

bool doubleEquals(double a, double b, {double tolerance: 1e-10}) {
  if (a == null && b == null) return true;

  if (a == null || b == null) return false;

  return (a - b).abs() < tolerance;
}

bool isInteger(String text) {
  return BigInt.tryParse(text) != null;
}

String applyAlphabetModification(String input, AlphabetModificationMode mode) {
  switch (mode) {
    case AlphabetModificationMode.J_TO_I:
      input = input.replaceAll('J', 'I');
      break;
    case AlphabetModificationMode.C_TO_K:
      input = input.replaceAll('C', 'K');
      break;
    case AlphabetModificationMode.W_TO_VV:
      input = input.replaceAll('W', 'VV');
      break;
    case AlphabetModificationMode.REMOVE_Q:
      input = input.replaceAll('Q', '');
      break;
  }

  return input;
}

String colorToHexString(Color color) {
  return HexCode.fromRGB(RGB(color.red.toDouble(), color.green.toDouble(), color.blue.toDouble())).toString();
}

Color hexStringToColor(String hex) {
  RGB rgb = HexCode(hex).toRGB();
  return Color.fromARGB(255, rgb.red.floor(), rgb.green.floor(), rgb.blue.floor());
}