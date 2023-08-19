part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsCryptoToExpected = [
  {'code' : 'a="HALLO"\nprint ABADDON(a, 1)', 'expectedOutput' : 'þµ¥¥¥µµ¥¥µ¥¥þþþ'},
  {'code' : 'a="þµ¥¥¥µµ¥¥µ¥¥þþþ"\nprint ABADDON(a, 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'a="HALLO"\nprint ATBASH(a)', 'expectedOutput' : 'SZOOL'},
  {'code' : 'a="SZOOL"\nprint ATBASH(a)', 'expectedOutput' : 'HALLO'},

  // It does not mak sense to test a function which is based on a random function
  // {'code' : 'a="HALLO"\nprint AVEMARIA(a, 1)', 'expectedOutput' : 'arbiter clemens immortalis immortalis gloriosus'},
  {'code' : 'a="arbiter clemens immortalis immortalis gloriosus"\nprint AVEMARIA(a, 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'a="HALLO"\nprint BACON(a, 1)', 'expectedOutput' : 'AABBBAAAAAABABAABABAABBAB'},
  {'code' : 'a="AABBBAAAAAABABAABABAABBAB"\nprint BACON(a, 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'a="HALLO"\nprint rot5(a)', 'expectedOutput' : 'HALLO'},
  {'code' : 'a="123"\nprint rot5(a)', 'expectedOutput' : '678'},
  {'code' : 'a="HALLO"\nprint rot13(a)', 'expectedOutput' : 'MFQQT'},
  {'code' : 'a="HALLO123"\nprint rot13(a)', 'expectedOutput' : 'MFQQT123'},
  {'code' : 'a="HALLO"\nprint rot18(a)', 'expectedOutput' : 'MFQQT'},
  {'code' : 'a="HALLO123"\nprint rot18(a)', 'expectedOutput' : 'MFQQT678'},
  {'code' : 'a="HALLO"\nprint rot47(a)', 'expectedOutput' : 'wp{{~'},
  {'code' : 'a="HALLO123"\nprint rot47(a)', 'expectedOutput' : 'wp{{~`ab'},
  {'code' : 'a="HALLO"\nprint rotx(a, 1)', 'expectedOutput' : 'IBMMP'},
  {'code' : 'a="HALLO123"\nprint rotx(a, 1)', 'expectedOutput' : 'IBMMP123'},

];