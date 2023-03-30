import 'dart:core';

int gcd(int a, int b) {
  int h;
  if (a == 0) return b.abs();
  if (b == 0) return a.abs();

  do {
    h = a % b;
    a = b;
    b = h;
  } while (b != 0);

  return a.abs();
}

int lcm(int a, int b){
  if (gcd(a, b) == 00) return 0;
  return (a * b).abs() ~/ gcd(a, b);
}