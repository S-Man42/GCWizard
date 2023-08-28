// https://ksi.uconn.edu/prevention/wet-bulb-globe-temperature-monitoring/
// https://www.researchgate.net/profile/Thieres-Silva/publication/261706490_Estimating_Black_Globe_Temperature_Based_on_Meteorological_Data/links/00b7d535176fd08364000000/Estimating-Black-Globe-Temperature-Based-on-Meteorological-Data.pdf?origin=publication_detail
// https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
//
// https://climatechip.org/excel-wbgt-calculator
// https://wbgt.app/
// https://www.osha.gov/heat-exposure/wbgt-calculator
//
// https://github.com/mdljts/wbgt

import 'dart:core';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/common.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/julian_date.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/logic/sun_position.dart' as sunposition;
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/liljegren.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';

enum WBGT_HEATSTRESS_CONDITION { WHITE, GREEN, YELLOW, RED, BLACK }

final Map<WBGT_HEATSTRESS_CONDITION, double> WBGT_HEAT_STRESS = {
  WBGT_HEATSTRESS_CONDITION.WHITE: 24.9,
  WBGT_HEATSTRESS_CONDITION.GREEN: 27.7,
  WBGT_HEATSTRESS_CONDITION.YELLOW: 29.4,
  WBGT_HEATSTRESS_CONDITION.RED: 31.6,
};

class WBGTOutput {
  final int Status;
  final double Solar;
  final double Tg;
  final double Tnwb;
  final double Tpsy;
  final double Twbg;
  final double Tdew;
  final sunposition.SunPosition SunPos;

  WBGTOutput({this.Status = 0, this.Solar = 0.0, this.Tg = 0.0, this.Tnwb = 0.0, this.Tpsy = 0.0, this.Twbg = 0.0, this.Tdew = 0.0, required this.SunPos});
}

WBGTOutput calculateWetBulbGlobeTemperature(DateTimeTimezone dateTime, LatLng coords, double windSpeed, double windSpeedHeight, double temperature, double humidity, double airPressure, bool urban, CLOUD_COVER cloudcover) {

  var sunPosition = sunposition.SunPosition(
      LatLng(coords.latitude, coords.longitude),
      JulianDate(dateTime),
      const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563)
  );

  double solar = calc_solar_irradiance(solarElevationAngle: sunPosition.altitude, cloudcover: cloudcover);

  liljegrenOutputWBGT WBGT = calc_wbgt(
    year: dateTime.datetime.year,
    month: dateTime.datetime.month,
    day: dateTime.datetime.day,
    hour: dateTime.datetime.hour,
    minute: dateTime.datetime.minute,
    gmt: dateTime.timezone.inHours,
    avg: 0,
    urban: urban ? 1 : 0,
    lat: coords.latitude,
    lon: coords.longitude,
    pres: airPressure,
    Tair: temperature,
    relhum: humidity,
    speed: windSpeed,
    zspeed: windSpeedHeight,
    dT: 0,
    solar: solar,
  );

  if (WBGT.Status != 0) {
    return WBGTOutput(Status: -1, SunPos: sunPosition);
  }
  return WBGTOutput(Status: 0, Twbg: WBGT.Twbg, Solar: solar, Tdew: WBGT.Tdew, Tg: WBGT.Tg, SunPos: sunPosition);
}