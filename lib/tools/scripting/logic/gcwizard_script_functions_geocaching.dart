part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

const _defaultAlphabetAlpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const _defaultAlphabetDigits = '0123456789';

String _rotx(Object text, Object rot) {
  if (_isNotString(text) || _isString(rot)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return Rotator().rotate((text as String), (rot as int));
}

String _rot5(Object text, ) {
  if (_isNotString(text)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  Rotator rot = Rotator();
  rot.alphabet = _defaultAlphabetDigits;
  return rot.rotate((text as String), 5);
}

String _rot13(Object text, ) {
  if (_isNotString(text)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  Rotator rot = Rotator();
  rot.alphabet = _defaultAlphabetAlpha;
  return rot.rotate((text as String), 5);
}

String _rot18(Object text, ) {
  if (_isNotString(text)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }

  return (text as String).split('').map((char) {
    if (_defaultAlphabetAlpha.contains(char.toUpperCase())) {
      return _rot13(char);
    } else if (_defaultAlphabetDigits.contains(char)) {
      return _rot5(char);
    } else {
      return char;
    }
  }).join();
}

String _rot47(Object text, ) {
  if (_isNotString(text)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }

  Rotator rot = Rotator();
  rot.alphabet = '!"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';
  return rot.rotate((text as String), 47, removeUnknownCharacters: false, ignoreCase: false);
}

int _bww(Object text, Object opt_alph, Object opt_itqs) { //ToDo opt_alph ???
  if (_isNotString(text) || _isString(opt_alph) || _isString(opt_itqs)) {
    _handleError(_INVALIDTYPECAST);
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

String _dectoroman(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return encodeRomanNumbers((x as int), type: RomanNumberType.USE_SUBTRACTION_RULE);
}

int _romantodec(Object x) {
  if (_isInt(x) || _isDouble(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return decodeRomanNumbers((x as String), type: RomanNumberType.USE_SUBTRACTION_RULE)!;
}
