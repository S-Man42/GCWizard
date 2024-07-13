import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/logic/crosstotals.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

enum PostcodeFormat { Linear30, Linear36, Linear69, Linear80 }
enum ErrorCode { Ok, Character, Length, Invalid }

class PostcodeResult {
  final String postalCode;
  final String postalCodeCheckDigit;
  final bool postalCodeCheckDigitOk;
  final String streetCode;
  final String houseNumber;
  final String feeProtectionCode;
  final PostcodeFormat format;
  final ErrorCode errorCode;

  const PostcodeResult(this.postalCode, this.postalCodeCheckDigit, this.postalCodeCheckDigitOk , this.streetCode,
      this.houseNumber, this.feeProtectionCode, this.format, this.errorCode);
  @override
  String toString() {
    return 'postalCode: ' + postalCode + ' postalCodeCheckDigit: ' + postalCodeCheckDigit +
        ' postalCodeCheckDigitOk: ' + postalCodeCheckDigitOk.toString() + ' streetCode: ' + streetCode +
        ' houseNumber: ' + houseNumber + ' feeProtectionCode: ' + feeProtectionCode +
        ' format: ' + format.toString() + ' errorCode: ' + errorCode.toString();
  }
}

const Map<String, String> _01247 = {
  '11100': '0',
  '00111': '1',
  '01011': '2',
  '10011': '3',
  '01101': '4',
  '10101': '5',
  '11001': '6',
  '10001': '7',
  '10110': '8',
  '11010': '9',
};

const Map<String, String> _8421 = {
  '1111': '0',
  '1110': '1',
  '1101': '2',
  '1100': '3',
  '1011': '4',
  '1010': '5',
  '1001': '6',
  '0101': '7',
  '0111': '8',
  '0110': '9',
};

PostcodeResult decodePostcode(String code) {
  var _code = _cleanCode(code);
  if (_code == null) {
    return const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Character);
  }
  var format = _getFormat(_code);
  if (format == null) {
    return const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Length);
  }
  return _decode(_code, format);
}

String encodePostcode(String postalCode, int streetCode, int houseNumber, int feeProtectionCode,
    PostcodeFormat format) {
  if ((postalCode.length != 5 && format != PostcodeFormat.Linear30) ||
      (postalCode.length != 4 && format == PostcodeFormat.Linear30)) {
    return 'postalCodeLength';
  }
  if (int.tryParse(postalCode) == null) {
    return 'postalCodeData';
  }
  if (streetCode.toString().length > 3) {
    return 'streetCodeLength';
  }
  if (houseNumber.toString().length > 3) {
    return 'houseNumberLength';
  }
  if (feeProtectionCode.toString().length > 2) {
    return 'feeProtectionCodeLength';
  }

  var map01247 = switchMapKeyValue(_01247);
  var map8421 = switchMapKeyValue(_8421);

  var _postalCode = reverse(postalCode).split('').map((e) => map01247[e]! + '1').toList();
  var _postalCodeCheckDigit = _calcChecksum(postalCode).split('').map((e) => map01247[e]! + '1').toList();
  var _streetCode = reverse(streetCode.toString().padLeft(3, '0')).split('').map((e) => map8421[e]! + '1').toList();
  var _houseNumber = reverse(houseNumber.toString().padLeft(3, '0')).split('').map((e) => map8421[e]! + '1').toList();
  var _feeProtectionCode = reverse(feeProtectionCode.toString().padLeft(2, '0')).split('').
        map((e) => map8421[e]! + '1').toList();

  var output = <String>[];
  switch (format) {
    case PostcodeFormat.Linear30:
    case PostcodeFormat.Linear36:
      output.addAll(_postalCode);
      output.addAll(_postalCodeCheckDigit);

    case PostcodeFormat.Linear69:
      output.add('0');
      output.addAll(_houseNumber);
      output.addAll(_streetCode);
      output.addAll(_postalCode);
      output.addAll(_postalCodeCheckDigit);
      output.add('11');

    case PostcodeFormat.Linear80:
      output.add('0');
      output.addAll(_feeProtectionCode);
      output.addAll(_houseNumber);
      output.addAll(_streetCode);
      output.addAll(_postalCode);
      output.addAll(_postalCodeCheckDigit);
      output.add('11');
  }

  return output.join().replaceAll('0', '.').replaceAll('1', '|');
}

