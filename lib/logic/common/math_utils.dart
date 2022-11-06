import 'dart:math';

/// The smallest positive [double] value that is greater than zero.
const double epsilon = 4.94065645841247E-324;

/// Hyperbolic Sine.
double sinh(double angle) {
  return (exp(angle) - exp(-angle)) / 2;
}