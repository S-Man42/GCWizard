part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsNestedLoopsToExpected = [
  {'code' : code_3_nested_repeat, 'expectedOutput' : '''1       1       1       1
1       1       2       2
1       1       3       3
1       2       1       2
1       2       2       4
1       2       3       6
1       3       1       3
1       3       2       6
1       3       3       9
2       1       1       2
2       1       2       4
2       1       3       6
2       2       1       4
2       2       2       8
2       2       3       12
2       3       1       6
2       3       2       12
2       3       3       18
3       1       1       3
3       1       2       6
3       1       3       9
3       2       1       6
3       2       2       12
3       2       3       18
3       3       1       9
3       3       2       18
3       3       3       27'''},
  {'code' : code_3_nested_while, 'expectedOutput' : '1\n2.0\n3.0'},
  {'code' : code_3_nested_for, 'expectedOutput' : '1\n3\n5'},

];

var code_3_nested_repeat = ''' 
a=1
repeat
  b=1
  repeat
    c=1
    repeat
      print a,b,c
      c=c+1
    until c>3
    b=b+1
  until b>3
  a=a+1
until a>3
end
''';

var code_3_nested_while = ''' 
a= 1
while a < 3
  b = 1
  while b < 3
    c = 1
    while c < 3
       print a, b, c
       c = c + 1
    wend   
    b = b + 1
  wend
  a = a + 1  
wend
end
''';

var code_3_nested_for = ''' 
for a = 1 to 3
  for b = 1 to 3 
    for c = 1 to 3
      print a, b, c
    next
  next
next    
end
''';

