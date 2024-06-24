import 'dart:math';

class InverseResult {
  double azimuth;
  double reverseAzimuth;
  double distance;

  InverseResult({this.azimuth = 0.0, this.reverseAzimuth = 0.0, this.distance = 0.0});
}

class LLPoint {
  double latitude;
  double longitude;

  LLPoint({this.latitude = 0.0, this.longitude = 0.0});

  void set(double dLat, double dLon) {
    latitude = dLat;
    longitude = dLon;
  }
}

const double kInverseFlattening = 298.2572235636654651;
const double kFlattening = 1.0 / kInverseFlattening;
const double kEps = 0.5e-15;
const double kSemiMajorAxis = 6378137.0;
const double kSemiMinorAxis = kSemiMajorAxis * (1 - kFlattening);
const double kSphereRadius = sqrt(kSemiMajorAxis * kSemiMinorAxis);

bool isNearZero(double a, {double epsilon = 2e-6}) {
  return (a.abs() < epsilon);
}

bool isApprox(double a, double b, {double precision = 1e-11}) {
  return (a - b).abs() <= precision * min(a.abs(), b.abs());
}

double nmToMeters(double dNm) {
  return dNm * 1852.0;
}

double mod(double a, double b) {
  double mod = a - b * (a / b).floor();
  if (mod < 0) mod += b;
  return mod;
}

double signAzimuthDifference(double az1, double az2) {
  return mod(az1 - az2 + pi, 2 * pi) - pi;
}

void findLinearRoot(List<double> x, List<double> errArray, double root) {
  if (x[0] == x[1]) {
    root = double.nan;
  } else if (errArray[0] == errArray[1]) {
    if (isNearZero(errArray[0] - errArray[1], epsilon: 1e-15)) {
      root = x[0];
    } else {
      root = double.nan;
    }
  } else {
    root = -errArray[0] * (x[1] - x[0]) / (errArray[1] - errArray[0]) + x[0];
  }
}

LLPoint destVincenty(LLPoint pt, double brng, double dist) {
  double s = dist;
  double alpha1 = brng;
  double sinAlpha1 = sin(alpha1);
  double cosAlpha1 = cos(alpha1);

  double tanU1 = (1.0 - kFlattening) * tan(pt.latitude);
  double cosU1 = 1.0 / sqrt((1.0 + tanU1 * tanU1));
  double sinU1 = tanU1 * cosU1;
  double sigma1 = atan2(tanU1, cosAlpha1);
  double sinAlpha = cosU1 * sinAlpha1;
  double cosSqAlpha = 1.0 - sinAlpha * sinAlpha;
  double uSq = cosSqAlpha * (kSemiMajorAxis * kSemiMajorAxis - kSemiMinorAxis * kSemiMinorAxis) /
      (kSemiMinorAxis * kSemiMinorAxis);
  double A = 1.0 + uSq / 16384.0 * (4096.0 + uSq * (-768.0 + uSq * (320.0 - 175.0 * uSq)));
  double B = uSq / 1024.0 * (256.0 + uSq * (-128.0 + uSq * (74.0 - 47.0 * uSq)));

  double sigma = s / (kSemiMinorAxis * A);
  double sigmaP = 2 * pi;
  double sinSigma = sin(sigma);
  double cosSigma = cos(sigma);
  double cos2SigmaM = cos(2.0 * sigma1 + sigma);
  int iterLimit = 0;
  while ((sigma - sigmaP).abs() > kEps && ++iterLimit < 100) {
    cos2SigmaM = cos(2.0 * sigma1 + sigma);
    sinSigma = sin(sigma);
    cosSigma = cos(sigma);
    double cos2SigmaSq = cos2SigmaM * cos2SigmaM;
    double deltaSigma = B * sinSigma * (cos2SigmaM + B * 0.25 * (cosSigma * (-1.0 + 2.0 * cos2SigmaSq) -
        B / 6.0 * cos2SigmaM * (-3.0 + 4.0 * sinSigma * sinSigma) * (-3.0 + 4.0 * cos2SigmaSq)));

    sigmaP = sigma;
    sigma = s / (kSemiMinorAxis * A) + deltaSigma;
  }

  double tmp = sinU1 * sinSigma - cosU1 * cosSigma * cosAlpha1;
  double lat2 = atan2(sinU1 * cosSigma + cosU1 * sinSigma * cosAlpha1,
      (1.0 - kFlattening) * sqrt(sinAlpha * sinAlpha + tmp * tmp));
  double lambda = atan2(sinSigma * sinAlpha1, cosU1 * cosSigma - sinU1 * sinSigma * cosAlpha1);
  double C = kFlattening / 16.0 * cosSqAlpha * (4.0 + kFlattening * (4.0 - 3.0 * cosSqAlpha));
  double L = lambda - (1.0 - C) * kFlattening * sinAlpha *
      (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1.0 + 2.0 * cos2SigmaM * cos2SigmaM)));

  return LLPoint(latitude: lat2, longitude: pt.longitude + L);
}

