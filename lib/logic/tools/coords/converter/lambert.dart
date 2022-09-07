import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/external_libs/net.sf.geographiclib/lambert_conformal_conic.dart';
import 'package:latlong2/latlong.dart';

enum LambertType {
  LAMBERT_93, LAMBERT_2008, ETRS89_LCC, LAMBERT_72
  , L93_CC42, L93_CC43, L93_CC44, L93_CC45, L93_CC46, L93_CC47, L93_CC48, L93_CC49
  , LAMBERT_ZONE_I, LAMBERT_ZONE_II, LAMBERT_ZONE_III, LAMBERT_ZONE_IV
}

class _LambertDefinition {
  final LambertConformalConicType type;

  final double centralMeridian; // lon0 λ0
  final double latitudeOfOrigin; // lat0 φ0
  final double standardParallel1; // stdlat1 φ1
  final double standardParallel2; // stdlat2 φ2
  final double scaleFactor; // k0
  final double falseEasting; // x0
  final double falseNorthing; // y1

  const _LambertDefinition({
    this.type,
    this.centralMeridian,
    this.latitudeOfOrigin,
    this.standardParallel1,
    this.standardParallel2,
    this.scaleFactor,
    this.falseEasting,
    this.falseNorthing
  });
}

//https://www.spatialreference.org/ref/epsg/<epsg number>/html/

final Map<LambertType, _LambertDefinition> _LambertDefinitions = {
  //EPSG 2154, LAMB93, RGF93, Reseau Geodesique Francais 1993
  LambertType.LAMBERT_93 : _LambertDefinition(
    type: LambertConformalConicType.SP2,
    centralMeridian: 3.0,
    latitudeOfOrigin: 46.5,
    standardParallel1: 49.0,
    standardParallel2: 44.0,
    falseEasting: 700000.0,
    falseNorthing: 6600000.0
  ),
  //EPSG 3812, Belgian Lambert 2008
  LambertType.LAMBERT_2008 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 4.359215833333335,
      latitudeOfOrigin: 50.79781500000001,
      standardParallel1: 49.833333333333336,
      standardParallel2: 51.16666666666667,
      falseEasting: 649328.0,
      falseNorthing: 665262.0
  ),
  //EPSG 31370
  LambertType.LAMBERT_72 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 4.367486666666666,
      latitudeOfOrigin: 90.0,
      standardParallel1: 51.16666723333333,
      standardParallel2: 49.8333339,
      falseEasting: 150000.013,
      falseNorthing: 5400088.438
  ),
  //EPSG 3034
  LambertType.ETRS89_LCC : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 10.0,
      latitudeOfOrigin: 52.0,
      standardParallel1: 35.0,
      standardParallel2: 65.0,
      falseEasting: 4000000.0,
      falseNorthing: 2800000.0
  ),
  //EPSG 3942, RGF93
  LambertType.L93_CC42 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 42.0,
      standardParallel1: 41.25,
      standardParallel2: 42.75,
      falseEasting: 1700000.0,
      falseNorthing: 1200000.0
  ),
  //EPSG 3943, RGF93
  LambertType.L93_CC43 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 43.0,
      standardParallel1: 42.25,
      standardParallel2: 43.75,
      falseEasting: 1700000.0,
      falseNorthing: 2200000.0
  ),
  //EPSG 3944, RGF93
  LambertType.L93_CC44 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 44.0,
      standardParallel1: 43.25,
      standardParallel2: 44.75,
      falseEasting: 1700000.0,
      falseNorthing: 3200000.0
  ),
  //EPSG 3945, RGF93
  LambertType.L93_CC45 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 45.0,
      standardParallel1: 44.25,
      standardParallel2: 45.75,
      falseEasting: 1700000.0,
      falseNorthing: 4200000.0
  ),
  //EPSG 3946, RGF93
  LambertType.L93_CC46 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 46.0,
      standardParallel1: 45.25,
      standardParallel2: 46.75,
      falseEasting: 1700000.0,
      falseNorthing: 5200000.0
  ),
  //EPSG 3947, RGF93
  LambertType.L93_CC47 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 47.0,
      standardParallel1: 46.25,
      standardParallel2: 47.75,
      falseEasting: 1700000.0,
      falseNorthing: 6200000.0
  ),
  //EPSG 3948, RGF93
  LambertType.L93_CC48 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 48.0,
      standardParallel1: 47.25,
      standardParallel2: 48.75,
      falseEasting: 1700000.0,
      falseNorthing: 7200000.0
  ),
  //EPSG 3949, RGF93
  LambertType.L93_CC49 : _LambertDefinition(
      type: LambertConformalConicType.SP2,
      centralMeridian: 3.0,
      latitudeOfOrigin: 49.0,
      standardParallel1: 48.25,
      standardParallel2: 49.75,
      falseEasting: 1700000.0,
      falseNorthing: 8200000.0
  ),
  //EPSG 27561, NTF (Paris), Lambert North, LAMB1
  LambertType.LAMBERT_ZONE_I : _LambertDefinition(
      type: LambertConformalConicType.SP1,
      centralMeridian: 0.0,
      latitudeOfOrigin: 55.0,
      scaleFactor: 0.999877341,
      falseEasting: 600000.0,
      falseNorthing: 200000.0
  ),
  //EPSG 27562, NTF (Paris), Lambert Center, LAMB2
  LambertType.LAMBERT_ZONE_II : _LambertDefinition(
      type: LambertConformalConicType.SP1,
      centralMeridian: 0.0,
      latitudeOfOrigin: 52.0,
      scaleFactor: 0.99987742,
      falseEasting: 600000.0,
      falseNorthing: 200000.0
  ),
  //EPSG 27563, NTF (Paris), Lambert South, LAMB3
  LambertType.LAMBERT_ZONE_III : _LambertDefinition(
      type: LambertConformalConicType.SP1,
      centralMeridian: 0.0,
      latitudeOfOrigin: 49.0,
      scaleFactor: 0.999877499,
      falseEasting: 600000.0,
      falseNorthing: 200000.0
  ),
  //EPSG 27564, NTF (Paris), Lambert Corsica, LAMB4
  LambertType.LAMBERT_ZONE_IV : _LambertDefinition(
      type: LambertConformalConicType.SP1,
      centralMeridian: 0.0,
      latitudeOfOrigin: 46.85,
      scaleFactor: 0.99994471,
      falseEasting: 234.358,
      falseNorthing: 185861.369
  ),
};

