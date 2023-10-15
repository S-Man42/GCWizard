import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:gc_wizard/utils/collection_utils.dart';

part 'package:gc_wizard/tools/science_and_technology/triangle/logic/triangle_classes.dart';
part 'package:gc_wizard/tools/science_and_technology/triangle/logic/triangle_vector_math.dart';


XYPoint TriLinearToXYPoint(TriLinearPoint P, XYPoint A, XYPoint B, XYPoint C) {
  // https://mathworld.wolfram.com/TrilinearCoordinates.html

  Sides s = triangleSides(A, B, C);
  XYPoint av = _vectorNormalize(_vectorAB(B, C));
  double a1 = av.x;
  double a2 = av.y;
  XYPoint cv = _vectorNormalize(_vectorAB(A, B));
  double c1= cv.x;
  double c2 = cv.y;
  double a = P.x;
  double c = P.z;
  double k = 2 * triangleArea(A, B, C) / (P.x * s.a + P.y * s.b + P.z * s.c);
  double lc = (k * a - c * k * (a1 * c1 + a2 * c2) + a2 * (A.x - C.x) + a1 * (C.y - A.y)) / (a1 * c2 - a2 * c1);

  return XYPoint(
      x: A.x + lc * c1 - k * P.z * c2,
      y: A.y + lc * c2 + k * P.z * c1
  );
}




XYPoint intersectVectors(XYLine L1, XYLine L2){
  if (_vectorEqual(L1.P2, L2.P2)) {
    return XYPoint(x: 0, y: 0);
  }

  // return
  // XYPoint(
  //   x: (L2.a - L1.a) / (L1.m - L2.m),
  //   y: L1.m * (L2.a - L1.a) / (L1.m - L2.m) + L1.a
  // );

  try {
    double m = (L1.P1.y * L2.P2.x - L2.P1.y * L2.P2.x - L1.P1.x * L2.P2.y + L2.P1.x * L2.P2.y) / (L1.P2.x * L2.P2.y - L1.P2.y * L2.P2.x);

    return
      XYPoint(
          x: L1.P1.x + m * L1.P2.x,
          y: L1.P1.y + m * L1.P2.y
      );
  } catch (e) {
    return XYPoint(x:0, y:0);
  }
}

List<XYPoint> intersectTwoCircles(XYCircle A, XYCircle B){
  double AB0 = B.x - A.x;
  double AB1 = B.y - A.y;
  double c = sqrt(AB0 * AB0 + AB1* AB1);

  double a = A.r;
  double b = B.r;

  if (c ==  0) {
    return [];
  }

  double x = (a * a + c * c - b * b) / (2 * c);
  double y = a * a - x * x;
  if (y < 0) {
    // no intersection
    return [];
  }

  if (y > 0) y = sqrt( y );

  // compute unit vectors ex and ey
  double ex0 = AB0 / c;
  double ex1 = AB1 / c;
  double ey0 = -ex1;
  double ey1 =  ex0;
  double Q1x = A.x + x * ex0;
  double Q1y = A.y + x * ex1;

  if (y == 0) {
    // one touch point
    return [XYPoint(x: Q1x, y: Q1y)];
  }

  // two intersections
  double Q2x = Q1x - y * ey0;
  double Q2y = Q1y - y * ey1;
  Q1x += y * ey0;
  Q1y += y * ey1;
  return [
    XYPoint(x: Q1x, y: Q1y),
    XYPoint(x: Q2x, y: Q2y)
  ];

}

// http://arndt-bruenner.de/mathe/scripts/dreiecksrechner.htm
// u = a + b + c
// A = sqrt(s·(s - a)·(s - b)·(s - c)) mit s = u/2 = 10,557
// ha = 2·A/a
// hb = 2·A/b
// hc = 2·A/c
// alpha = acos((b² + c² - a²)/(2·b·c))
// beta = acos((a² + c² - b²)/(2·a·c))
// gamma = 180° - alpha - beta
// sa = sqrt(b² + c² + 2·b·c·cos(alpha))/2
// sb = sqrt(a² + c² + 2·a·c·cos(beta))/2
// sc = sqrt(a² + b² + 2·a·b·cos(gamma))/2
// wa = 2·b·c·cos(alpha/2)/(b + c)
// wb = 2·a·c·cos(beta/2)/(a + c)
// wc = 2·a·b·cos(gamma/2)/(a + b)
// ru = a/(2·sin(alpha))
// ma = sqrt(ru^2 - a^2/4)
// mb = sqrt(ru^2 - b^2/4)
// mc = sqrt(ru^2 - c^2/4)
// ri = sqrt((s - a)·(s - b)·(s - c)/s) mit s = u/2

