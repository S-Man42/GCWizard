part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _base(dynamic t, dynamic m, dynamic x) {
  if (_isNotInt(t) || _isNotInt(m)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  switch (t.toUpperCase()) {
    case 16:
      if (m == 0) {
        return decodeBase16(x as String);
      } else {
        return encodeBase16(x as String);
      }
    case 32:
      if (m == 0) {
        return decodeBase32(x as String);
      } else {
        return encodeBase32(x as String);
      }
    case 58:
      if (m == 0) {
        return decodeBase58(x as String);
      } else {
        return encodeBase58(x as String);
      }
    case 64:
      if (m == 0) {
        return decodeBase64(x as String);
      } else {
        return encodeBase64(x as String);
      }
    case 85:
      if (m == 0) {
        return decodeBase85(x as String);
      } else {
        return encodeBase85(x as String);
      }
    case 91:
      if (m == 0) {
        return decodeBase91(x as String);
      } else {
        return encodeBase91(x as String);
      }
    case 122:
      if (m == 0) {
        return decodeBase122(x as String);
      } else {
        return encodeBase122(x as String);
      }
    default:
      _handleError(INVALIDBASETYPE);
      return '';
  }
}