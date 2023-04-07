part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _char(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return String.fromCharCode(x as int);
}

int _asc(dynamic x) {
  if (_isNotString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as String).codeUnitAt(0);
}

String _left(dynamic x, dynamic count) {
  if (_isNotString(x) || _isString(count)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return (x as String).substring(0, (count as int));
}

String _right(dynamic x, dynamic count) {
  if (_isNotString(x) || _isString(count)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  if (count.runtimeType.toString() == 'String') {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return (x as String).substring(x.length - (count as int));
}

String _mid(dynamic x, dynamic start, dynamic len) {
  if (_isNotString(x) || _isString(start) || _isString(len)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return (x as String).substring((start as int) - 1, start - 1 + (len as int));
}

int _len(dynamic x) {
  if (_isNotString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return x.toString().length;
}

String _str(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  if ((x as num).floor() == x) return x.toStringAsFixed(0);

  return x.toStringAsFixed(3);
}

dynamic _val(dynamic x) {
  if (int.tryParse(x as String) != null) {
    return int.parse(x).toDouble();
  } else {
    if (double.tryParse(x) != null) {
      return double.parse(x);
    }
  }

  _handleError(INVALIDTYPECAST);
  return 0.0;
}

