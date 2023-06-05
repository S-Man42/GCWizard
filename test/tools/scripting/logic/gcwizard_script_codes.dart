part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsCodesToExpected = [
  {'code' : code1, 'expectedOutput' : '1       2.0     9.0     6.0'},
];

var code1 = ''' 
REM https://www.geocaching.com/geocache/GC98G??
for z = 1 to 9
 for a = 1 to 9
  for h = 1 to 9
   for l = 0 to 9
    c = 0
    u = z*1000 + a*100 + h*10 + l
    v = a*1000 + h*100 + z*10 + l
    w = h*1000 + a*100 + z*10 + l
    e=sqrt(u)
    f=sqrt(v)
    g=sqrt(w)
    k = frac(e)
    i = frac(f)
    j = frac(g)
    if k=0 then c=c+1
    endif
    if i=0 then c=c+1
    endif
    if j=0 then c=c+1
    endif
    if c=3 then print z,a,h,l
    endif
   next
  next
 next
next
end
''';