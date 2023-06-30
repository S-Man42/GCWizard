part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsMathNestedFunctionsToExpected = [
  {'code' : 'print SQRT(SQR(10))', 'expectedOutput' : '10.0'},
  {'code' : 'print FAC(SQRT(SQR(10)))', 'expectedOutput' : '3628800.0'},
  {'code' : 'print POW(SQRT(4),SQR(2))', 'expectedOutput' : '16.0'},
];