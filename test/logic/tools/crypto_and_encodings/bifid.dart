import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bifid.dart';

void main() {
  // https://gc.de/gc/bifid/
  // https://www.dcode.fr/bifid-cipher
  // https://geocaching.dennistreysa.de/multisolver/
  //      does not work with 6x6 square
  // https://www.geocachingtoolbox.com/index.php?lang=en&page=bifidCipher
  // https://cryptii.com/pipes/bifid-cipher
  // http://rumkin.com/tools/cipher/bifid.php
  // http://kryptografie.de/kryptografie/chiffre/bifid.htm
  // https://www.braingle.com/brainteasers/codes/bifid.php
  // http://practicalcryptography.com/ciphers/classical-era/bifid/
  // https://www.cryptool.org/en/jcryptool
  //      supports only 5x5 square


  group("Bifid.encryptBifid:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // encryptBifid(_currentInput, _currentKey, mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentBifidAlphabetMode);
      //            Input
      //            PolybiosMode.AZ09, .ZA90, .CUSTOM
      //            alphabet
      //            BifidAlphabetMode.JToI, .CToK, WToVV

      // empty Input
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      //empty alphabet
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      //5x5 |  AZ09, ZA90, Custom | J-I, C-K, W-VV
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'expectedOutput' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'expectedOutput' : 'QDVCDOXHVXSODCEULPAOOFRBOGPXUKTJKFYTIFK'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'expectedOutput' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'expectedOutput' : 'QDVCDOXHVXSODCEULPAOOFRBOGPXUKTJKFYTIFK'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'ROLFZIDAXCNYYLZNGWFGTFDZNIDKHHMYAYCSWD'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFLUMTHYVRJ', 'alphabetMode': BifidAlphabetMode.CToK, 'expectedOutput' : 'TOUBZIDARLNVVUZNGWBHHIMKNIDVLYEUNYLSWM'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGVKZQPNDSIOAXEFCLUMTHYRJ', 'alphabetMode': BifidAlphabetMode.WToVV, 'expectedOutput' : 'JOLFZIGLEUPIEXIHIQXBSKGFCAIDRHHELAYCSVD'},

      // https://en.wikipedia.org/wiki/Bifid_cipher#:~:text=%20%20%20%20v%20t%20e%20Classical,Cryptogram%20Frequency%20analysis%20Index%20of%20c%20...%20
      {'input' : 'FLEEATONCE', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'UAEOLWRINS'},

      //6x6 |  AZ09, ZA90, Custom
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'TCTBCPMPJOUSMG2CJABH2OQLQLRUDCW44GUAGQ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'QGXFATKTNMSWPJZGG7FZE02X2X36PO8MMY6SY2'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZ0QPNDS2IOAXE4FCLUM6THYVR813579J', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'ROLFZIDA7CNYYLZNGWFGTFDZNID7HHMYAYCSWD'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}, alphabetMode: ${elem['alphabetMode']}', () {
        BifidOutput _actual = encryptBifid(elem['input'], elem['key'], mode: elem['mode'], alphabet: elem['alphabet'], alphabetMode: elem['alphabetMode']);
                    expect(_actual == null ? null : _actual.output, elem['expectedOutput']);
        });
    });
  });

  group("Bifid.decryptBifid:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // decryptBifid(_currentInput, _currentKey, mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentBifidAlphabetMode)
      //            Input
      //            PolybiosMode.AZ09, .ZA90, .CUSTOM
      //            alphabet
      //            BifidAlphabetMode.JTOI, .CTOK, WTOVV

      // empty Input
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      //empty alphabet
      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      //5x5 |  AZ09, ZA90, Custom | J-I, C-K, W-VV
      {'expectedOutput' : 'THEQUICKBROWNFOXIUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'expectedOutput' : 'THEQUIKKBROWNFOXJUMPSOVERALAZYDOGSBAKK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'input' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'expectedOutput' : 'THEQUICKBROVVNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'input' : 'QDVCDOXHVXSODCEULPAOOFRBOGPXUKTJKFYTIFK'},

      {'expectedOutput' : 'THEQUICKBROWNFOXIUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'expectedOutput' : 'THEQUIKKBROWNFOXJUMPSOVERALAZYDOGSBAKK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'input' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'expectedOutput' : 'THEQUICKBROVVNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'input' : 'QDVCDOXHVXSODCEULPAOOFRBOGPXUKTJKFYTIFK'},

      {'expectedOutput' : 'THEQUICKBROWNFOXIUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'ROLFZIDAXCNYYLZNGWFGTFDZNIDKHHMYAYCSWD'},
      {'expectedOutput' : 'THEQUIKKBROWNFOXJUMPSOVERALAZYDOGSBAKK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFLUMTHYVRJ', 'alphabetMode': BifidAlphabetMode.CToK, 'input' : 'TOUBZIDARLNVVUZNGWBHHIMKNIDVLYEUNYLSWM'},
      {'expectedOutput' : 'THEQUICKBROVVNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGVKZQPNDSIOAXEFCLUMTHYRJ', 'alphabetMode': BifidAlphabetMode.WToVV, 'input' : 'JOLFZIGLEUPIEXIHIQXBSKGFCAIDRHHELAYCSVD'},

      //6x6 |  AZ09, ZA90, Custom
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'TCTBCPMPJOUSMG2CJABH2OQLQLRUDCW44GUAGQ'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'QGXFATKTNMSWPJZGG7FZE02X2X36PO8MMY6SY2'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZ0QPNDS2IOAXE4FCLUM6THYVR813579J', 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'ROLFZIDA7CNYYLZNGWFGTFDZNID7HHMYAYCSWD'},

      // https://coord.info/GC8K32B
      {'expectedOutput' : 'DRAKENBURG', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'DBCDRREXKG'},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}, alphabetMode: ${elem['alphabetMode']}', () {
        BifidOutput _actual = decryptBifid(elem['input'], elem['key'], mode: elem['mode'], alphabet: elem['alphabet'], alphabetMode: elem['alphabetMode']);
        expect(_actual == null ? null : _actual.output, elem['expectedOutput']);
      });
    });
  });
}