Sides triangleAngleBiSectors(XYPoint A, XYPoint B, XYPoint C,){
  Angles angles = triangleAngles(A, B, C)!;
  Sides sides = triangleSides(A, B, C);

  return Sides(
    a: 2 * sides.b * sides.c * cos(angles.alpha * pi / 180 / 2 ) / (sides.b + sides.c),
    b: 2 * sides.a * sides.c * cos(angles.beta * pi / 180 / 2 ) / (sides.a + sides.c),
    c: 2 * sides.a * sides.b * cos(angles.gamma * pi / 180 / 2) / (sides.b + sides.a),
  );
}

Sides triangleMedians(XYPoint A, XYPoint B, XYPoint C,){
  Sides sides = triangleSides(A, B, C);

  return Sides(
    a: sqrt(2  * (sides.b * sides.b + sides.c * sides.c) - sides.a * sides.a) / 2,
    b: sqrt(2  * (sides.a * sides.a + sides.c * sides.c) - sides.b * sides.b) / 2,
    c: sqrt(2  * (sides.b * sides.b + sides.a * sides.a) - sides.c * sides.c) / 2,
  );
}

Sides triangleAltitudes(XYPoint A, XYPoint B, XYPoint C,){
  double area = triangleArea(A, B, C);
  Sides sides = triangleSides(A, B, C);

  return Sides(
    a: 2 * area / sides.a,
    b: 2 * area / sides.b,
    c: 2 * area / sides.c,
  );
}

Sides triangleSides(XYPoint A, XYPoint B, XYPoint C,){
  return Sides(
    c: _vectorLength(_vectorAB(A, B)),
    b: _vectorLength(_vectorAB(A, C)),
    a: _vectorLength(_vectorAB(B, C)),
  );
}

Angles? triangleAngles(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/Winkel%20eines%20Dreiecks.pdf
  try {
    return Angles(
        alpha: 180 /
            pi *
            acos(_vectorProductDot(_vectorAB(A, B), _vectorAB(A, C)) /
                _vectorLength(_vectorAB(A, B)) /
                _vectorLength(_vectorAB(A, C))),
        beta: 180 /
            pi *
            acos(_vectorProductDot(_vectorAB(B, A), _vectorAB(B, C)) /
                _vectorLength(_vectorAB(B, A)) /
                _vectorLength(_vectorAB(B, C))),
        gamma: 180 /
            pi *
            acos(_vectorProductDot(_vectorAB(C, A), _vectorAB(C, B)) /
                _vectorLength(_vectorAB(C, A)) /
                _vectorLength(_vectorAB(C, B))));
  } catch (e) {
    return null;
  }
}

double triangleArea(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/Fl%C3%A4che%20eines%20Dreiecks%20mit%20der%20trigonometrischen%20Fl%C3%A4chenformel.pdf
  // https://de.wikipedia.org/wiki/Dreiecksfl%C3%A4che
  Sides sides = triangleSides(A, B, C);
  double s = (sides.a + sides.b + sides.c) / 2;

  return sqrt(s * (s - sides.a) * (s - sides.b) * (s - sides.c));
}

double triangleCircumference(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/Umfang%20eines%20Dreiecks.pdf
  Sides sides = triangleSides(A, B, C);
  return sides.a + sides.b + sides.c;
}

XYPoint triangleCentroid(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/Schwerpunkt%20eines%20Dreiecks.pdf
  // https://de.wikipedia.org/wiki/Geometrischer_Schwerpunkt
  return XYPoint(
    x: (A.x + B.x + C.x) / 3,
    y: (A.y + B.y + C.y) / 3,
  );
}