bool distVincenty(LLPoint pt1, LLPoint pt2, InverseResult result) {
  double L = pt2.longitude - pt1.longitude;
  double U1 = atan((1 - kFlattening) * tan(pt1.latitude));
  double U2 = atan((1 - kFlattening) * tan(pt2.latitude));

  double sinU1 = sin(U1);
  double cosU1 = cos(U1);
  double sinU2 = sin(U2);
  double cosU2 = cos(U2);

  double dCosU1CosU2 = cosU1 * cosU2;
  double dCosU1SinU2 = cosU1 * sinU2;

  double dSinU1SinU2 = sinU1 * sinU2;
  double dSinU1CosU2 = sinU1 * cosU2;

  double lambda = L;
  double lambdaP = 2 * pi;
  int iterLimit = 0;
  double cosSqAlpha;
  double sinSigma;
  double cos2SigmaM;
  double cosSigma;
  double sigma;
  double sinAlpha;
  double C;
  double sinLambda, cosLambda;

  do {
    sinLambda = sin(lambda);
    cosLambda = cos(lambda);
    sinSigma = sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) +
        (dCosU1SinU2 - dSinU1CosU2 * cosLambda) * (dCosU1SinU2 - dSinU1CosU2 * cosLambda));

    if (sinSigma == 0) {
      result.reverseAzimuth = 0.0;
      result.azimuth = 0.0;
      result.distance = 0.0;
      return true;
    }
    cosSigma = dSinU1SinU2 + dCosU1CosU2 * cosLambda;
    sigma = atan2(sinSigma, cosSigma);
    sinAlpha = dCosU1CosU2 * sinLambda / sinSigma;
    cosSqAlpha = 1.0 - sinAlpha * sinAlpha;
    cos2SigmaM = cosSigma - 2.0 * dSinU1SinU2 / cosSqAlpha;

    if (cos2SigmaM.isNaN) cos2SigmaM = 0.0; // equatorial line: cosSqAlpha=0
    C = kFlattening / 16.0 * cosSqAlpha * (4.0 + kFlattening * (4.0 - 3.0 * cosSqAlpha));
    lambdaP = lambda;
    lambda = L + (1.0 - C) * kFlattening * sinAlpha *
        (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1.0 + 2.0 * cos2SigmaM * cos2SigmaM)));
  } while ((lambda - lambdaP).abs() > kEps && ++iterLimit < 40);

  double uSq = cosSqAlpha * (kSemiMajorAxis * kSemiMajorAxis - kSemiMinorAxis * kSemiMinorAxis) /
      (kSemiMinorAxis * kSemiMinorAxis);
  double A = 1.0 + uSq / 16384.0 * (4096.0 + uSq * (-768.0 + uSq * (320.0 - 175.0 * uSq)));
  double B = uSq / 1024.0 * (256.0 + uSq * (-128.0 + uSq * (74.0 - 47.0 * uSq)));
  double deltaSigma = B * sinSigma * (cos2SigmaM + B / 4.0 * (cosSigma * (-1.0 + 2.0 * cos2SigmaM * cos2SigmaM) -
      B / 6.0 * cos2SigmaM * (-3.0 + 4.0 * sinSigma * sinSigma) * (-3.0 + 4.0 * cos2SigmaM * cos2SigmaM)));

  result.distance = kSemiMinorAxis * A * (sigma - deltaSigma);
  result.azimuth = atan2(cosU2 * sinLambda, dCosU1SinU2 - dSinU1CosU2 * cosLambda);
  result.reverseAzimuth = pi + atan2(cosU1 * sinLambda, -dSinU1CosU2 + dCosU1SinU2 * cosLambda);

  if (result.reverseAzimuth < 0.0) result.reverseAzimuth = 2 * pi + result.reverseAzimuth;

  if (result.azimuth < 0.0) result.azimuth = 2 * pi + result.azimuth;

  return true;
}

