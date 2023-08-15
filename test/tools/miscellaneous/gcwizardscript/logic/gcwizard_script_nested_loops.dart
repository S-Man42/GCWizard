part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsNestedLoopsToExpected = [
  {'code' : code_3_nested_repeat, 'expectedOutput' :output_1},
  {'code' : code_3_nested_while, 'expectedOutput' : output_1},
  {'code' : code_3_nested_for, 'expectedOutput' : output_1},
  {'code' : code_nested_for_while_repeat, 'expectedOutput' : output_1},
  {'code' : code_nested_for_repeat_while, 'expectedOutput' : output_1},

  {'code' : code_nested_for_repeatwhile, 'expectedOutput' : output_2},

  {'code' : code_nested_for_repeatwhilewhile, 'expectedOutput' : output_3},
];

var output_1 =  '''1       1       1
1       1       2
1       1       3
1       2       1
1       2       2
1       2       3
1       3       1
1       3       2
1       3       3
2       1       1
2       1       2
2       1       3
2       2       1
2       2       2
2       2       3
2       3       1
2       3       2
2       3       3
3       1       1
3       1       2
3       1       3
3       2       1
3       2       2
3       2       3
3       3       1
3       3       2
3       3       3''';
var output_2 =  '''1       2       1
1       3       1
1       4       1
1       4       1
1       4       2
1       4       3
2       2       1
2       3       1
2       4       1
2       4       1
2       4       2
2       4       3
3       2       1
3       3       1
3       4       1
3       4       1
3       4       2
3       4       3''';
var output_3 =  '''1       2       1       1
1       2       1       2
1       2       1       3
1       3       1       1
1       3       1       2
1       3       1       3
1       4       1       1
1       4       1       2
1       4       1       3
1       4       1       4
1       4       2       4
1       4       3       4
2       2       1       1
2       2       1       2
2       2       1       3
2       3       1       1
2       3       1       2
2       3       1       3
2       4       1       1
2       4       1       2
2       4       1       3
2       4       1       4
2       4       2       4
2       4       3       4
3       2       1       1
3       2       1       2
3       2       1       3
3       3       1       1
3       3       1       2
3       3       1       3
3       4       1       1
3       4       1       2
3       4       1       3
3       4       1       4
3       4       2       4
3       4       3       4''';

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
var code_nested_for_while_repeat = ''' 
for a = 1 to 3
  b=1
  while b < 4
    c = 1
    repeat 
      print a, b, c
      c = c + 1
    until c = 4
    b = b +1
  wend
next    
end
''';
var code_nested_for_repeat_while = ''' 
for a = 1 to 3
  b=1
  repeat
    c = 1
    while c < 4 
      print a, b, c
      c = c + 1
    wend
    b = b +1
  until b = 4
next    
end
''';

var code_nested_for_repeatwhile = ''' 
for a = 1 to 3
  b = 1
  c = 1
  repeat
    b = b +1
    d = 1
    while d < 4
       print a, b, c, d
       d = d + 1
    wend   
  until b = 4
  while c < 4 
    print a, b, c, d
    c = c + 1
  wend
next    
end
''';

var code_nested_for_repeatwhilewhile = ''' 
for a = 1 to 3
  b = 1
  c = 1
  repeat
    b = b +1
    d = 1
    while d < 4
       print a, b, c, d
       d = d + 1
    wend   
  until b = 4
  while c < 4 
    print a, b, c, d
    c = c + 1
  wend
next    
end
''';