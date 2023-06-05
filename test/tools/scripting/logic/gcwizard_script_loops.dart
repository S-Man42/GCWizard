part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsLoopsToExpected = [
  {'code' : code1l, 'expectedOutput' : '1\n2.0\n3.0'},
  {'code' : code2l, 'expectedOutput' : '1\n2.0\n3.0'},
  {'code' : code3l, 'expectedOutput' : '1\n3\n5'},
  {'code' : code4l, 'expectedOutput' : '1\n2.0\n3.0'},
  {'code' : code5l, 'expectedOutput' : '1\n2.0\n3.0'},
];

var code1l = ''' 
for b = 1 to 3
  print b
next
end
''';

var code2l = ''' 
b = 1
while b < 4
  print b
  b = b + 1
wend
end
''';

var code3l = ''' 
for b = 1 to 6 step 2
  print b
next
end
''';

var code4l = ''' 
for b = 1 to 6
  print b
  if b = 3 exit
next
end
''';

var code5l = ''' 
b = 1
do
  print b
  b = b + 1
  if b = 3 exit
loop
end
''';