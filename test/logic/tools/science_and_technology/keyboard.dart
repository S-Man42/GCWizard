import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/keyboard.dart';

void main() {
  String inputString = 'abcdefghijklmnopqrstuvwxyzäöüABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ1234567890';

  group("Keyboard.null:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : '', 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.QWERTZ_T1, 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.QWERTZ_T1:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : inputString},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'abcdefghijklmnopqrstuvwxzy\';[ABCDEFGHIJKLMNOPQRSTUVWXZY":{1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'axje.uidchtnmbrl\'poygk,q;f-s/AXJE>UIDCHTNMBRL"POYGK<Q:F_S?`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'axje.iuhcdrnmbtzüpoygk,qöfls?AXJE:IUHCDRNMBTZÜPOYGK;QÖFLSß1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'abke.uidchtnwmrläpoygx,jüfßsqABKE:UIDCHTNWMRLÄPOYGX;JÜF?SQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'abkeäuidchtnwmrlöpoygxüj,fßsABKEÄUIDCHTNWMRLÖPOYGXÜJ;F?SQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'abkeüuidchtnwmrläpoygxöj,fßsABKEÜUIDCHTNWMRLÄPOYGXÖJ;F?SQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zkgarniudehsüäwjqolctmpvxbyföZKGARNIUDEHSÜÄWJQOLCTMPVXBYFÖ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'abcsftdhuneimky;qprglvwxzj\'o[ABCSFTDHUNEIMKY:QPRGLVWXZJ"O{1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uzäaleosgnrtmbfqxciwhpvöükydßUZÄALEOSGNRTMBFQXCIWHPVÖÜKYDẞ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qbcdefghijkl.noparstuvzxwy/m-QBCDEFGHIJKL?NOPARSTUVZXWY\\M_àéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTZ_T1, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'a.yipe,cdtsr\'kljbouèvxéàw^mnzA:YIPE;CDTSR?KLJBOUÈVXÉÀW!MNZ"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.QWERTY_US_INT:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'abcdefghijklmnopqrstuvwxzyABCDEFGHIJKLMNOPQRSTUVWXZY1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'axje.uidchtnmbrl\'poygk,qf;AXJE>UIDCHTNMBRL"POYGK<QF:`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'axje.iuhcdrnmbtzüpoygk,qföAXJE:IUHCDRNMBTZÜPOYGK;QFÖ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'abke.uidchtnwmrläpoygx,jfüABKE:UIDCHTNWMRLÄPOYGX;JFÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'abkeäuidchtnwmrlöpoygxüjf,ABKEÄUIDCHTNWMRLÖPOYGXÜJF;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'abkeüuidchtnwmrläpoygxöjf,ABKEÜUIDCHTNWMRLÄPOYGXÖJF;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'abcsftdhuneimky;qprglvwxjzABCSFTDHUNEIMKY:QPRGLVWXJZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uzäaleosgnrtmbfqxciwhpvöküUZÄALEOSGNRTMBFQXCIWHPVÖKÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zkgarniudehsüäwjqolctmpvbxZKGARNIUDEHSÜÄWJQOLCTMPVBX1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qbcdefghijkl.noparstuvzxywQBCDEFGHIJKL?NOPARSTUVZXYWàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.QWERTY_US_INT, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'a.yipe,cdtsr\'kljbouèvxéà^wA:YIPE;CDTSR?KLJBOUÈVXÉÀ!W"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.Dvorak:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'anihdzujgcvpmlsrxoökf.,bt-ANIHDZUJGCVPMLSRXOÖKF:;BT_234567890ß'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'anihdyujgcvpmlsrxo;kf.,bt/ANIHDYUJGCVPMLSRXO:KF><BT?234567890-'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'abchefgdujkzmnopqtsrivwxy\'ABCHEFGDUJKZMNOPQTSRIVWXY#234567890+'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'amcdefghikxlwnopjrstuzvbyAMCDEFGHIKXLWNOPJRSTUZVBY234567890+'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'amcdefghikxlwnopjrstuzvbyAMCDEFGHIKXLWNOPJRSTUZVBY234567890+'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'amcdefghikxlwnopjrstuzvbyAMCDEFGHIKXLWNOPJRSTUZVBY234567890+'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'akuhsjlndcv;mirpxyoet.,bg/AKUHSJLNDCV:MIRPXYOET><BG?234567890-'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'ubgsakhnoäpqmticöfdre.,zwjUBGSAKHNOÄPQMTICÖFDRE·-ZWJ234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zäduabteigmjüslovwfhn,ßkc.ZÄDUABTEIGMJÜSLOVWFHN;?KC:234567890-'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qnihdyujgcvp.lsrxomkf:,bt;QNIHDYUJGCVP?LSRXOMKF…!BT=éèê()ߵߴ«»\''},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'akdci^vt,yxj\'ruoàlnsehg.èfAKDCI!VT;YXJ?RUOÀLNSEHG:ÈF«»()@+-/*='},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.Dvorak_II_DEU:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'anijdzuhfcvämlsrxköog.,btp<yqANIJDZUHFCVÄMLSRXKÖOG:;BTP>YQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'anijdyuhfcv\'mlsrxk;og.,btpzqANIJDYUHFCV"MLSRXK:OG><BTPZQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'abchefgdujk-mnopqtsrivwxyl;\'ABCHEFGDUJK_MNOPQTSRIVWXYL:"`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'amchefgdukxßwnopjtsrizvbylöüäAMCHEFGDUKX?WNOPJTSRIZVBYLÖÜÄ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'amchefgdukxßwnopjtsrizvbyl.,öAMCHEFGDUKX?WNOPJTSRIZVBYL:;Ö1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'amchefgdukxßwnopjtsrizvbyl.,äAMCHEFGDUKX?WNOPJTSRIZVBYL:;Ä1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'akunsjlhtcv\'mirpxeoyd.,bg;zqAKUNSJLHTCV"MIRPXEOYD><BG:ZQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'ubgnakhseäpymticördfo.,zwqüxUBGNAKHSEÄPYMTICÖRDFO·-ZWQÜX1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zädeabtungmyüslovhfwi,ßkcj<xqZÄDEABTUNGMYÜSLOVHFWI;?KCJ>XQ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qnijdyuhfcv/.lsrxkmog:,btp<waQNIJDYUHFCV\\?LSRXKMOG…!BTP>WAàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_II_DEU, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'akdti^vceyxm\'ruoàsnl,hg.èjêwbAKDTI!VCEYXM?RUOÀSNL;HG:ÈJÊWB"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.Dvorak_I_DEU1:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
	  {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.QWERTZ_T1,       'expectedOutput' : 'abihdzujgxcpnlsrüoökf,mvt.q<yABIHDZUJGXCPNLSRÜOÖKF;MVT:Q>Y1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'abihdyujgxcpnlsr[o;kf,mvt.qzABIHDYUJGXCPNLSR{O:KF<MVT>QZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'axcdefghiqjlbnop/rstuwmkyv\';AXCDEFGHIQJLBNOP?RSTUWMKYV":`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'axchefgduqjzbnop?tsriwmkyvüäöAXCHEFGDUQJZBNOPßTSRIWMKYVÜÄÖ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'abcdefghijklmnoprstuvwxyzö.,ABCDEFGHIJKLMNOPQRSTUVWXYZÖ:;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'abcdefghijklmnoprstuvwxyzä.,ABCDEFGHIJKLMNOPQRSTUVWXYZÄ:;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'abuhsjlndxc;kirp[yoet,mvg.qzABUHSJLNDXC:KIRP{YOET<MVG>QZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uzgsakhnoöäqbticßfdre,mpw.xüUZGSAKHNOÖÄQBTICẞFDRE-MPW·XÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zkduabteivgjäsloöwfhnßümc,q<xZKDUABTEIVGJÄSLOÖWFHN?ÜMC;Q>X1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qbihdyujgxcpnlsr-omkf,.vt:a<wQBIHDYUJGXCPNLSR_OMKF!?VT…A>Wàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU1, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'a.dci^vt,àyjkruozlnseg\'xèhbêwA:DCI!VT;ÀYJKRUOZLNSEG?XÈHBÊW"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.Dvorak_I_DEU2:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'abihdzujgxcpnlsr#oökf,mvt.eqwABIHDZUJGXCPNLSRÜOÖKF;MVT:EQW1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'abihdyujgxcpnlsro;kf,mvt.eqwABIHDYUJGXCPNLSR{O:KF<MVT>EQW1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'axcdefghiqjlbnoprstuwmkyv.\',AXCDEFGHIQJLBNOP?RSTUWMKYV>"<`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'axchefgduqjzbnop-tsriwmkyv.ü,AXCHEFGDUQJZBNOPßTSRIWMKYV:Ü;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'abcdefghijklmnop-rstuvwxyz.ä,ABCDEFGHIJKLMNOPQRSTUVWXYZ:Ä;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzäöüABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzüäöABCDEFGHIJKLMNOPQRSTUVWXYZÜÄÖ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'abuhsjlndxc;kirpyoet,mvg.fqwABUHSJLNDXC:KIRP{YOET<MVG>FQW1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uzgsakhnoöäqbticfdre,mpw.lxvUZGSAKHNOÖÄQBTICẞFDRE-MPW·LXV1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zkduabteivgjäslo#wfhnßümc,rqpZKDUABTEIVGJÄSLOÖWFHN?ÜMC;RQP1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qbihdyujgxcpnlsr*omkf,.vt:eazQBIHDYUJGXCPNLSR_OMKF!?VT…EAZàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU2, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'a.dci^vt,àyjkruoçlnseg\'xèhpbéA:DCI!VT;ÀYJKRUOZLNSEG?XÈHPBÉ"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.Dvorak_I_DEU3:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'abihdzujgxcpnlsr#oökf,mvt.qweABIHDZUJGXCPNLSRÜOÖKF;MVT:QWE1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'abihdyujgxcpnlsro;kf,mvt.qweABIHDYUJGXCPNLSR{O:KF<MVT>QWE1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'axcdefghiqjlbnoprstuwmkyv\',.AXCDEFGHIQJLBNOP?RSTUWMKYV"<>`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'axchefgduqjzbnop-tsriwmkyvü,.AXCHEFGDUQJZBNOPßTSRIWMKYVÜ;:1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'abcdefghijklmnop-rstuvwxyzä,.ABCDEFGHIJKLMNOPQRSTUVWXYZÄ;:1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzöüäABCDEFGHIJKLMNOPQRSTUVWXYZÖÜÄ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzäöüABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'abuhsjlndxc;kirpyoet,mvg.qwfABUHSJLNDXC:KIRP{YOET<MVG>QWF1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uzgsakhnoöäqbticfdre,mpw.xvlUZGSAKHNOÖÄQBTICẞFDRE-MPW·XVL1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zkduabteivgjäslo#wfhnßümc,qprZKDUABTEIVGJÄSLOÖWFHN?ÜMC;QPR1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qbihdyujgxcpnlsr*omkf,.vt:azeQBIHDYUJGXCPNLSR_OMKF!?VT…AZEàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.Dvorak_I_DEU3, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'a.dci^vt,àyjkruoçlnseg\'xèhbépA:DCI!VT;ÀYJKRUOZLNSEG?XÈHBÉP"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.COLEMAK:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'abcgkethlznumjörqsdfivwxoyABCGKETHLZNUMJÖRQSDFIVWXOY1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'abcgkethlynumj;rqsdfivwxozABCGKETHLYNUMJ:RQSDFIVWXOZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'axjit.ydnfbgmhsp\'oeuck,qr;AXJIT>YDNFBGMHSP"OEUCK<QR:`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'axjur.yhnfbgmdspüoeick,qtöAXJUR:YHNFBGMDSPÜOEICK;QTÖ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'abkit.ydnfmgwhspäoeucx,jrüABKIT:YDNFMGWHSPÄOEUCX;JRÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'abkitäydnfmgwhspöoeucxüjr,ABKITÄYDNFMGWHSPÖOEUCXÜJR;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'abkitüydnfmgwhspäoeucxöjr,ABKITÜYDNFMGWHSPÄOEUCXÖJR;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uzäorlwstkbhmndcxiaegpvöfüUZÄORLWSTKBHMNDCXIAEGPVÖFÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zkgihrcusbätüefoqlandmpvwxZKGIHRCUSBÄTÜEFOQLANDMPVWX1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qbcgkethlynu.jmrasdfivzxowQBCGKETHLYNU?JMRASDFIVZXOWàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.COLEMAK, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'a.y,spècr^kv\'tnobuiedxéàlwA:Y;SPÈCR!KV?TNOBUIEDXÉÀLW"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.NEO:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'dnröfoius-zemjgvpkhlawtqäbcxyDNRÖFOIUS_ZEMJGVPKHLAWTQÄBCXY1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'dnr;foius/yemjgvpkhlawtq\'bcxzDNR:FOIUS?YEMJGVPKHLAWTQ"BCXZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'ebpsurcgozf.mhikltdna,y\'-xjq;EBPSURCGOZF>MHIKLTDNA<Y"_XJQ:`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'ebpsitcgo\'f.mdukzrhna,yülxjqöEBPSITCGO#F:MDUKZRHNA;YÜLXJQÖ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'empsurcgof.whixltdna,yäßbkjüEMPSURCGOF:WHIXLTDNA;YÄ?BKJÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'empsurcgofäwhixltdnaüyößbkj,EMPSURCGOFÄWHIXLTDNAÜYÖ?BKJ;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'empsurcgofüwhixltdnaöyäßbkj,EMPSURCGOFÜWHIXLTDNAÖYÄ?BKJ;1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'skpotyulr/jfmndv;ehiawgq\'bcxzSKPOTYULR?JFMNDV:EHIAWGQ"BCXZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzäöüABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'aäofnwdtl.brüeimjhuszpcqykgvxAÄOFNWDTL:BRÜEIMJHUSZPCQYKGVX1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'dnrmfoius;ye.jgvpkhlqzta/bcxwDNRMFOIUS=YE?JGVPKHLQZTA\\BCXWàéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.NEO, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'ikoneldvuf^p\'t,xjscraéèbm.yàwIKONELDVUF!P?T;XJSCRAÉÈBM:YÀW"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.RISTOME:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'dztijöckgpbsvfrwqeluhxoyäanümDZTIJÖCKGPBSVFRWQELUHXOYÄANÜM1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'dytij;ckgpbsvfrwqeluhxoz\'an[mDYTIJ:CKGPBSVFRWQELUHXOZ"AN{M1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'efychsjtilxokup,\'.ngdqr;-ab/mEFYCHSJTILXOKUP<">NGDQR:_AB?M`123456789'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'efycdsjruzxokip,ü.nghqtölab?mEFYCDSJRUZXOKIP;Ü:NGHQTÖLABßM1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'efychsktilboxup,ä.ngdjrüßamqwEFYCHSKTILBOXUP;Ä:NGDJRÜ?AMQW1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'efychsktilboxupüöängdjr,ßamwEFYCHSKTILBOXUPÜÖÄNGDJR;?AMQW1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'efychsktilboxupöäüngdjr,ßamwEFYCHSKTILBOXUPÖÄÜNGDJR;?AMQW1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'sjgunoced;brvtpwqfilhxyz\'ak[mSJGUNOCED:BRVTPWQFILHXYZ"AK{M1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'akwgndäroqzipecvxlthsöfüyubßmAKWGNDÄROQZIPECVXLTHSÖFÜYUBẞM1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzäöüABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'dytijmckgpbsvfrzaeluhxow/qn-.DYTIJMCKGPBSVFRZAELUHXOW\\QN_?àéèê()ߵߴ«»'},
      {'input' : inputString, 'from' : enumKeyboardLayout.RISTOME, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'i^èdtnys,j.uxeoébprvcàlwmakz\'I!ÈDTNYS;J:UXEOÉBPRVCÀLWMAKZ?"«»()@+-/*'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.FRA_AZERTY:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'qbcdefghijklönoparstuvyxzwQBCDEFGHIJKLÖNOPARSTUVYXZW!"§\$%&/()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'qbcdefghijkl;noparstuvzxywQBCDEFGHIJKL:NOPARSTUVZXYW!@#\$%^&*()'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : '\'xje.uidchtnsbrlapoygk;qf,"XJE>UIDCHTNSBRLAPOYGK:QF<~!@#\$%^&*('},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'üxje.iuhcdrnsbtzapoygköqf,ÜXJE:IUHCDRNSBTZAPOYGKÖQF;!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'äbke.uidchtnsmrlapoygxüjf,ÄBKE:UIDCHTNSMRLAPOYGXÜJF;!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'öbkeäuidchtnsmrlapoygx,jfüÖBKEÄUIDCHTNSMRLAPOYGX;JFÜ!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'äbkeüuidchtnsmrlapoygx,jföÄBKEÜUIDCHTNSMRLAPOYGX;JFÖ!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'qbcsftdhuneioky;aprglvzxjwQBCSFTDHUNEIOKY:APRGLVZXJW!@#\$%^&*()'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'xzäaleosgnrtdbfquciwhpüökvXZÄALEOSGNRTDBFQUCIWHPÜÖKV°§ℓ»«\$€„“”'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'qkgarniudehsfäwjzolctmxvbpQKGARNIUDEHSFÄWJZOLCTMXVBP!"§\$%&/()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_AZERTY, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'b.yipe,cdtsrnkljaouèvxwà^éB:YIPE;CDTSRNKLJAOUÈVXWÀ!É1234567890'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Keyboard.FRA_BEPO:", () {
	List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.QWERTZ_T1,     'expectedOutput' : 'aqhif-,.dpnoäörelkjsuyvcüAQHIF_;:DPNOÄÖRELKJSUYVCÜ!"§\$%&/()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.QWERTY_US_INT, 'expectedOutput' : 'aqhif/,.dpno\';relkjsuzvc[AQHIF?<>DPNO":RELKJSUZVC{!@#\$%^&*()'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.Dvorak,        'expectedOutput' : 'a\'dcuzwvelbr-sp.nthog;kj/A"DCUZWVELBR_SP>NTHOG:KJ?~!@#\$%^&*('},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.Dvorak_II_DEU, 'expectedOutput' : 'aühci\'wvezbtlsp.nrdogökj?AÜHCI#WVEZBTLSP:NRDOGÖKJß!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.Dvorak_I_DEU1, 'expectedOutput' : 'aädcuvzelmrßsp.nthogüxkqAÄDCUVZELMR?SP:NTHOGÜXKQ!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.Dvorak_I_DEU2, 'expectedOutput' : 'aödcuvzelmrßspänthog,xkAÖDCUVZELMR?SPÄNTHOG;XKQ!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.Dvorak_I_DEU3, 'expectedOutput' : 'aädcuvzelmrßspünthog,xkAÄDCUVZELMR?SPÜNTHOG;XKQ!"§\$%&()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.COLEMAK,       'expectedOutput' : 'aqhut/,.s;ky\'opfienrlzvc[AQHUT?<>S:KY"OPFIENRLZVC{!@#\$%^&*()'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.NEO,           'expectedOutput' : 'uxsgej,.aqbfydcltrnihüpäßUXSGEJ-·AQBFYDCLTRNIHÜPÄẞ°§ℓ»«\$€„“”'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.RISTOME,       'expectedOutput' : 'zqudn.ß,ajäwyforsheltxmgöZQUDN:?;AJÄWYFORSHELTXMGÖ!"§\$%&/()='},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.FRA_AZERTY,    'expectedOutput' : 'qahif;,:dpno/mrelkjsuwvc-QAHIF=!…DPNO\\MRELKJSUWVC_1234567890'},
      {'input' : inputString, 'from' : enumKeyboardLayout.FRA_BEPO, 'to' : enumKeyboardLayout.FRA_BEPO,      'expectedOutput' : 'abcdefghijklmnoprstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ1234567890'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}