LLPoint perpIntercept(LLPoint llPt1, double dCrs13, LLPoint llPt2,
    double dCrsFromPt, double dDistFromPt, double dTol) {
  InverseResult result;
  LLPoint pt1 = llPt1;
  LLPoint pt2 = llPt2;
  distVincenty(pt1, pt2, result);

  if (result.distance <= dTol) {
    // pt1, pt2 and projected pt3 are all the same;
    dCrsFromPt = dDistFromPt = 0.0;
    return pt1;
  }

  final double dAngle = (signAzimuthDifference(dCrs13, result.azimuth)).abs();
  double dist13 = kSphereRadius * atan(tan(result.distance / kSphereRadius) * cos(dAngle));

  if (dAngle > pi / 2) {
    LLPoint newPoint;
    newPoint = destVincenty(pt1, dCrs13 + pi, dist13 + nmToMeters(150.0));
    dist13 = nmToMeters(150.0);

    distVincenty(newPoint, pt1, result);
    dCrs13 = result.azimuth;
    pt1 = newPoint;
  } else if ((dist13).abs() < nmToMeters(150.0)) {
    LLPoint newPoint;
    newPoint = destVincenty(pt1, dCrs13 + pi, nmToMeters(150.0));
    dist13 += nmToMeters(150.0);

    distVincenty(newPoint, pt1, result);
    dCrs13 = result.azimuth;
    pt1 = newPoint;
  }

  LLPoint pt3 = destVincenty(pt1, dCrs13, dist13);
  distVincenty(pt3, pt1, result);
  double crs31 = result.azimuth;

  distVincenty(pt3, pt2, result);
  double crs32 = result.azimuth;
  double dist23 = result.distance;

  List<double> errarray = [0.0, 0.0];
  List<double> distarray = [0.0, 0.0];
  errarray[0] = (signAzimuthDifference(crs31, crs32)).abs() - pi;
  distarray[0] = dist13;
  distarray[1] = (distarray[0] + errarray[0] * dist23).abs();

  pt3 = destVincenty(pt1, dCrs13, distarray[1]);
  distVincenty(pt3, pt1, result);
  crs31 = result.azimuth;

  distVincenty(pt3, pt2, result);
  crs32 = result.azimuth;

  errarray[1] = (signAzimuthDifference(crs31, crs32)).abs() - pi / 2;

  int k = 0;
  double dError = 0.0;
  while (k == 0 || ((dError > dTol) && (k < 15))) {
    double oldDist13 = dist13;
    findLinearRoot(distarray, errarray, dist13);
    if (dist13.isNaN) dist13 = oldDist13;

    pt3 = destVincenty(pt1, dCrs13, dist13);
    distVincenty(pt3, pt1, result);
    crs31 = result.azimuth;

    distVincenty(pt3, pt2, result);
    dist23 = result.distance;
    crs32 = result.azimuth;

    distarray[0] = distarray[1];
    distarray[1] = dist13;
    errarray[0] = errarray[1];
    errarray[1] = (signAzimuthDifference(crs31, crs32)).abs() - pi / 2;
    dError = (distarray[1] - distarray[0]).abs();
    k++;
  }

  dCrsFromPt = crs32;
  dDistFromPt = dist23;
  return pt3;
}

