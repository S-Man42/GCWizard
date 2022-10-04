import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class _DefaultHash extends StatefulWidget {
  final Function hashFunction;
  final bool needKey;

  const _DefaultHash({Key key, this.hashFunction, this.needKey}) : super(key: key);

  @override
  _DefaultHashState createState() => _DefaultHashState();
}

class _DefaultHashState extends State<_DefaultHash> {
  String _currentValue = '';
  String _currentKey = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          },
        ),
        widget.needKey == true
          ? GCWTextField(
            hintText: i18n(context, 'common_key'),
            onChanged: (value) {
              setState(() {
                _currentKey = value;
              });
            },
          )
          : Container(),
        GCWDefaultOutput(child: widget.hashFunction(_currentValue))
      ],
    );
  }
}

class BLAKE2b_160 extends _DefaultHash {
  BLAKE2b_160() : super(hashFunction: blake2b_160Digest);
}

class BLAKE2b_224 extends _DefaultHash {
  BLAKE2b_224() : super(hashFunction: blake2b_224Digest);
}

class BLAKE2b_256 extends _DefaultHash {
  BLAKE2b_256() : super(hashFunction: blake2b_256Digest);
}

class BLAKE2b_384 extends _DefaultHash {
  BLAKE2b_384() : super(hashFunction: blake2b_384Digest);
}

class BLAKE2b_512 extends _DefaultHash {
  BLAKE2b_512() : super(hashFunction: blake2b_512Digest);
}

class MD2 extends _DefaultHash {
  MD2() : super(hashFunction: md2Digest);
}

class MD4 extends _DefaultHash {
  MD4() : super(hashFunction: md4Digest);
}

class MD5 extends _DefaultHash {
  MD5() : super(hashFunction: md5Digest);
}

class RIPEMD_128 extends _DefaultHash {
  RIPEMD_128() : super(hashFunction: ripemd_128Digest);
}

class RIPEMD_160 extends _DefaultHash {
  RIPEMD_160() : super(hashFunction: ripemd_160Digest);
}

class RIPEMD_256 extends _DefaultHash {
  RIPEMD_256() : super(hashFunction: ripemd_256Digest);
}

class RIPEMD_320 extends _DefaultHash {
  RIPEMD_320() : super(hashFunction: ripemd_320Digest);
}

class SHA1 extends _DefaultHash {
  SHA1() : super(hashFunction: sha1Digest);
}

class SHA224 extends _DefaultHash {
  SHA224() : super(hashFunction: sha224Digest);
}

class SHA256 extends _DefaultHash {
  SHA256() : super(hashFunction: sha256Digest);
}

class SHA384 extends _DefaultHash {
  SHA384() : super(hashFunction: sha384Digest);
}

class SHA512 extends _DefaultHash {
  SHA512() : super(hashFunction: sha512Digest);
}

class SHA512_224 extends _DefaultHash {
  SHA512_224() : super(hashFunction: sha512_224Digest);
}

class SHA512_256 extends _DefaultHash {
  SHA512_256() : super(hashFunction: sha512_256Digest);
}

class SHA3_224 extends _DefaultHash {
  SHA3_224() : super(hashFunction: sha3_224Digest);
}

class SHA3_256 extends _DefaultHash {
  SHA3_256() : super(hashFunction: sha3_256Digest);
}

class SHA3_384 extends _DefaultHash {
  SHA3_384() : super(hashFunction: sha3_384Digest);
}

class SHA3_512 extends _DefaultHash {
  SHA3_512() : super(hashFunction: sha3_512Digest);
}

class Keccak_128 extends _DefaultHash {
  Keccak_128() : super(hashFunction: keccak_128Digest);
}

class Keccak_224 extends _DefaultHash {
  Keccak_224() : super(hashFunction: keccak_224Digest);
}

class Keccak_256 extends _DefaultHash {
  Keccak_256() : super(hashFunction: keccak_256Digest);
}

class Keccak_288 extends _DefaultHash {
  Keccak_288() : super(hashFunction: keccak_288Digest);
}

class Keccak_384 extends _DefaultHash {
  Keccak_384() : super(hashFunction: keccak_384Digest);
}

class Keccak_512 extends _DefaultHash {
  Keccak_512() : super(hashFunction: keccak_512Digest);
}

class Tiger_192 extends _DefaultHash {
  Tiger_192() : super(hashFunction: tiger_192Digest);
}

class Whirlpool_512 extends _DefaultHash {
  Whirlpool_512() : super(hashFunction: whirlpool_512Digest);
}

class SHA1HMac extends _DefaultHash {
  SHA1HMac() : super(hashFunction: sha1Hmac, needKey: true);
}

class SHA224HMac extends _DefaultHash {
  SHA224HMac() : super(hashFunction: sha224Hmac, needKey: true);
}

class SHA256HMac extends _DefaultHash {
  SHA256HMac() : super(hashFunction: sha256Hmac, needKey: true);
}

class SHA384HMac extends _DefaultHash {
  SHA384HMac() : super(hashFunction: sha384Hmac, needKey: true);
}

class SHA512HMac extends _DefaultHash {
  SHA512HMac() : super(hashFunction: sha512Hmac, needKey: true);
}

class MD2HMac extends _DefaultHash {
  MD2HMac() : super(hashFunction: md2Hmac, needKey: true);
}

class MD4HMac extends _DefaultHash {
  MD4HMac() : super(hashFunction: md4Hmac, needKey: true);
}

class MD5HMac extends _DefaultHash {
  MD5HMac() : super(hashFunction: md5Hmac, needKey: true);
}

class RIPEMD_128HMac extends _DefaultHash {
  RIPEMD_128HMac() : super(hashFunction: ripemd_128Hmac, needKey: true);
}

class RIPEMD_160HMac extends _DefaultHash {
  RIPEMD_160HMac() : super(hashFunction: ripemd_128Hmac, needKey: true);
}

class Tiger_192HMac extends _DefaultHash {
  Tiger_192HMac() : super(hashFunction: tiger_192Hmac, needKey: true);
}

class SHA3_224HMac extends _DefaultHash {
  SHA3_224HMac() : super(hashFunction: sha3_224Hmac);
}

class SHA3_256HMac extends _DefaultHash {
  SHA3_256HMac() : super(hashFunction: sha3_256Hmac);
}

class SHA3_384HMac extends _DefaultHash {
  SHA3_384HMac() : super(hashFunction: sha3_384Hmac);
}

class SHA3_512HMac extends _DefaultHash {
  SHA3_512HMac() : super(hashFunction: sha3_512Hmac);
}