XYPoint triangleOrthocenter(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/H%C3%B6henschnittpunkt%20eines%20Dreiecks.pdf
  // https://de.wikipedia.org/wiki/H%C3%B6henschnittpunkt
  return intersectVectors(
    XYLine(P1: A, P2: _vectorNorm(_vectorAB(B, C))),
    XYLine(P1: B, P2: _vectorNorm(_vectorAB(A, C))),
  );
}

XYPoint triangleLemoine(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Lemoinepunkt
  // https://mathematikgarten.hpage.com/get_file.php?id=33910985&vnr=826595

  Sides sides = triangleSides(A, B, C);
  double divisor = sides.a * sides.a + sides.b * sides.b + sides.c * sides.c;
  XYPoint L = XYPoint(
    x: A.x * sides.a * sides.a / divisor + B.x * sides.b * sides.b / divisor + C.x * sides.c * sides.c / divisor,
    y: A.y * sides.a * sides.a / divisor + B.y * sides.b * sides.b / divisor + C.y * sides.c * sides.c / divisor,
  );
  return L;
}

XYPoint triangleGergonne(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Gergonne-Punkt
  // https://mathworld.wolfram.com/GergonnePoint.html
  XYCircle MC = triangleInCircle(A, B, C);
  XYPoint M = XYPoint(x: MC.x, y: MC.y);
  XYPoint X = intersectVectors(
      XYLine(P1: B, P2: _vectorAB(B, C)),
      XYLine(P1: M, P2: _vectorNorm(_vectorAB(B, C)))
  );
  XYPoint Z = intersectVectors(
      XYLine(P1: A, P2: _vectorAB(A, B)),
      XYLine(P1: M, P2: _vectorNorm(_vectorAB(A, B)))
  );
  return intersectVectors(
    XYLine(P1: A, P2: _vectorAB(A, X)),
    XYLine(P1: C, P2: _vectorAB(C, Z)),
  );
}

XYPoint triangleNagel(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Nagel-Punkt
  // https://www.schule-bw.de/faecher-und-schularten/mathematisch-naturwissenschaftliche-faecher/mathematik/unterrichtsmaterialien/sekundarstufe1/geometrie/beweis/schnittpunkte/nagelpunkt.html

  Sides sides = triangleSides(A, B, C);

  double ac = (sides.a - sides.b + sides.c) / 2;
  double ab = (sides.a + sides.b - sides.c) / 2;

  XYPoint BexB = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorAB(A, C)), ab));
  XYPoint BexA = _vectorAdd(C, _vectorMult(_vectorNormalize(_vectorAB(C, B)), ac));

  XYPoint N = intersectVectors(
      XYLine(P1: A, P2: BexA),
      XYLine(P1: B, P2: BexB)
  );
  return N;
}

XYPoint triangleNapoleon(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Nagel-Punkt
  // https://www.schule-bw.de/faecher-und-schularten/mathematisch-naturwissenschaftliche-faecher/mathematik/unterrichtsmaterialien/sekundarstufe1/geometrie/beweis/schnittpunkte/nagelpunkt.html

  Sides sides = triangleSides(A, B, C);

  double ac = (sides.a - sides.b + sides.c) / 2;
  double ab = (sides.a + sides.b - sides.c) / 2;

  XYPoint BexB = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorAB(A, C)), ab));
  XYPoint BexA = _vectorAdd(C, _vectorMult(_vectorNormalize(_vectorAB(C, B)), ac));

  XYPoint N = intersectVectors(
      XYLine(P1: A, P2: BexA),
      XYLine(P1: B, P2: BexB)
  );
  return N;
}

XYPoint triangleSpieker(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Spieker-Punkt

  List<XYPoint> sidesmidpoint = triangleSidesMidPoints(A, B, C);

  XYCircle S = triangleInCircle(sidesmidpoint[0], sidesmidpoint[1], sidesmidpoint[2]);
  return XYPoint(
    x: S.x,
    y: S.y,
  );
}

