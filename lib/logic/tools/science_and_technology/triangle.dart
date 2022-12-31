import 'dart:math';

class XYZPoint{
  final double x;
  final double y;
  final double z;

  XYZPoint({this.x, this.y, this.z});
}

class XYZLine{
  final double m;
  final double a;
  final XYZPoint P1;
  final XYZPoint P2;

  XYZLine({this.m = 0, this.a = 0, this.P1, this.P2});
}

class XYZCircle{
  final double x;
  final double y;
  final double z;
  final double r;

  XYZCircle({this.x, this.y, this.z, this.r});
}


XYZPoint vector(XYZPoint a, XYZPoint b){
  return XYZPoint(x: b.x - a.x, y: b.y - a.y, z: b.z - a.z);
}

XYZPoint vectorAdd(XYZPoint a, XYZPoint b){
  return XYZPoint(
    x: a.x + b.x,
    y: a.y + b.y,
    z: a.z + b.z,
  );
}

XYZPoint vectorSub(XYZPoint a, XYZPoint b){
  return XYZPoint(
    x: a.x - b.x,
    y: a.y - b.y,
    z: a.z - b.z,
  );
}

XYZPoint vectorCossproduct(XYZPoint a, XYZPoint b){
  return XYZPoint(
    x: a.y * b.z - a.z * b.y,
    y: a.z * b.x - a.x * b.z,
    z: a.x * b.y - a.y * b.x,
  );
}

double vectorDotproduct(XYZPoint a, XYZPoint b){
  return a.x * b.x + a.y * b.y + a.z * b.z;
}

double lengthVector(XYZPoint v){
  return sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}

XYZPoint vectorNorm(XYZPoint a){
  return XYZPoint(
    x: - a.y,
    y: a.x,
    z: a.z,
  );
}

XYZPoint vectorCross(XYZLine L1, XYZLine L2){
  if (vectorLinearDependent(L1.P2, L2.P2))
    return null;

  try {
    double n = (L2.P1.y * L1.P2.x - L1.P1.y * L1.P2.x - L2.P1.x * L1.P2.y + L1.P1.x * L1.P2.y) / (L2.P2.x * L1.P2.y - L2.P2.y * L1.P2.x);
    double m = (L1.P1.y * L2.P2.x - L2.P1.y * L2.P2.x - L1.P1.x * L2.P2.y + L2.P1.x * L2.P2.y) / (L1.P2.x * L2.P2.y - L1.P2.y * L2.P2.x);

    if (L1.P1.z + m * L1.P2.z == L2.P1.z + n * L2.P2.z) {
      return XYZPoint(
        x: L1.P1.x + m * L1.P2.x,
        y: L1.P1.y + m * L1.P2.y,
        z: L1.P1.z + m* L1.P2.z
      );
    } else {
      return null;
    }

  } catch (e) {
    return null;
  }
}

bool vectorLinearDependent(XYZPoint a, XYZPoint b){
  try {
    if (a.z == 0 && b.z == 0)
      return (a.x / b.x == a.y / b.y);
    else
      return (a.x / b.x == a.y / b.y && a.y / b.y == a.z / b.z);
  } catch (e){
    return null;
  }
}

XYZPoint triangleSides(XYZPoint a, XYZPoint b, XYZPoint c,){
  return XYZPoint(
    x: lengthVector(vector(a, b)),
    y: lengthVector(vector(a, c)),
    z: lengthVector(vector(b, c)),
  );
}

XYZPoint triangleAngles(XYZPoint a, XYZPoint b, XYZPoint c,){
  // http://www.matheprofi.at/Winkel%20eines%20Dreiecks.pdf
  try {
    return XYZPoint(
        x: 180 /
            pi *
            acos(vectorDotproduct(vector(a, b), vector(a, c)) /
                lengthVector(vector(a, b)) /
                lengthVector(vector(a, c))),
        y: 180 /
            pi *
            acos(vectorDotproduct(vector(b, a), vector(b, c)) /
                lengthVector(vector(b, a)) /
                lengthVector(vector(b, c))),
        z: 180 /
            pi *
            acos(vectorDotproduct(vector(c, a), vector(c, b)) /
                lengthVector(vector(c, a)) /
                lengthVector(vector(c, b))));
  } catch (e) {
    return null;
  }
}

double triangleArea(XYZPoint a, XYZPoint b, XYZPoint c,){
  http://www.matheprofi.at/Fl%C3%A4che%20eines%20Dreiecks%20mit%20der%20trigonometrischen%20Fl%C3%A4chenformel.pdf
  XYZPoint angles = triangleAngles(a, b, c);
  return lengthVector(vector(a, c)) * lengthVector(vector(a, b)) * sin(angles.x ) / 2;
}

double triangleCircumference(XYZPoint a, XYZPoint b, XYZPoint c,){
  // http://www.matheprofi.at/Umfang%20eines%20Dreiecks.pdf
  XYZPoint sides = triangleSides(a, b, c);
  return sides.x + sides.y + sides.z;
}

XYZPoint triangleCentroid(XYZPoint a, XYZPoint b, XYZPoint c,){
  // http://www.matheprofi.at/Schwerpunkt%20eines%20Dreiecks.pdf
  return XYZPoint(
    x: (a.x + b.x + c.x) / 3,
    y: (a.y + b.y + c.y) / 3,
    z: (a.z + b.z + c.z) / 3
  );
}

XYZPoint triangleAltitude(XYZPoint a, XYZPoint b, XYZPoint c,){
  // http://www.matheprofi.at/H%C3%B6henschnittpunkt%20eines%20Dreiecks.pdf

  return vectorCross(
      XYZLine(P1: a, P2: vectorNorm(vector(b, c))),
      XYZLine(P1: b, P2: vectorNorm(vector(a, c))),
  );
}

XYZCircle triangleOuterCircle(XYZPoint a, XYZPoint b, XYZPoint c,){
  // http://www.matheprofi.at/Umkreismittelpunkt%20eines%20Dreiecks.pdf

  return XYZCircle(
    x: 0,
    y: 0,
    z: 0,
    r: 0,
  );
}

XYZCircle triangleInnerCircle(XYZPoint a, XYZPoint b, XYZPoint c,){
  // http://www.matheprofi.at/Inkreismittelpunkt%20eines%20Dreiecks.pdf

  return XYZCircle(
    x: 0,
    y: 0,
    z: 0,
    r: 0,
  );
}