class Lambert {
  final double x;
  final double y;

  const Lambert(this.x, this.y);

  @override
  String toString() {
    return 'X: $x, Y: $y';
  }
}

// https://sourceforge.net/p/geographiclib/discussion/1026621/thread/87c3cb91af/
// https://sourceforge.net/p/geographiclib/code/ci/release/tree/examples/example-LambertConformalConic.cpp#l36

Lambert latLonToSpecificLambert(LatLng latLon, LambertType type, Ellipsoid ellipsoid) {
  var specificLambert = _LambertDefinitions[type];

  var lambertObject = LambertConformalConic(
    ellipsoid.a,
    ellipsoid.f,
    specificLambert.type,
    specificLambert.type == LambertConformalConicType.SP1 ? specificLambert.latitudeOfOrigin : specificLambert.standardParallel1,
    specificLambert.type == LambertConformalConicType.SP1 ? null : specificLambert.standardParallel2,
    // k1 "always" 1 if two different standard parallels given
    specificLambert.type == LambertConformalConicType.SP1 ? specificLambert.scaleFactor : 1.0
  );

  GeographicLibLambert transformation = lambertObject.forward(
    specificLambert.centralMeridian,
    specificLambert.latitudeOfOrigin,
    specificLambert.centralMeridian
  );

  var x0 = transformation.x - specificLambert.falseEasting;
  var y0 = transformation.y - specificLambert.falseNorthing;

  GeographicLibLambert lambert = lambertObject.forward(
    specificLambert.centralMeridian,
    latLon.latitude,
    latLon.longitude
  );

  return Lambert(lambert.x - x0, lambert.y - y0);
}

LatLng specificLambertToLatLon (Lambert lambert, LambertType type, Ellipsoid ellipsoid) {
  var specificLambert = _LambertDefinitions[type];

  var lambertObject = LambertConformalConic(
      ellipsoid.a,
      ellipsoid.f,
      specificLambert.type,
      specificLambert.type == LambertConformalConicType.SP1 ? specificLambert.latitudeOfOrigin : specificLambert.standardParallel1,
      specificLambert.type == LambertConformalConicType.SP1 ? null : specificLambert.standardParallel2,
      // k1 "always" 1 if two different standard parallels given
      specificLambert.type == LambertConformalConicType.SP1 ? specificLambert.scaleFactor : 1.0
  );

  GeographicLibLambert transformation = lambertObject.forward(
      specificLambert.centralMeridian,
      specificLambert.latitudeOfOrigin,
      specificLambert.centralMeridian
  );

  var x0 = transformation.x - specificLambert.falseEasting;
  var y0 = transformation.y - specificLambert.falseNorthing;

  var x = lambert.x + x0;
  var y = lambert.y + y0;

  GeographicLibLambertLatLon latLon = lambertObject.Reverse(
      specificLambert.centralMeridian,
      x,
      y
  );

  return LatLng(latLon.lat, latLon.lon);
}

main() {
  var l = latLonToSpecificLambert(
      LatLng(43.297225, 0.3770638889),
      LambertType.LAMBERT_ZONE_I,
      getEllipsoidByName(ELLIPSOID_NAME_WGS84)
  );

  print(
      l
  );

  var ll = specificLambertToLatLon(
      l,
      LambertType.LAMBERT_ZONE_I,
      getEllipsoidByName(ELLIPSOID_NAME_WGS84)
  );
  print(
      '${ll.latitude} ${ll.longitude}'
  );
}