part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _hash(dynamic t, dynamic b, dynamic km, dynamic k, dynamic x) {
  if (_isNotString(t) || _isNotInt(b) || _isNotString(k) || _isNotInt(km)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  switch (t.toUpperCase()) {
    case 'MD2':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_md2'](x);
      } else {
        return HASHKEY_FUNCTIONS['hashes_md2hmac'](x, k);
      }
    case 'MD4':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_md4'](x);
      } else {
        return HASHKEY_FUNCTIONS['hashes_md4hmac'](x, k);
      }
    case 'MD5':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_md5'](x);
      } else {
        return HASHKEY_FUNCTIONS['hashes_md5hmac'](x, k);
      }
    case 'SHA1':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_sha1'](x);
      } else {
        return HASHKEY_FUNCTIONS['hashes_sha1hmac'](x, k);
      }
    case 'SHA':
      if (km == 0) {
        switch (b) {
          case 224:
            return HASH_FUNCTIONS['hashes_sha224'](x);
          case 256:
            return HASH_FUNCTIONS['hashes_sha256'](x);
          case 384:
            return HASH_FUNCTIONS['hashes_sha384'](x);
          case 512:
            return HASH_FUNCTIONS['hashes_sha512'](x);
          default:
            _handleError(INVALIDHASHBITRATE);
        }
      } else {
        switch (b) {
          case 224:
            return HASHKEY_FUNCTIONS['hashes_sha224hmac'](x, k);
          case 256:
            return HASHKEY_FUNCTIONS['hashes_sha256hmac'](x, k);
          case 384:
            return HASHKEY_FUNCTIONS['hashes_sha384hmac'](x, k);
          case 512:
            return HASHKEY_FUNCTIONS['hashes_sha512hmac'](x, k);
          default:
            _handleError(INVALIDHASHBITRATE);
        }
      }
      return '';
    case 'SHA3':
      if (km == 0) {
        switch (b) {
          case 224:
            return HASH_FUNCTIONS['hashes_sha3.224'](x);
          case 256:
            return HASH_FUNCTIONS['hashes_sha3.256'](x);
          case 384:
            return HASH_FUNCTIONS['hashes_sha3.384'](x);
          case 512:
            return HASH_FUNCTIONS['hashes_sha3.512'](x);
          default:
            _handleError(INVALIDHASHBITRATE);
        }
      } else {
        switch (b) {
          case 224:
            return HASHKEY_FUNCTIONS['hashes_sha3.224hmac'](x, k);
          case 256:
            return HASHKEY_FUNCTIONS['hashes_sha3.256hmac'](x, k);
          case 384:
            return HASHKEY_FUNCTIONS['hashes_sha3.384hmac'](x, k);
          case 512:
            return HASHKEY_FUNCTIONS['hashes_sha3.512hmac'](x, k);
          default:
            _handleError(INVALIDHASHBITRATE);
        }
      }
      return '';
    case 'BLAKE2B':
      switch (b) {
        case 160:
          return HASH_FUNCTIONS['hashes_blake2b160'](x);
        case 224:
          return HASH_FUNCTIONS['hashes_blake2b224'](x);
        case 256:
          return HASH_FUNCTIONS['hashes_blake2b256'](x);
        case 384:
          return HASH_FUNCTIONS['hashes_blake2b384'](x);
        case 512:
          return HASH_FUNCTIONS['hashes_blake2b512'](x);
        default:
          _handleError(INVALIDHASHBITRATE);
      }

      return '';
    case 'KECCAK':
      switch (b) {
        case 128:
          return HASH_FUNCTIONS['hashes_keccak128'](x);
        case 224:
          return HASH_FUNCTIONS['hashes_keccak224'](x);
        case 256:
          return HASH_FUNCTIONS['hashes_keccak256'](x);
        case 288:
          return HASH_FUNCTIONS['hashes_keccak288'](x);
        case 384:
          return HASH_FUNCTIONS['hashes_keccak384'](x);
        case 512:
          return HASH_FUNCTIONS['hashes_keccak512'](x);
        default:
          _handleError(INVALIDHASHBITRATE);
      }

      return '';
    case 'RIPEMD':
      if (km == 0) {
        switch (b) {
          case 128:
            return HASH_FUNCTIONS['hashes_ripemd128'](x);
          case 160:
            return HASH_FUNCTIONS['hashes_ripemd160'](x);
          case 256:
            return HASH_FUNCTIONS['hashes_ripemd256'](x);
          case 320:
            return HASH_FUNCTIONS['hashes_ripemd320'](x);
          default:
            _handleError(INVALIDHASHBITRATE);
        }
      } else {
        switch (b) {
          case 128:
            return HASHKEY_FUNCTIONS['hashes_ripemd128hmac'](x, k);
          case 160:
            return HASHKEY_FUNCTIONS['hashes_ripemd160hmac'](x, k);
          case 256:
            return HASHKEY_FUNCTIONS['hashes_ripemd256hmac'](x, k);
          case 320:
            return HASHKEY_FUNCTIONS['hashes_ripemd320hmac'](x, k);
          default:
            _handleError(INVALIDHASHBITRATE);
        }
      }
      return '';
    case 'TIGER':
      if (km == 1) {
        return HASHKEY_FUNCTIONS['hashes_tiger192hmac'](x, k);
      } else {
        return HASH_FUNCTIONS['hashes_tiger192'](x);
      }
    case 'WHIRLPOOL':
      if (km == 1) {
        return HASHKEY_FUNCTIONS['hashes_whirlpool512hmac'](x, k);
      } else {
        return HASH_FUNCTIONS['hashes_whirlpool512'](x);
      }
    default:
      _handleError(INVALIDHASHBITRATE);
  }
  return '';
}
