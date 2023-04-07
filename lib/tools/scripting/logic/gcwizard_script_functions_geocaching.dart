part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _rotx(dynamic text, dynamic rot) {
  if (_isNotString(text) || _isString(rot)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return Rotator().rotate((text as String), (rot as int));
}

int _bww(dynamic text, dynamic opt_alph, dynamic opt_itqs) {
  if (_isNotString(text) || _isString(opt_alph) || _isString(opt_itqs)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  int wordValue = 0;
  List<int> values = AlphabetValues().textToValues(text as String).cast<int>();
  for (int number in values ) {
    wordValue = wordValue + number;
  }
  switch (opt_itqs as int) {
    case 0:
      return wordValue;
    case 1:
      return sumCrossSum(values).toInt();
    case 2:
      return sumCrossSumIterated(values).toInt();
  }
  return 0;
}

String _dectoroman(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return encodeRomanNumbers((x as int), type: RomanNumberType.USE_SUBTRACTION_RULE);
}

int _romantodec(dynamic x) {
  if (_isInt(x) || _isDouble(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return decodeRomanNumbers((x as String), type: RomanNumberType.USE_SUBTRACTION_RULE)!;
}