XYPoint triangleMitten(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Mittenpunkt
  // https://mathworld.wolfram.com/Mittenpunkt.html

  List<XYPoint> sidesmidpoint = triangleSidesMidPoints(A, B, C);
  List<XYCircle> excircles = triangleExCircles(A, B, C);

  XYPoint M = intersectVectors(
      XYLine(
          P1: XYPoint(
            x: excircles[1].x,
            y: excircles[1].y,
          ),
          P2: sidesmidpoint[1]),
      XYLine(
          P1: XYPoint(
            x: excircles[0].x,
            y: excircles[0].y,
          ),
          P2: sidesmidpoint[0])
  );
  return M;
}

XYPoint triangleFeuerbach(XYPoint A, XYPoint B, XYPoint C){
  // https://de.wikipedia.org/wiki/Feuerbachkreis

  XYCircle incircle = triangleInCircle(A, B, C);
  XYCircle feuerbachcircle = triangleFeuerbachCircle(A, B, C);

  List<XYPoint> feuerbachpoints = intersectTwoCircles(incircle, feuerbachcircle);

  if (feuerbachpoints.isNotEmpty) {
    return feuerbachpoints[0];
  } else {
    return XYPoint(x: 0, y: 0);
  }
}

List<XYPoint> triangleSidesMidPoints(XYPoint A, XYPoint B, XYPoint C,){

  List<XYPoint> sidesMidpoint = [];
  Sides sides = triangleSides(A, B, C);

  XYPoint MA = _vectorAdd(B, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(B, C))), sides.a / 2));
  XYPoint MB = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(A, C))), sides.b / 2));
  XYPoint MC = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(A, B))), sides.c / 2));

  sidesMidpoint.add(XYPoint(x: MA.x, y: MA.y));
  sidesMidpoint.add(XYPoint(x: MB.x, y: MB.y));
  sidesMidpoint.add(XYPoint(x: MC.x, y: MC.y));

  return sidesMidpoint;
}

List<XYPoint> triangleAnglesMidPoints(XYPoint A, XYPoint B, XYPoint C,){

  List<XYPoint> sidesMidpoint = [];
  Sides sides = triangleSides(A, B, C);

  XYPoint MA = _vectorAdd(B, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(B, C))), sides.a / 2));
  XYPoint MB = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(A, C))), sides.b / 2));
  XYPoint MC = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(A, B))), sides.c / 2));

  sidesMidpoint.add(XYPoint(x: MA.x, y: MA.y));
  sidesMidpoint.add(XYPoint(x: MB.x, y: MB.y));
  sidesMidpoint.add(XYPoint(x: MC.x, y: MC.y));

  return sidesMidpoint;
}

List<XYPoint> triangleSymmediandPoints(XYPoint A, XYPoint B, XYPoint C,){

  List<XYPoint> sidesMidpoint = [];
  Sides sides = triangleSides(A, B, C);

  XYPoint MA = _vectorAdd(B, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(B, C))), sides.a / 2));
  XYPoint MB = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(A, C))), sides.b / 2));
  XYPoint MC = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorNormalize(_vectorAB(A, B))), sides.c / 2));

  sidesMidpoint.add(XYPoint(x: MA.x, y: MA.y));
  sidesMidpoint.add(XYPoint(x: MB.x, y: MB.y));
  sidesMidpoint.add(XYPoint(x: MC.x, y: MC.y));

  return sidesMidpoint;
}

List<XYPoint> triangleAltitudesBasePoints(XYPoint A, XYPoint B, XYPoint C,){
  List<XYPoint> result = [];
  XYPoint H = triangleOrthocenter(A, B, C);

  result.add(intersectVectors(
      XYLine(P1: B, P2: _vectorDiv(_vectorAB(B, C), _vectorLength(_vectorAB(B, C)))),
      XYLine(P1: A, P2: _vectorDiv(_vectorAB(A, H), _vectorLength(_vectorAB(A, H))))));
  result.add(intersectVectors(
      XYLine(P1: A, P2: _vectorDiv(_vectorAB(A, C), _vectorLength(_vectorAB(A, C)))),
      XYLine(P1: B, P2: _vectorDiv(_vectorAB(B, H), _vectorLength(_vectorAB(B, H))))));
  result.add(intersectVectors(
      XYLine(P1: A, P2: _vectorDiv(_vectorAB(A, B), _vectorLength(_vectorAB(A, B)))),
      XYLine(P1: C, P2: _vectorDiv(_vectorAB(C, H), _vectorLength(_vectorAB(C, H))))));
  return result;
}

