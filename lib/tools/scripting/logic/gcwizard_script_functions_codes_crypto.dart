part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

const _DECODE = -1;
const _ENCODE = 1;

String _bacon(Object text, Object mode) {
  if (_isNotString(text) || _isNotInt(mode)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  String output = '';
  switch (mode) {
    case _DECODE: decodeBacon(text as String, false, false); break;
    case _ENCODE: encodeBacon(text as String, false, false); break;
  }
  return output;
}

String _abaddon(Object text, Object mode) {
  if (_isNotString(text) || _isNotInt(mode)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  String output = '';
  switch (mode) {
    case _DECODE: decryptAbaddon(text as String, null); break;
    case _ENCODE: encryptAbaddon(text as String, null); break;
  }
  return output;
}

String _atbash(Object text) {
  if (_isNotString(text)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return atbash(text as String);
}