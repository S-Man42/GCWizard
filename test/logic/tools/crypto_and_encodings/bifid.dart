import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

void main() {
  // https://gc.de/gc/bifid/
  // https://www.dcode.fr/bifid-cipher
  //      funktioniert bei 6x6 nicht
  // https://www.geocachingtoolbox.com/index.php?lang=en&page=bifidCipher
  // https://cryptii.com/pipes/bifid-cipher
  // http://rumkin.com/tools/cipher/bifid.php
  // http://kryptografie.de/kryptografie/chiffre/bifid.htm
  // https://www.braingle.com/brainteasers/codes/bifid.php
  // http://practicalcryptography.com/ciphers/classical-era/bifid/
  // https://www.cryptool.org/en/jcryptool
  //      hat nur 5x5


  group("Bifid.encryptBifid:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // encryptBifid(_currentInput, _currentKey, mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentBifidAlphabetMode);
      //            Input
      //            PolybiosMode.AZ09, .ZA90, .CUSTOM
      //            alphabet
      //            BifidAlphabetMode.JToI, .CToK, WToVV

      // empty Input
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},

      //empty alphabet
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      //5x5 |  AZ09, ZA90, Custom | J-I, C-K, W-VV
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'expectedOutput' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'expectedOutput' : 'RDRBDPYHJSOPDCEVMQAIPESXIALRJKOEFASTHFP'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'expectedOutput' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'expectedOutput' : 'QDVCDOXHVXSODCEULPAOOFRBOGPXUKTJKFYTIFK'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : 'ROLFZIDAXCNYYLZNGWFGTFDZNIDKHHMYAYCSWD'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.CToK, 'expectedOutput' : 'TOUBZIDARLNVVUZNGWBHHIMKNIDVLYEUNYLSWM'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.WToVV, 'expectedOutput' : 'TOLCQFYXFMNFFEOYOPEQZVHOCXIKVCCELNLOSGK'},

      //6x6 |  AZ09, ZA90, Custom
      //{'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : ''},
      //{'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : ''},
      //{'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
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
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},

      //empty alphabet
      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': BifidAlphabetMode.JToI, 'expectedOutput' : null},

      //5x5 |  AZ09, ZA90, Custom | J-I, C-K, W-VV
      {'expectedOutput' : 'THEQUICKBROWNFOXIUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'expectedOutput' : 'THEQUIKKBROWNFOXJUMPSOVERALAZYDOGSBAKK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'input' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'expectedOutput' : 'THEQUICKBROVVNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'input' : 'RDRBDPYHJSOPDCEVMQAIPESXIALRJKOEFASTHFP'},

      {'expectedOutput' : 'THEQUICKBROWNFOXIUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'expectedOutput' : 'THEQUIKKBROWNFOXJUMPSOVERALAZYDOGSBAKK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.CToK, 'input' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},
      {'expectedOutput' : 'THEQUICKBROVVNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.WToVV, 'input' : 'QDVCDOXHVXSODCEULPAOOFRBOGPXUKTJKFYTIFK'},

      {'expectedOutput' : 'THEQUICKBROWNFOXIUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'input' : 'ROLFZIDAXCNYYLZNGWFGTFDZNIDKHHMYAYCSWD'},
      {'expectedOutput' : 'THEQUIKKBROWNFOXJUMPSOVERALAZYDOGSBAKK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.CToK, 'input' : 'TOUBZIDARLNVVUZNGWBHHIMKNIDVLYEUNYLSWM'},
      {'expectedOutput' : 'THEQUICKBROVVNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.WToVV, 'input' : 'TOLCQFYXFMNFFEOYOPEQZVHOCXIKVCCELNLOSGK'},

      //6x6 |  AZ09, ZA90, Custom
      //{'expectedOutput' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : ''},
      //{'expectedOutput' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': BifidAlphabetMode.JToI, 'input' : ''},
      //{'expectedOutput' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': BifidAlphabetMode.JToI, 'input' : ''},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
        BifidOutput _actual = decryptBifid(elem['input'], elem['key'], mode: elem['mode'], alphabet: elem['alphabet'], alphabetMode: elem['alphabetMode']);
        expect(_actual == null ? null : _actual.output, elem['expectedOutput']);
      });
    });
  });
}