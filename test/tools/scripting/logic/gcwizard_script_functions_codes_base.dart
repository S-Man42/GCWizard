part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsBaseToExpected = [
  {'code' : 'print BASE(16, 0, "30")', 'expectedOutput' : '0'},
  {'code' : 'print BASE(16, 0, "3A")', 'expectedOutput' : ':'},
  {'code' : 'print BASE(16, 1, "0")', 'expectedOutput' : '30'},
  {'code' : 'print BASE(16, 1, ":")', 'expectedOutput' : '3a'},

  {'code' : 'print BASE(32, 0, "GA======")', 'expectedOutput' : '0'},
  {'code' : 'print BASE(32, 0, "HI======")', 'expectedOutput' : ':'},
  {'code' : 'print BASE(32, 1, "0")', 'expectedOutput' : 'GA======'},
  {'code' : 'print BASE(32, 1, ":")', 'expectedOutput' : 'HI======'},


  {'code' : 'print BASE(58, 0, "3")', 'expectedOutput' : '2'},
  {'code' : 'print BASE(58, 0, "3A")', 'expectedOutput' : '125'},
  {'code' : 'print BASE(58, 1, "2")', 'expectedOutput' : '3'},
  {'code' : 'print BASE(58, 1, "125")', 'expectedOutput' : '3A'},
];