XYCircle triangleInCircle(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/Inkreismittelpunkt%20eines%20Dreiecks.pdf
  // https://de.wikipedia.org/wiki/Inkreis
  // https://en.wikipedia.org/wiki/Incircle_and_excircles_of_a_triangle
  // http://arndt-bruenner.de/mathe/scripts/dreiecksrechner.htm
  XYPoint S = intersectVectors(
      XYLine(P1: A, P2: _vectorAdd(_vectorDiv(_vectorAB(A, B), _vectorLength(_vectorAB(A, B))), _vectorDiv(_vectorAB(A, C), _vectorLength(_vectorAB(A, C))))),
      XYLine(P1: B, P2: _vectorAdd(_vectorDiv(_vectorAB(B, A), _vectorLength(_vectorAB(B, A))), _vectorDiv(_vectorAB(B, C), _vectorLength(_vectorAB(B, C)))))
  );

  Sides sides = triangleSides(A, B, C);
  double s = (sides.a + sides.b + sides.c) / 2;

  return XYCircle(
    x: S.x,
    y: S.y,
    // ri = sqrt((s - a)·(s - b)·(s - c)/s) mit s = u/2
    r: sqrt((s - sides.a) * (s -sides.b) * (s - sides.c) / s),
  );
}

XYCircle triangleCircumCircle(XYPoint A, XYPoint B, XYPoint C,){
  // http://www.matheprofi.at/Umkreismittelpunkt%20eines%20Dreiecks.pdf
  // https://de.wikipedia.org/wiki/Umkreis
  Sides sides = triangleSides(A, B, C);
  Angles angles = triangleAngles(A, B, C)!;

  XYPoint SB =  _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorAB(A, C)), sides.b / 2));
  XYPoint SA =  _vectorAdd(B, _vectorMult(_vectorNormalize(_vectorAB(B, C)), sides.a / 2));

  XYPoint S = intersectVectors(
      XYLine(P1: SA, P2: _vectorNorm(_vectorAB(B, C))),
      XYLine(P1: SB, P2: _vectorNorm(_vectorAB(A, C)))
  );
  return XYCircle(
    x: S.x,
    y: S.y,
    // ru = a/(2·sin(alpha))
    // http://arndt-bruenner.de/mathe/scripts/dreiecksrechner.htm
    r: sides.a / (2 * sin(angles.alpha * pi /180)),
  );
}

XYCircle triangleFeuerbachCircle(XYPoint A, XYPoint B, XYPoint C,){
  // https://de.wikipedia.org/wiki/Feuerbachkreis
  List<XYPoint> sidemidpoints = triangleSidesMidPoints(A, B, C);
  XYCircle F = triangleCircumCircle(
    XYPoint(x: sidemidpoints[0].x, y: sidemidpoints[0].y),
    XYPoint(x: sidemidpoints[1].x, y: sidemidpoints[1].y),
    XYPoint(x: sidemidpoints[2].x, y: sidemidpoints[2].y),
  );
  return F;
}

