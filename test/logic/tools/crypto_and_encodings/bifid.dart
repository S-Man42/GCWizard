import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

void main() {
  group("Bifid.encryptBifid:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'expectedOutput' : 'RERGSXCDWSOPEDFVMQBRQXWJIYOWXQRAFSQMCF'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'expectedOutput' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.right, 'expectedOutput' : 'ROLFZIDAUPEEXIHIQXBSKGFHAGUHHMYAYCSWD'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : 'ROLFZIDAXCNYYLZNGWFGTFDZNIDKHHMYAYCSWD'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : 'TCTBCPMPJOUSMG2CJABH2OQLQLRUDCW44GUAGQ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : 'QGXFATKTNMSWPJZGG7FZE02X2X36PO8MMY6SY2'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : 'HAMAZPDD1MNT0EKNGWAFLZ1B6S5PPV6B42LSB1'},

      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'expectedOutput' : 'TCTBCPMPJOUSMG2CJABH2OQLQLRUDCW44GUAGQ'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'expectedOutput' : 'QGXFATKTNMSWPJZGG7FZE02X2X36PO8MMY6SY2'},
      {'input' : 'THE QUICK BROWN FOX JUMPS OVER A LAZY DOGS BACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.right, 'expectedOutput' : 'HAMAZPDD1MNT0EKNGWAFLZ1B6S5PPV6B42LSB1'},
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
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': '', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP', 'key': 'ABCDE', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'QWERTZUIOPA', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},
      {'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP', 'key': 'ABCDE', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'AAAAAAAAAAAAAAAAAAAAAAAAA', 'alphabetMode': GCWSwitchPosition.left, 'expectedOutput' : null},

      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'input' : 'RDRBDPMPSOPDCEVMJQAIPESWIHDPKOEFAYTHFP'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'input' : 'RERGSXCDWSOPEDFVMQBRQXWJIYOWXQRAFSQMCF'},

      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'input' : 'RDRBDPMPINSVQLZCIABSVYPGRLSUKOEFAYTHFP'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'input' : 'RERHEPLPJNSVQLZDJAHRQXZHRPSUKOEGAYODGZ'},

      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.right, 'input' : 'ROLFZIDAUPEEXIHIQXBSKGFHAGUHHMYAYCSWD'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '12345', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.left, 'input' : 'ROLFZIDAXCNYYLZNGWFGTFDZNIDKHHMYAYCSWD'},

      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'input' : 'TCTBCPMPJOUSMG2CJABH2OQLQLRUDCW44GUAGQ'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.left, 'input' : 'QGXFATKTNMSWPJZGG7FZE02X2X36PO8MMY6SY2'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.left, 'input' : 'HAMAZPDD1MNT0EKNGWAFLZ1B6S5PPV6B42LSB1'},

      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'input' : 'TCTBCPMPJOUSMG2CJABH2OQLQLRUDCW44GUAGQ'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.ZA90, 'alphabet': null, 'alphabetMode': GCWSwitchPosition.right, 'input' : 'QGXFATKTNMSWPJZGG7FZE02X2X36PO8MMY6SY2'},
      {'expectedOutput' : 'THEQUICKBROWNFOXJUMPSOVERALAZYDOGSBACK', 'key': '123456', 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BGWKZQPNDSIOAXEFCLUMTHYVR', 'alphabetMode': GCWSwitchPosition.right, 'input' : 'HAMAZPDD1MNT0EKNGWAFLZ1B6S5PPV6B42LSB1'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
        BifidOutput _actual = decryptBifid(elem['input'], elem['key'], mode: elem['mode'], alphabet: elem['alphabet'], alphabetMode: elem['alphabetMode']);
        expect(_actual == null ? null : _actual.output, elem['expectedOutput']);
      });
    });
  });
}