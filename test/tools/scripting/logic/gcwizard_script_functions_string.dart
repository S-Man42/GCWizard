part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsStringToExpected = [
  {'code' : 'print STR(10)', 'expectedOutput' : '10'},
  {'code' : 'print VAL(10)', 'expectedOutput' : '', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print VAL("10")', 'expectedOutput' : '10.0'},
  {'code' : 'print LEN(10)', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print LEN("10")', 'expectedOutput' : '2'},
  {'code' : 'print CHAR(10)', 'expectedOutput' : ''},
  {'code' : 'print ASC(10)', 'expectedOutput' : ''},
  {'code' : 'print LEFT(10)', 'expectedOutput' : ''},
  {'code' : 'print RIGHT(10)', 'expectedOutput' : ''},
  {'code' : 'print MID(10)', 'expectedOutput' : '', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print MID(10, 5)', 'expectedOutput' : '', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print MID("MIDTEST", 4, 4)', 'expectedOutput' : 'TEST'},
];