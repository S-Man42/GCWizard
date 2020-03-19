import 'package:latlong/latlong.dart';

const keyCoordsDEC = 'coords_dec';
const keyCoordsDEG = 'coords_deg';
const keyCoordsDMS = 'coords_dms';
const keyCoordsUTM = 'coords_utm';
const keyCoordsMGRS = 'coords_mgrs';
const keyCoordsSwissGrid = 'coords_swissgrid';
const keyCoordsSwissGridPlus = 'coords_swissgridplus';
const keyCoordsGaussKrueger1 = 'coords_gausskrueger_gk1';
const keyCoordsGaussKrueger2 = 'coords_gausskrueger_gk2';
const keyCoordsGaussKrueger3 = 'coords_gausskrueger_gk3';
const keyCoordsGaussKrueger4 = 'coords_gausskrueger_gk4';
const keyCoordsGaussKrueger5 = 'coords_gausskrueger_gk5';
const keyCoordsMaidenhead = 'coords_maidenhead';
const keyCoordsMercator = 'coords_mercator';
const keyCoordsGeohash = 'coords_geohash';

class CoordinateFormat {
  final key;
  String name;

  CoordinateFormat(this.key, this.name);
}

List<CoordinateFormat> allCoordFormats = [
  CoordinateFormat(keyCoordsDEC, 'DEC: DD.DDD°'),
  CoordinateFormat(keyCoordsDEG, 'DEG: DD° MM.MMM\''),
  CoordinateFormat(keyCoordsDMS, 'DMS: DD° MM\' SS.SSS"'),
  CoordinateFormat(keyCoordsUTM, 'UTM'),
  CoordinateFormat(keyCoordsMGRS, 'MGRS'),
  CoordinateFormat(keyCoordsSwissGrid, 'SwissGrid (CH1903)'),
  CoordinateFormat(keyCoordsSwissGridPlus, 'SwissGrid (CH1903+)'),
  CoordinateFormat(keyCoordsGaussKrueger1, null),
  CoordinateFormat(keyCoordsGaussKrueger2, null),
  CoordinateFormat(keyCoordsGaussKrueger3, null),
  CoordinateFormat(keyCoordsGaussKrueger4, null),
  CoordinateFormat(keyCoordsGaussKrueger5, null),
  CoordinateFormat(keyCoordsMaidenhead, 'Maidenhead Locator (QTH)'),
  CoordinateFormat(keyCoordsMercator, 'Mercator'),
  CoordinateFormat(keyCoordsGeohash, 'Geohash'),
];

final defaultCoordinate = LatLng(0.0, 0.0);

//DEC is always treated as double, so a special class is not necessary

class DEG {
  int degrees;
  double minutes;

  DEG(this.degrees, this.minutes);
}

class DMS {
  int degrees;
  int minutes;
  double seconds;

  DMS(this.degrees, this.minutes, this.seconds);
}

enum HemisphereLatitude {North, South}
enum HemisphereLongitude {East, West}

// UTM with latitude Zones; Normal UTM is only separated into Hemispheres N and S
class UTMREF {
  UTMZone zone;
  double easting;
  double northing;

  UTMREF(this.zone, this.easting, this.northing);

  get hemisphere {
    return 'NPQRSTUVWXYZ'.contains(zone.latZone) ? HemisphereLatitude.North : HemisphereLatitude.South;
  }
}

class UTMZone {
  int lonZone;
  int lonZoneRegular; //the real lonZone differs from mathematical because of two special zones around norway
  String latZone;

  UTMZone(this.lonZoneRegular, this.lonZone, this.latZone);
}

class MGRS {
  UTMZone utmZone;
  String digraph;
  double easting;
  double northing;

  MGRS(this.utmZone, this.digraph, this.easting, this.northing);
}

class SwissGrid {
  double easting;
  double northing;

  SwissGrid(this.easting, this.northing);
}

class GaussKrueger {
  int code;
  double easting;
  double northing;

  GaussKrueger(this.code, this.easting, this.northing);
}

class Mercator {
  double easting;
  double northing;

  Mercator(this.easting, this.northing);
}