List<XYCircle> triangleExCircles(XYPoint A, XYPoint B, XYPoint C,){
  // https://de.wikipedia.org/wiki/Ankreis
  // https://en.wikipedia.org/wiki/Incircle_and_excircles_of_a_triangle
  List<XYCircle> exCircle = [];

  Sides sides = triangleSides(A, B, C);
  double area = triangleArea(A, B, C);

  double ra = area / ((sides.a + sides.b + sides.c) / 2 - sides.a);
  double rb = area / ((sides.a + sides.b + sides.c) / 2 - sides.b);
  double rc = area / ((sides.a + sides.b + sides.c) / 2 - sides.c);

  double ac = (sides.a - sides.b + sides.c) / 2;
  double ab = (sides.a + sides.b - sides.c) / 2;

  XYPoint BexC = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorAB(A, B)), ac));
  XYPoint BexB = _vectorAdd(A, _vectorMult(_vectorNormalize(_vectorAB(A, C)), ab));
  XYPoint BexA = _vectorAdd(C, _vectorMult(_vectorNormalize(_vectorAB(C, B)), ac));

  XYPoint MexC = _vectorAdd(BexC, _vectorMult(_vectorNormalize(_vectorNorm(_vectorAB(A, B))), rc));
  XYPoint MexB = _vectorAdd(BexB, _vectorMult(_vectorNormalize(_vectorNorm(_vectorAB(C, A))), rb));
  XYPoint MexA = _vectorAdd(BexA, _vectorMult(_vectorNormalize(_vectorNorm(_vectorAB(B, C))), ra));

  exCircle.add(XYCircle(x: MexA.x, y: MexA.y, r: ra));
  exCircle.add(XYCircle(x: MexB.x, y: MexB.y, r: rb));
  exCircle.add(XYCircle(x: MexC.x, y: MexC.y, r: rc));

  return exCircle;
}

