part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsCryptoToExpected = [
  {'code' : 'print ABADDON("HALLO", 1)', 'expectedOutput' : 'þµ¥¥¥µµ¥¥µ¥¥þþþ'},
  {'code' : 'print ABADDON("þµ¥¥¥µµ¥¥µ¥¥þþþ", -1)', 'expectedOutput' : 'HALLO'},

  {'code' : 'print ATBASH("HALLO")', 'expectedOutput' : 'SZOOL'},
  {'code' : 'print ATBASH("SZOOL")', 'expectedOutput' : 'HALLO'},

  {'code' : 'print BACON("HALLO", 1)', 'expectedOutput' : 'AABBBAAAAAABABAABABAABBAB'},
  {'code' : 'print BACON("AABBBAAAAAABABAABABAABBAB", -1)', 'expectedOutput' : 'HALLO'},

];