int geodesicArcIntercept(LLPoint pt1, double crs1,
    LLPoint center, double radius,
    LLPoint intPtC1, LLPoint intPtC2, double dTol) {
  double dCrsFromPt, dDistFromPt;
  final LLPoint perpPt = perpIntercept(pt1, crs1, center, dCrsFromPt, dDistFromPt, dTol);

  InverseResult result;
  distVincenty(perpPt, center, result);

  if (result.distance > radius) return 0;

  if ((result.distance - radius).abs() < dTol) {
    intPtC1 = perpPt;
    return 1;
  }

  final double perpDist = result.distance;
  distVincenty(perpPt, pt1, result);

  if (isApprox(cos(perpDist / kSphereRadius), 0.0, precision: 1e-8)) return 0;

  double crs = result.azimuth;
  double dist = kSphereRadius * acos(cos(radius / kSphereRadius) / cos(perpDist / kSphereRadius));
  LLPoint pt = destVincenty(perpPt, crs, dist);

  const int nIntersects = 2;
  for (int i = 0; i < nIntersects; i++) {
    distVincenty(center, pt, result);
    final double rcrs = result.reverseAzimuth;
    final double dErr = radius - result.distance;

    List<double> distarray = [0.0, 0.0];
    List<double> errarray = [0.0, 0.0];
    distarray[0] = dist;
    errarray[0] = dErr;

    distVincenty(pt, perpPt, result);
    final double bcrs = result.azimuth;

    distVincenty(center, pt, result);
    final double dAngle = (signAzimuthDifference(result.azimuth, result.reverseAzimuth)).abs();
    final double B = (signAzimuthDifference(bcrs, rcrs) + pi - dAngle).abs();
    final double A = acos(sin(B) * cos(dErr / kSphereRadius).abs());
    double c;
    if (sin(A).abs() < dTol) {
      c = dErr;
    } else if (A.abs() < dTol) {
      c = dErr / cos(B);
    } else {
      c = kSphereRadius * asin(sin(dErr / kSphereRadius) / sin(A));
    }

    dist = dErr > 0 ? dist + c : dist - c;
    pt = destVincenty(perpPt, crs, dist);
    distVincenty(center, pt, result);
    distarray[1] = dist;
    errarray[1] = radius - result.distance;

    while (dErr.abs() > dTol) {
      findLinearRoot(distarray, errarray, dist);
      if (dist.isNaN) break;

      pt = destVincenty(perpPt, crs, dist);
      distVincenty(center, pt, result);
      distarray[0] = distarray[1];
      errarray[0] = errarray[1];
      distarray[1] = dist;
      errarray[1] = radius - result.distance;
      break;
    }

    if (i == 0) {
      intPtC1 = pt;
    } else if (i == 1) {
      intPtC2 = pt;
    } else {
      break;
    }

    crs += pi;
    pt = destVincenty(perpPt, crs, dist);
    distVincenty(center, pt, result);
    errarray[0] = radius - result.distance;
  }

  return nIntersects;
}

double deg2Rad(double dVal) {
  return dVal * (pi / 180.0);
}

const double kTol = 1.0e-9;

double rad2Deg(double dVal) {
  return dVal * (180.0 / pi);
}

void main() {
  final geodesicStart = LLPoint(latitude: deg2Rad(17.4602726873), longitude: deg2Rad(-46.2007042135));
  final arcCenter = LLPoint(latitude: deg2Rad(39.7252664957), longitude: deg2Rad(1.4551465029));
  final geodesicAzimuth = deg2Rad(33.10601505048764);
  final arcRadius = 8100000.0;

  LLPoint intPtC1 = LLPoint();
  LLPoint intPtC2 = LLPoint();
  final nIndex = geodesicArcIntercept(geodesicStart, geodesicAzimuth, arcCenter, arcRadius, intPtC1, intPtC2, kTol);

  if (nIndex < 1) {
    print("no found");
  } else {
    print("${rad2Deg(intPtC1.latitude)} ${rad2Deg(intPtC1.longitude)}");
    print("${rad2Deg(intPtC2.latitude)} ${rad2Deg(intPtC2.longitude)}");
  }
}