Future<Uint8List > triangleData2Image({
  required XYPoint A,
  required XYPoint B,
  required XYPoint C,
  required XYPoint O,
  required XYPoint L,
  required XYPoint CG,
  required XYPoint S,
  required XYPoint M,
  required XYPoint F,
  required XYPoint N,
  required XYPoint G,
  required XYPoint MSA,
  required XYPoint MSB,
  required XYPoint MSC,
  required XYPoint AA,
  required XYPoint AB,
  required XYPoint AC,
  required XYCircle IC,
  required XYCircle CC,
  required XYCircle FC,
  required XYCircle EA,
  required XYCircle EB,
  required XYCircle EC,
}) async {

  const BOUNDS = 100.0;
  const SCALE = 100.0;

  double minX = 0;
  double maxX = 0;
  double minY = 0;
  double maxY = 0;

  if (A.x < minX) minX = A.x; if (A.x > maxX) maxX = A.x;
  if (B.x < minX) minX = B.x; if (B.x > maxX) maxX = B.x;
  if (C.x < minX) minX = C.x; if (C.x > maxX) maxX = C.x;
  if (O.x < minX) minX = O.x; if (O.x > maxX) maxX = O.x;
  if (G.x < minX) minX = G.x; if (G.x > maxX) maxX = G.x;
  if (L.x < minX) minX = L.x; if (L.x > maxX) maxX = L.x;
  if (CG.x < minX) minX = CG.x; if (CG.x > maxX) maxX = CG.x;
  if (F.x < minX) minX = F.x; if (F.x > maxX) maxX = F.x;
  if (M.x < minX) minX = M.x; if (M.x > maxX) maxX = M.x;
  if (N.x < minX) minX = N.x; if (N.x > maxX) maxX = N.x;
  if (MSA.x < minX) minX = MSA.x; if (MSA.x > maxX) maxX = MSA.x;
  if (MSB.x < minX) minX = MSB.x; if (MSB.x > maxX) maxX = MSB.x;
  if (MSC.x < minX) minX = MSC.x; if (MSC.x > maxX) maxX = MSC.x;
  if (AA.x < minX) minX = AA.x; if (AA.x > maxX) maxX = AA.x;
  if (AB.x < minX) minX = AB.x; if (AB.x > maxX) maxX = AB.x;
  if (AC.x < minX) minX = AC.x; if (AC.x > maxX) maxX = AC.x;
  if (IC.x < minX) minX = IC.x; if (IC.x > maxX) maxX = IC.x;
  if (CC.x - CC.r < minX) minX = CC.x - CC.r; if (CC.x + CC.r > maxX) maxX = CC.x + CC.r;
  if (FC.x - FC.r < minX) minX = FC.x - FC.r; if (FC.x + FC.r > maxX) maxX = FC.x + FC.r;
  if (EA.x - EA.r < minX) minX = EA.x - EA.r; if (EA.x + EA.r > maxX) maxX = EA.x + EA.r;
  if (EB.x - EA.r < minX) minX = EB.x - EB.r; if (EB.x + EA.r > maxX) maxX = EB.x + EB.r;
  if (EC.x - EA.r < minX) minX = EC.x - EC.r; if (EC.x + EA.r > maxX) maxX = EC.x + EC.r;

  if (A.y < minY) minY = A.y; if (A.y > maxY) maxY = A.x;
  if (B.y < minY) minY = B.y; if (B.y > maxY) maxY = B.y;
  if (C.y < minY) minY = C.y; if (C.y > maxY) maxY = C.y;
  if (O.y < minY) minY = O.y; if (O.y > maxY) maxY = O.y;
  if (G.y < minY) minY = G.y; if (G.y > maxY) maxY = G.y;
  if (L.y < minY) minY = L.y; if (L.y > maxY) maxY = L.y;
  if (CG.y < minY) minY = CG.y; if (CG.y > maxY) maxY = CG.y;
  if (F.y < minY) minY = F.y; if (F.y > maxY) maxY = F.y;
  if (M.y < minY) minY = M.y; if (M.y > maxY) maxY = M.y;
  if (N.y < minY) minY = N.y; if (N.y > maxY) maxY = N.y;
  if (MSA.y < minY) minY = MSA.y; if (MSA.y > maxY) maxY = MSA.y;
  if (MSB.y < minY) minY = MSB.y; if (MSB.y > maxY) maxY = MSB.y;
  if (MSC.y < minY) minY = MSC.y; if (MSC.y > maxY) maxY = MSC.y;
  if (AA.y < minY) minY = AA.y; if (AA.y > maxY) maxY = AA.y;
  if (AB.y < minY) minY = AB.y; if (AB.y > maxY) maxY = AB.y;
  if (AC.y < minY) minY = AC.y; if (AC.y > maxY) maxY = AC.y;
  if (IC.y < minY) minY = IC.y; if (IC.y > maxY) maxY = IC.y;
  if (CC.y - CC.r < minY) minY = CC.y - CC.r; if (CC.y + CC.r > maxY) maxY = CC.y + CC.r;
  if (FC.y - FC.r < minY) minY = FC.y - FC.r; if (FC.y + FC.r > maxY) maxY = FC.y + FC.r;
  if (EA.y - EA.r < minY) minY = EA.y - EA.r; if (EA.y + EA.r > maxY) maxY = EA.y + EA.r;
  if (EB.y - EB.r < minY) minY = EB.y - EB.r; if (EB.y + EB.r > maxY) maxY = EB.y + EB.r;
  if (EC.y - EC.r < minY) minY = EC.y - EC.r; if (EC.y + EC.r > maxY) maxY = EC.y + EC.r;

  double width = BOUNDS + 2 * max(minX.abs(), maxX.abs()) * SCALE + BOUNDS;
  double height = BOUNDS + 2 * max(minY.abs(), maxY.abs()) * SCALE + BOUNDS;

  double offsetX = width / 2;
  double offsetY = height / 2;

  final canvasRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill
    ..strokeWidth = 2.0;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  paint.color = Colors.black;
  canvas.drawLine(Offset(BOUNDS, offsetY), Offset(width - BOUNDS, offsetY), paint);
  canvas.drawLine(Offset(offsetX, BOUNDS), Offset(offsetX, height - BOUNDS), paint);

  int i = 0;
  while (offsetX + i * SCALE < width) {
    canvas.drawLine(Offset(offsetX + i * SCALE, offsetY - 10), Offset(offsetX + i * SCALE, offsetY - 10), paint);
    canvas.drawLine(Offset(offsetX - i * SCALE, offsetY - 10), Offset(offsetX - i * SCALE, offsetY - 10), paint);
    i++;
  }
  i = 0;
  while (offsetY + i * SCALE < height) {
    canvas.drawLine(Offset(offsetX - 10, offsetY  + i * SCALE), Offset(offsetX + 10, offsetY + i * SCALE), paint);
    canvas.drawLine(Offset(offsetX - 10, offsetY  - i * SCALE), Offset(offsetX + 10, offsetY - i * SCALE), paint);
    i++;
  }



  canvas.drawLine(Offset(A.x * SCALE + offsetX, A.y * SCALE + offsetY), Offset(B.x * SCALE + offsetX, B.y * SCALE + offsetY), paint);
  canvas.drawLine(Offset(B.x * SCALE + offsetX, B.y * SCALE + offsetY), Offset(C.x * SCALE + offsetX, C.y * SCALE + offsetY), paint);
  canvas.drawLine(Offset(C.x * SCALE + offsetX, C.y * SCALE + offsetY), Offset(A.x * SCALE + offsetX, A.y * SCALE + offsetY), paint);

  // draw Lines
  paint.color = Colors.orangeAccent;
  canvas.drawLine(Offset(A.x * SCALE + offsetX, A.y * SCALE + offsetY), Offset(AA.x * SCALE + offsetX, AA.y * SCALE + offsetY), paint);
  canvas.drawLine(Offset(B.x * SCALE + offsetX, B.y * SCALE + offsetY), Offset(AB.x * SCALE + offsetX, AB.y * SCALE + offsetY), paint);
  canvas.drawLine(Offset(C.x * SCALE + offsetX, C.y * SCALE + offsetY), Offset(AC.x * SCALE + offsetX, AC.y * SCALE + offsetY), paint);
  paint.color = Colors.orange;
  canvas.drawLine(Offset(A.x * SCALE + offsetX, A.y * SCALE + offsetY), Offset(MSA.x * SCALE + offsetX, MSA.y * SCALE + offsetY), paint);
  canvas.drawLine(Offset(B.x * SCALE + offsetX, B.y * SCALE + offsetY), Offset(MSB.x * SCALE + offsetX, MSB.y * SCALE + offsetY), paint);
  canvas.drawLine(Offset(C.x * SCALE + offsetX, C.y * SCALE + offsetY), Offset(MSC.x * SCALE + offsetX, MSC.y * SCALE + offsetY), paint);

  paint.style = PaintingStyle.stroke;
  paint.color = Colors.blue;
  // draw Points
  canvas.drawCircle(Offset(F.x * SCALE + offsetX, F.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(G.x * SCALE + offsetX, G.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(S.x * SCALE + offsetX, S.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(O.x * SCALE + offsetX, O.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(L.x * SCALE + offsetX, L.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(M.x * SCALE + offsetX, M.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(N.x * SCALE + offsetX, N.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(CG.x * SCALE + offsetX, CG.y * SCALE + offsetY), 1.0, paint);
  paint.color = Colors.green;
  canvas.drawCircle(Offset(MSA.x * SCALE + offsetX, MSA.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(MSB.x * SCALE + offsetX, MSB.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(MSC.x * SCALE + offsetX, MSC.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(AA.x * SCALE + offsetX, AA.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(AB.x * SCALE + offsetX, AB.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(AC.x * SCALE + offsetX, AC.y * SCALE + offsetY), 1.0, paint);

  // draw Circles
  paint.color = Colors.red;
  canvas.drawCircle(Offset(IC.x * SCALE + offsetX, IC.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(CC.x * SCALE + offsetX, CC.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(EA.x * SCALE + offsetX, EA.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(EB.x * SCALE + offsetX, EB.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(EC.x * SCALE + offsetX, EC.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(IC.x * SCALE + offsetX, IC.y * SCALE + offsetY), IC.r * SCALE, paint);
  canvas.drawCircle(Offset(CC.x * SCALE + offsetX, CC.y * SCALE + offsetY), CC.r * SCALE, paint);
  canvas.drawCircle(Offset(EA.x * SCALE + offsetX, EA.y * SCALE + offsetY), EA.r * SCALE, paint);
  canvas.drawCircle(Offset(EB.x * SCALE + offsetX, EB.y * SCALE + offsetY), EB.r * SCALE, paint);
  canvas.drawCircle(Offset(EC.x * SCALE + offsetX, EC.y * SCALE + offsetY), EC.r * SCALE, paint);
  paint.color = Colors.purple;
  canvas.drawCircle(Offset(FC.x * SCALE + offsetX, FC.y * SCALE + offsetY), 1.0, paint);
  canvas.drawCircle(Offset(FC.x * SCALE + offsetX, FC.y * SCALE + offsetY), FC.r * SCALE, paint);

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return trimNullBytes(data!.buffer.asUint8List());
}

