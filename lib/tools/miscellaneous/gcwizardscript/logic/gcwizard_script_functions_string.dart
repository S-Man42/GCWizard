part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

String _char(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return String.fromCharCode(x as int);
}

int _asc(Object x) {
  if (_isNotString(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as String).codeUnitAt(0);
}

String _left(Object x, Object count) {
  if (_isNotString(x) || _isString(count)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return (x as String).substring(0, (count as int));
}

String _right(Object x, Object count) {
  if (_isNotString(x) || _isString(count)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  if (count.runtimeType.toString() == 'String') {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return (x as String).substring(x.length - (count as int));
}

String _mid(Object x, Object start, Object len) {
  if (_isNotString(x) || _isString(start) || _isString(len)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return (x as String).substring((start as int) - 1, start - 1 + (len as int));
}

int _len(Object x) {
  if (_isNotString(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return x.toString().length;
}

String _str(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  if ((x as num).floor() == x) return x.toStringAsFixed(0);

  return x.toStringAsFixed(3);
}

Object _val(Object x) {
  if (int.tryParse(x as String) != null) {
    return int.parse(x).toDouble();
  } else {
    if (double.tryParse(x) != null) {
      return double.parse(x);
    }
  }

  _handleError(_INVALIDTYPECAST);
  return 0.0;
}

String _subst(Object text, Object x, Object y, Object caseSensitive){
  if (_isNotString(text) || _isNotString(x) || _isNotString(y) || _isNotInt(caseSensitive)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  Map<String, String> substitutions = {};
  substitutions[x as String] = y as String;
  return substitution(text as String, substitutions, caseSensitive: ((caseSensitive as int) == 1));
}

