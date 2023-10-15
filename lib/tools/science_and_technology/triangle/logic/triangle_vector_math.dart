part of 'package:gc_wizard/tools/science_and_technology/triangle/logic/triangle.dart';

XYPoint _vectorAB(XYPoint A, XYPoint B) {
  return XYPoint(x: B.x - A.x, y: B.y - A.y);
}

XYPoint _vectorAdd(XYPoint A, XYPoint B) {
  return XYPoint(
    x: A.x + B.x,
    y: A.y + B.y,
  );
}

XYPoint _vectorDiv(XYPoint A, double s) {
  return XYPoint(
    x: A.x / s,
    y: A.y / s,
  );
}

XYPoint _vectorMult(XYPoint A, double s) {
  return XYPoint(
    x: A.x * s,
    y: A.y * s,
  );
}

double _vectorProductDot(XYPoint A, XYPoint B) {
  return A.x * B.x + A.y * B.y;
}

bool _vectorEqual(XYPoint A, XYPoint B) {
  A = _vectorNormalize(A);
  B = _vectorNormalize(B);
  return (A.x == B.x && B.y == B.y);
}

double _vectorLength(XYPoint V) {
  return sqrt(V.x * V.x + V.y * V.y);
}

XYPoint _vectorNorm(XYPoint A) {
  return XYPoint(
    x: -A.y,
    y: A.x,
  );
}

XYPoint _vectorNormalize(XYPoint V) {
  double factor = _vectorLength(V);
  return XYPoint(
    x: V.x / factor,
    y: V.y / factor,
  );
}
