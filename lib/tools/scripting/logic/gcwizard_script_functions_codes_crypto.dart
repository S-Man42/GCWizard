part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

const _DECODE = -1;
const _ENCODE = 1;

String _bacon(Object text, Object mode) {
  if (_isNotString(text) || _isNotInt(mode)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  String output = '';
  switch (mode as int) {
    case _DECODE: output = decodeBacon(text as String, false, false); break;
    case _ENCODE: output = encodeBacon(text as String, false, false); break;
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
    case _DECODE: output = decryptAbaddon(text as String, null); break;
    case _ENCODE: output = encryptAbaddon(text as String, null); break;
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

String _avemaria(Object text, Object mode) {
  if (_isNotString(text) || _isNotInt(mode)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  String output = '';
  switch (mode) {
    case _DECODE: output = decodeAveMaria(text as String); break;
    case _ENCODE: output = encodeAveMaria(text as String); break;
  }
  return output;
}