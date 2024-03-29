import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/tapir/logic/tapir.dart';

void main() {
  group("Tapir.encryptTapir:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABE', 'expectedOutput' : '05183'},

      //http://scz.bplaced.net/m.html#t // Attention, the original source of the example contains errors!
      {'input' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'expectedOutput' : '72150 69374 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838'},
      {'input' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '', 'expectedOutput' : '72150 69374 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838'},

      {'input' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '123456789', 'expectedOutput' : '84495 26164 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838'},
      {'input' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '12345abc678 9', 'expectedOutput' : '84495 26164 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838'},
      {'input' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '1234567891241482423845324843210661231386848632013858456748913489489561897489496156418974897001687952', 'expectedOutput' : '84495 26165 90784 11292 06143 78765 87333 81011 50722 87500 01277 86072 88853 55631 50110 57557 90054 07208 64450 09780'},
      {'input' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '12345678912414824238453248432106612313868486320138584567489134894895618974894961564189748970016879521234567891241482423845324843210661231386848632013858456748913489489561897489496156418974897001687952', 'expectedOutput' : '84495 26165 90784 11292 06143 78765 87333 81011 50722 87500 01277 86072 88853 55631 50110 57557 90054 07208 64450 09780'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}, keyOneTimePad: ${elem['keyOneTimePad']}', () {
        var _actual = encryptTapir(elem['input'] as String, elem['keyOneTimePad'] as String?);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Tapir.decryptTapir:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '05183', 'expectedOutput' : 'ABE'},
      {'input' : '51083', 'expectedOutput' : 'BEA'},
      {'input' : '510', 'expectedOutput' : 'BEA'},
      {'input' : '0', 'expectedOutput' : 'A'},
      {'input' : '51', 'expectedOutput' : 'BE'},
      {'input' : '52', 'expectedOutput' : 'C'},
      {'input' : '5274', 'expectedOutput' : 'CV'},

      //http://scz.bplaced.net/m.html#t // Attention, the original source of the example contains errors!
      {'input' : '72150 69374 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838', 'expectedOutput' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442'},
      {'input' : '72150 69374 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838', 'keyOneTimePad': '', 'expectedOutput' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442'},

      {'expectedOutput' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '123456789', 'input' : '84495 26164 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838'},
      {'expectedOutput' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '12345abc678 9', 'input' : '84495 26164 76646 97064 61829 94444 81721 50735 76969 67472 53821 12281 54069 76170 71472 63696 44646 10829 94444 22838'},
      {'expectedOutput' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '1234567891241482423845324843210661231386848632013858456748913489489561897489496156418974897001687952', 'input' : '84495 26165 90784 11292 06143 78765 87333 81011 50722 87500 01277 86072 88853 55631 50110 57557 90054 07208 64450 09780'},
      {'expectedOutput' : 'UEBSNVWOSTOK944UEBUNGSSPRUCH12DASWETTERUMSOROKA9442', 'keyOneTimePad': '12345678912414824238453248432106612313868486320138584567489134894895618974894961564189748970016879521234567891241482423845324843210661231386848632013858456748913489489561897489496156418974897001687952', 'input' : '84495 26165 90784 11292 06143 78765 87333 81011 50722 87500 01277 86072 88853 55631 50110 57557 90054 07208 64450 09780'},

      {'input': '38244 33832 25589 11665 58081 18200 22448 33377 89999 966', 'expectedOutput': 'N43 25.165\nE024 37.996'}
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}, keyOneTimePad: ${elem['keyOneTimePad']}', () {
        var _actual = decryptTapir(elem['input'] as String, elem['keyOneTimePad'] as String?);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}