PostcodeResult _decode(String code, PostcodeFormat format) {
  const invalidResult = PostcodeResult('','',false, '','','', PostcodeFormat.Linear30, ErrorCode.Invalid);

  switch (format) {
    case PostcodeFormat.Linear30:
      var numbers = [
        code.substring(0, 5),
        code.substring(6, 11),
        code.substring(12, 17),
        code.substring(18, 23),
        code.substring(24, 29),
      ];
      for (var number in numbers) {
        if (_decode01247(number) == null) return invalidResult;
      }
      var postalCode =  _decode01247(numbers[3])! + _decode01247(numbers[2])! +
          _decode01247(numbers[1])! + _decode01247(numbers[0])!;

      return PostcodeResult(
          postalCode,
          _decode01247(numbers[4])!,
          _decode01247(numbers[4])! == _calcChecksum(postalCode),
          '','','',
          PostcodeFormat.Linear30, ErrorCode.Ok);

    case PostcodeFormat.Linear36:
      var numbers = [
        code.substring(0, 5),
        code.substring(6, 11),
        code.substring(12, 17),
        code.substring(18, 23),
        code.substring(24, 29),
        code.substring(30, 35)
      ];
      for (var number in numbers) {
        if (_decode01247(number) == null) return invalidResult;
      }
      var postalCode =  _decode01247(numbers[4])! + _decode01247(numbers[3])! + _decode01247(numbers[2])! +
          _decode01247(numbers[1])! + _decode01247(numbers[0])!;

      return PostcodeResult(
          postalCode,
          _decode01247(numbers[5])!,
          _decode01247(numbers[5])! == _calcChecksum(postalCode),
          '','','',
          PostcodeFormat.Linear36, ErrorCode.Ok);

    case PostcodeFormat.Linear69:
      if (!code.endsWith('111')) return invalidResult;

      var numbers = [
        code.substring(1, 5),
        code.substring(6, 10),
        code.substring(11, 15),
        code.substring(16, 20),
        code.substring(21, 25),
        code.substring(26, 30),
        code.substring(31, 36),
        code.substring(37, 42),
        code.substring(43, 48),
        code.substring(49, 54),
        code.substring(55, 60),
        code.substring(61, 66)
      ];
      for (var number in numbers) {
        if ((number.length == 5 ? _decode01247(number) : _decode8421(number)) == null) return invalidResult;
      }
      var postalCode = _decode01247(numbers[10])! + _decode01247(numbers[9])! + _decode01247(numbers[8])! +
          _decode01247(numbers[7])! + _decode01247(numbers[6])!;

      return PostcodeResult(
          postalCode,
          _decode01247(numbers[11])!,
          _decode01247(numbers[11])! == _calcChecksum(postalCode),
          _decode8421(numbers[5])! + _decode8421(numbers[4])! + _decode8421(numbers[3])!,
          _decode8421(numbers[2])! + _decode8421(numbers[1])! + _decode8421(numbers[0])!,
          '',
          PostcodeFormat.Linear69, ErrorCode.Ok);

    case PostcodeFormat.Linear80:
      if (!code.endsWith('111')) return invalidResult;
      if (code.length > 79) code = code.substring(code.length - 79);

      var numbers = [
        code.substring(1, 5),
        code.substring(6, 10),
        code.substring(11, 15),
        code.substring(16, 20),
        code.substring(21, 25),
        code.substring(26, 30),
        code.substring(31, 35),
        code.substring(36, 40),
        code.substring(41, 46),
        code.substring(47, 52),
        code.substring(53, 58),
        code.substring(59, 64),
        code.substring(65, 70),
        code.substring(71, 76)
      ];
      for (var number in numbers) {
        if ((number.length == 5 ? _decode01247(number) : _decode8421(number)) == null) return invalidResult;
      }
      var postalCode = _decode01247(numbers[12])! + _decode01247(numbers[11])! + _decode01247(numbers[10])! +
          _decode01247(numbers[9])! + _decode01247(numbers[8])!;

      return PostcodeResult(
          postalCode,
          _decode01247(numbers[13])!,
          _decode01247(numbers[13])! == _calcChecksum(postalCode),
          _decode8421(numbers[7])! + _decode8421(numbers[6])! + _decode8421(numbers[5])!,
          _decode8421(numbers[4])! + _decode8421(numbers[3])! + _decode8421(numbers[2])!,
          _decode8421(numbers[1])! + _decode8421(numbers[0])!,
          PostcodeFormat.Linear80, ErrorCode.Ok);
  }
}

String _calcChecksum(String postalCode) {
  return (10 - (crossSum([int.parse(postalCode)]).toInt() % 10)).toString();
}

String? _decode01247(String code) {
  if (_01247.containsKey(code)) return _01247[code];
  return null;
}

String? _decode8421(String code) {
  if (_8421.containsKey(code)) return _8421[code];
  return null;
}

String? _cleanCode(String code) {
  const substitutions={'.':'0', '-':'0', '_':'0', ' ':'0', 'I':'1', 'l':'1', '|':'1'};
  code = substitution(code, substitutions);
  if (code.replaceAll('0', '').replaceAll('1', '').isNotEmpty) {
    return null;
  }
  return code;
}

PostcodeFormat? _getFormat(String code) {
  switch (code.length) {
    case 30:
      return PostcodeFormat.Linear30;
    case 36:
      return PostcodeFormat.Linear36;
    case 69:
      return PostcodeFormat.Linear69;
    case 79:
    case 80:
      return PostcodeFormat.Linear80;
  }
  return null;
}