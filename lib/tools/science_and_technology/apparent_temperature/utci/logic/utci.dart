// http://james-ramsden.com/calculate-utci-c-code/
// Based on http://www.utci.org/public/index.php?dir=UTCI+Program+Code%2F
// !~ UTCI, Version a 0.002, October 2009
//     !~ Copyright (C) 2009  Peter Broede
//
//     !~ Program for calculating UTCI Temperature (UTCI)
//     !~ released for public use after termination of COST Action 730
//
//     !~ replaces Version a 0.001, from September 2009
//

import 'dart:math';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/common.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/liljegren.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/julian_date.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/logic/sun_position.dart' as sunposition;
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/logic/sun_position.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:latlong2/latlong.dart';

final sigma = 5.670374419 * pow(10, -8); // Stefan-Boltzmann const

enum UTCI_HEATSTRESS_CONDITION { DARK_BLUE, BLUE_ACCENT, BLUE, LIGHT_BLUE, LIGHT_BLUE_ACCENT, GREEN, ORANGE, RED, RED_ACCENT, DARK_RED }

final Map<UTCI_HEATSTRESS_CONDITION, double> UTCI_HEAT_STRESS = {
  UTCI_HEATSTRESS_CONDITION.BLUE_ACCENT: -40.0,
  UTCI_HEATSTRESS_CONDITION.BLUE: -27.0,
  UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE: -13.0,
  UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE_ACCENT: 0.0,
  UTCI_HEATSTRESS_CONDITION.GREEN: 9.0,
  UTCI_HEATSTRESS_CONDITION.ORANGE: 26.0,
  UTCI_HEATSTRESS_CONDITION.RED: 32.0,
  UTCI_HEATSTRESS_CONDITION.RED_ACCENT: 38.0,
  UTCI_HEATSTRESS_CONDITION.DARK_RED: 46.0,
};

class UTCIOutput {
  final double Solar;
  final double Tg;
  final double Tdew;
  final double Tmrt;
  final double UTCI;
  final sunposition.SunPosition SunPos;

  UTCIOutput({this.Solar = 0.0, this.Tg = 0.0, this.Tmrt = 0.0, this.Tdew = 0.0, required this.UTCI, required this.SunPos});
}

UTCIOutput calculateUTCI(double Ta, double RH, double va, double Tmrt, bool calculateTmrt, {DateTimeTimezone? dateTime, LatLng? coords, double? airPressure, bool? urban, CLOUD_COVER? cloudcover}) {
  // http://james-ramsden.com/calculate-utci-c-code/
  // http://www.utci.org/utci_doku.php
  // http://www.utci.org/public/UTCI%20Program%20Code/UTCI_a002.f90
  //     UTCI, Version a 0.002, October 2009
  //     Copyright (C) 2009  Peter Broede
  //
  //     Program for calculating UTCI Temperature (UTCI)
  //     released for public use after termination of COST Action 730
  //
  //     METHOD:
  //     A subroutine (UTCI_approx) was written that calculates UTCI values approximated by a 6th order polynomial from the input
  //      -- air temperature (-50 to +50 degC)
  //      -- mean radiant temperature (30 degC below to 70 degC above air temperature)
  //      -- wind speed in 10 m (0.5 to 17 m/s)
  //      -- water vapour presuure in hPa (below 50 hPa or 100% relative humidity)
  //     Values in brackets indicate the range of validity.
  //
  //     USAGE:
  //     This subroutine can be incorporated into your own applications, the programs provided here may serve as an instructive example.
  //     Disclaimer of Warranty.
  //
  //     THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR
  //     OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  //     WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.
  //     SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
  //
  //     Limitation of Liability.
  //
  //     IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS THE
  //     PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR
  //     INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES
  //     OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
  //     DAMAGES.
  //
  //     -----------------------------------------------
  //     Peter Broede
  //     Leibniz Research Centre for Working Environment and Human Factors (IfADo)
  //     Leibniz-Institut für Arbeitsforschung an der TU Dortmund
  //     Ardeystr. 67
  //     D-44139 Dortmund
  //     Fon: +49 +231 1084225
  //     Fax: +49 +231 1084400
  //     e-mail: broede@ifado.de
  //     http://www.ifado.de
  //     -----------------------------------------------
  //

  double Tg = 0.0;
  double Tdew = _calculateTDewpoint(RH, Ta);

  if (calculateTmrt) {
    var sunPosition = sunposition.SunPosition(
        LatLng(coords!.latitude, coords.longitude),
        JulianDate(dateTime!),
        const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563)
    );
    double solar = calc_solar_irradiance(solarElevationAngle: sunPosition.altitude, cloudcover: cloudcover!);
    double hour_gmt = dateTime.datetime.hour - dateTime.timezone.inHours + (dateTime.datetime.minute) / 60.0;
    double dday = dateTime.datetime.day + hour_gmt / 24.0;
    liljegrenOutputSolarParameter solpar = calc_solar_parameters(dateTime.datetime.year, dateTime.datetime.month, dday, solar, coords.latitude, coords.longitude);
    Tg = _calculateTglobe(Ta, va, Tdew);
    Tg = Tglobe(Ta + 273.15, RH, airPressure!, va, solar, solpar.fdir, solpar.cza);
    Tmrt = _calculateTmrt(Ta, va, Tg);
  }
  print('calc UTCI --------------------------------------------------------------------------------------------------');
  print('Ta   '+ Ta.toString());
  print('RH   '+ RH.toString());
  print('Tmrt '+ Tmrt.toString());
  print('va   '+ va.toString());
  double UTCI = _calcUTCI(Ta, va, Tmrt, RH);

  return UTCIOutput(UTCI: UTCI, Solar: 0.0, Tg: Tg, Tmrt: Tmrt, Tdew: Tdew, SunPos: SunPosition(LatLng(0.0, 0.0), JulianDate(DateTimeTimezone(datetime: DateTime.now(), timezone: DateTime.now().timeZoneOffset)), defaultEllipsoid));
}

double _calculateTDewpoint(double relativeHumidity, double ambientTemperature){
  // https://www.vcalc.com/wiki/rklarsen/Calculating+Dew+Point+Temperature+from+Relative+Humidity
  double B1 = 243.04;
  double A1 = 17.625;

  return (relativeHumidity != 0.0) ? (B1 * (log(relativeHumidity / 100) / log(e) + (A1 * ambientTemperature) / (B1 + ambientTemperature)))/(A1 - log(relativeHumidity/100) / log(e) - A1 * ambientTemperature / (B1 + ambientTemperature)) : 0.0;
}

double _calculateTmrt(double Tair, double va, double Tglobe){
  // https://www.novalynx.com/manuals/210-4417-manual.pdf
  //   mrt (°C) = tg + 2.42V (tg - ta)
  //     V: air current cm/sec
  //     ta: temperature of the air outside of the globe
  //     tg: globe thermometer temperature
  print('calc Tmrt ');
  print('- Ta '+Tair.toString());
  print('- Tg '+Tglobe.toString());
  print('- va '+va.toString());
  print((Tglobe + 2.42 * va * 100 * (Tglobe - Tair)).toString());
  return Tglobe + 2.42 * va * 100 * (Tglobe - Tair);
}

double _calculateTglobe(
    double Ta, // deg C°
    double va, // m/s
    double Tdew, // deg C°
    ){
  print('calc Tg ');
  print('- Ta '+Ta.toString());
  print('- Td '+Tdew.toString());
  print('- va '+va.toString());
  // Estimation of Black Globe Temperature for Calculation of the WBGT Index
  // https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
  // The values to be entered are
  // wind speed (u in meters per hour),
  // ambient temperature (Ta in degrees Celsius),
  // dew point temperature (Td in degrees Celsius),
  // solar irradiance (S in Watts per meter squared),
  // direct beam radiation from the sun (𝑓𝑑𝑏) and
  // diffuse radiation from the sun (𝑓𝑑𝑖𝑓).
  va = va * 3600.0; // convert m/s to m/hour

  double P = 1013.0; // Barometric pressure
  double S = 1049.7859; // Solar irradiance in Watts per meter squared solpos etr global 1049.7859
  double fdb = 1355.9448; // direct beam radiation from the sun solpos etr dir 1355.9448
  double fdif = 1049.7859; // diffuse  radiation from the sun solpos etr tilt 1049.7859
  double z = 39.2665 * pi / 180; // zenith angle in radian - 89°

  double ea = exp(17.67 * (Tdew - Ta) / (Tdew + 243.5)) * (1.0007 + 0.00000346 * P) * 6.112 * exp(17.502 * Ta / (240.97 + Ta));
  double epsilona = 0.575 * pow(ea, 1/7);

  double B = S * (fdb / 4 / sigma / cos(z) + 1.2 / sigma * fdif) + epsilona * pow(Ta, 4);
  double C = 0.315 * pow(va, 0.58) / (5.3865 * pow(10, -8));

  return (B + C * Ta + 7680000) / (C + 256000);
}

double _calcUTCI(double Ta, double va, double Tmrt, double RH){
  double ehPa = es(Ta) * RH / 100.0;
  double D_Tmrt = Tmrt - Ta;
  double Pa = ehPa / 10.0;//  convert vapour pressure to kPa

  double UTCI_approx = Ta +
      (0.607562052) +
      (-0.0227712343) * Ta +
      (8.06470249 * pow(10, (-4))) * Ta * Ta +
      (-1.54271372 * pow(10, (-4))) * Ta * Ta * Ta +
      (-3.24651735 * pow(10, (-6))) * Ta * Ta * Ta * Ta +
      (7.32602852 * pow(10, (-8))) * Ta * Ta * Ta * Ta * Ta +
      (1.35959073 * pow(10, (-9))) * Ta * Ta * Ta * Ta * Ta * Ta +
      (-2.25836520) * va +
      (0.0880326035) * Ta * va +
      (0.00216844454) * Ta * Ta * va +
      (-1.53347087 * pow(10, (-5))) * Ta * Ta * Ta * va +
      (-5.72983704 * pow(10, (-7))) * Ta * Ta * Ta * Ta * va +
      (-2.55090145 * pow(10, (-9))) * Ta * Ta * Ta * Ta * Ta * va +
      (-0.751269505) * va * va +
      (-0.00408350271) * Ta * va * va +
      (-5.21670675 * pow(10, (-5))) * Ta * Ta * va * va +
      (1.94544667 * pow(10, (-6))) * Ta * Ta * Ta * va * va +
      (1.14099531 * pow(10, (-8))) * Ta * Ta * Ta * Ta * va * va +
      (0.158137256) * va * va * va +
      (-6.57263143 * pow(10, (-5))) * Ta * va * va * va +
      (2.22697524 * pow(10, (-7))) * Ta * Ta * va * va * va +
      (-4.16117031 * pow(10, (-8))) * Ta * Ta * Ta * va * va * va +
      (-0.0127762753) * va * va * va * va +
      (9.66891875 * pow(10, (-6))) * Ta * va * va * va * va +
      (2.52785852 * pow(10, (-9))) * Ta * Ta * va * va * va * va +
      (4.56306672 * pow(10, (-4))) * va * va * va * va * va +
      (-1.74202546 * pow(10, (-7))) * Ta * va * va * va * va * va +
      (-5.91491269 * pow(10, (-6))) * va * va * va * va * va * va +
      (0.398374029) * D_Tmrt +
      (1.83945314 * pow(10, (-4))) * Ta * D_Tmrt +
      (-1.73754510 * pow(10, (-4))) * Ta * Ta * D_Tmrt +
      (-7.60781159 * pow(10, (-7))) * Ta * Ta * Ta * D_Tmrt +
      (3.77830287 * pow(10, (-8))) * Ta * Ta * Ta * Ta * D_Tmrt +
      (5.43079673 * pow(10, (-10))) * Ta * Ta * Ta * Ta * Ta * D_Tmrt +
      (-0.0200518269) * va * D_Tmrt +
      (8.92859837 * pow(10, (-4))) * Ta * va * D_Tmrt +
      (3.45433048 * pow(10, (-6))) * Ta * Ta * va * D_Tmrt +
      (-3.77925774 * pow(10, (-7))) * Ta * Ta * Ta * va * D_Tmrt +
      (-1.69699377 * pow(10, (-9))) * Ta * Ta * Ta * Ta * va * D_Tmrt +
      (1.69992415 * pow(10, (-4))) * va * va * D_Tmrt +
      (-4.99204314 * pow(10, (-5))) * Ta * va * va * D_Tmrt +
      (2.47417178 * pow(10, (-7))) * Ta * Ta * va * va * D_Tmrt +
      (1.07596466 * pow(10, (-8))) * Ta * Ta * Ta * va * va * D_Tmrt +
      (8.49242932 * pow(10, (-5))) * va * va * va * D_Tmrt +
      (1.35191328 * pow(10, (-6))) * Ta * va * va * va * D_Tmrt +
      (-6.21531254 * pow(10, (-9))) * Ta * Ta * va * va * va * D_Tmrt +
      (-4.99410301 * pow(10, (-6))) * va * va * va * va * D_Tmrt +
      (-1.89489258 * pow(10, (-8))) * Ta * va * va * va * va * D_Tmrt +
      (8.15300114 * pow(10, (-8))) * va * va * va * va * va * D_Tmrt +
      (7.55043090 * pow(10, (-4))) * D_Tmrt * D_Tmrt +
      (-5.65095215 * pow(10, (-5))) * Ta * D_Tmrt * D_Tmrt +
      (-4.52166564 * pow(10, (-7))) * Ta * Ta * D_Tmrt * D_Tmrt +
      (2.46688878 * pow(10, (-8))) * Ta * Ta * Ta * D_Tmrt * D_Tmrt +
      (2.42674348 * pow(10, (-10))) * Ta * Ta * Ta * Ta * D_Tmrt * D_Tmrt +
      (1.54547250 * pow(10, (-4))) * va * D_Tmrt * D_Tmrt +
      (5.24110970 * pow(10, (-6))) * Ta * va * D_Tmrt * D_Tmrt +
      (-8.75874982 * pow(10, (-8))) * Ta * Ta * va * D_Tmrt * D_Tmrt +
      (-1.50743064 * pow(10, (-9))) * Ta * Ta * Ta * va * D_Tmrt * D_Tmrt +
      (-1.56236307 * pow(10, (-5))) * va * va * D_Tmrt * D_Tmrt +
      (-1.33895614 * pow(10, (-7))) * Ta * va * va * D_Tmrt * D_Tmrt +
      (2.49709824 * pow(10, (-9))) * Ta * Ta * va * va * D_Tmrt * D_Tmrt +
      (6.51711721 * pow(10, (-7))) * va * va * va * D_Tmrt * D_Tmrt +
      (1.94960053 * pow(10, (-9))) * Ta * va * va * va * D_Tmrt * D_Tmrt +
      (-1.00361113 * pow(10, (-8))) * va * va * va * va * D_Tmrt * D_Tmrt +
      (-1.21206673 * pow(10, (-5))) * D_Tmrt * D_Tmrt * D_Tmrt +
      (-2.18203660 * pow(10, (-7))) * Ta * D_Tmrt * D_Tmrt * D_Tmrt +
      (7.51269482 * pow(10, (-9))) * Ta * Ta * D_Tmrt * D_Tmrt * D_Tmrt +
      (9.79063848 * pow(10, (-11))) * Ta * Ta * Ta * D_Tmrt * D_Tmrt * D_Tmrt +
      (1.25006734 * pow(10, (-6))) * va * D_Tmrt * D_Tmrt * D_Tmrt +
      (-1.81584736 * pow(10, (-9))) * Ta * va * D_Tmrt * D_Tmrt * D_Tmrt +
      (-3.52197671 * pow(10, (-10))) * Ta * Ta * va * D_Tmrt * D_Tmrt * D_Tmrt +
      (-3.36514630 * pow(10, (-8))) * va * va * D_Tmrt * D_Tmrt * D_Tmrt +
      (1.35908359 * pow(10, (-10))) * Ta * va * va * D_Tmrt * D_Tmrt * D_Tmrt +
      (4.17032620 * pow(10, (-10))) * va * va * va * D_Tmrt * D_Tmrt * D_Tmrt +
      (-1.30369025 * pow(10, (-9))) * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (4.13908461 * pow(10, (-10))) * Ta * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (9.22652254 * pow(10, (-12))) * Ta * Ta * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (-5.08220384 * pow(10, (-9))) * va * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (-2.24730961 * pow(10, (-11))) * Ta * va * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (1.17139133 * pow(10, (-10))) * va * va * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (6.62154879 * pow(10, (-10))) * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (4.03863260 * pow(10, (-13))) * Ta * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (1.95087203 * pow(10, (-12))) * va * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (-4.73602469 * pow(10, (-12))) * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt +
      (5.12733497) * Pa +
      (-0.312788561) * Ta * Pa +
      (-0.0196701861) * Ta * Ta * Pa +
      (9.99690870 * pow(10, (-4))) * Ta * Ta * Ta * Pa +
      (9.51738512 * pow(10, (-6))) * Ta * Ta * Ta * Ta * Pa +
      (-4.66426341 * pow(10, (-7))) * Ta * Ta * Ta * Ta * Ta * Pa +
      (0.548050612) * va * Pa +
      (-0.00330552823) * Ta * va * Pa +
      (-0.00164119440) * Ta * Ta * va * Pa +
      (-5.16670694 * pow(10, (-6))) * Ta * Ta * Ta * va * Pa +
      (9.52692432 * pow(10, (-7))) * Ta * Ta * Ta * Ta * va * Pa +
      (-0.0429223622) * va * va * Pa +
      (0.00500845667) * Ta * va * va * Pa +
      (1.00601257 * pow(10, (-6))) * Ta * Ta * va * va * Pa +
      (-1.81748644 * pow(10, (-6))) * Ta * Ta * Ta * va * va * Pa +
      (-1.25813502 * pow(10, (-3))) * va * va * va * Pa +
      (-1.79330391 * pow(10, (-4))) * Ta * va * va * va * Pa +
      (2.34994441 * pow(10, (-6))) * Ta * Ta * va * va * va * Pa +
      (1.29735808 * pow(10, (-4))) * va * va * va * va * Pa +
      (1.29064870 * pow(10, (-6))) * Ta * va * va * va * va * Pa +
      (-2.28558686 * pow(10, (-6))) * va * va * va * va * va * Pa +
      (-0.0369476348) * D_Tmrt * Pa +
      (0.00162325322) * Ta * D_Tmrt * Pa +
      (-3.14279680 * pow(10, (-5))) * Ta * Ta * D_Tmrt * Pa +
      (2.59835559 * pow(10, (-6))) * Ta * Ta * Ta * D_Tmrt * Pa +
      (-4.77136523 * pow(10, (-8))) * Ta * Ta * Ta * Ta * D_Tmrt * Pa +
      (8.64203390 * pow(10, (-3))) * va * D_Tmrt * Pa +
      (-6.87405181 * pow(10, (-4))) * Ta * va * D_Tmrt * Pa +
      (-9.13863872 * pow(10, (-6))) * Ta * Ta * va * D_Tmrt * Pa +
      (5.15916806 * pow(10, (-7))) * Ta * Ta * Ta * va * D_Tmrt * Pa +
      (-3.59217476 * pow(10, (-5))) * va * va * D_Tmrt * Pa +
      (3.28696511 * pow(10, (-5))) * Ta * va * va * D_Tmrt * Pa +
      (-7.10542454 * pow(10, (-7))) * Ta * Ta * va * va * D_Tmrt * Pa +
      (-1.24382300 * pow(10, (-5))) * va * va * va * D_Tmrt * Pa +
      (-7.38584400 * pow(10, (-9))) * Ta * va * va * va * D_Tmrt * Pa +
      (2.20609296 * pow(10, (-7))) * va * va * va * va * D_Tmrt * Pa +
      (-7.32469180 * pow(10, (-4))) * D_Tmrt * D_Tmrt * Pa +
      (-1.87381964 * pow(10, (-5))) * Ta * D_Tmrt * D_Tmrt * Pa +
      (4.80925239 * pow(10, (-6))) * Ta * Ta * D_Tmrt * D_Tmrt * Pa +
      (-8.75492040 * pow(10, (-8))) * Ta * Ta * Ta * D_Tmrt * D_Tmrt * Pa +
      (2.77862930 * pow(10, (-5))) * va * D_Tmrt * D_Tmrt * Pa +
      (-5.06004592 * pow(10, (-6))) * Ta * va * D_Tmrt * D_Tmrt * Pa +
      (1.14325367 * pow(10, (-7))) * Ta * Ta * va * D_Tmrt * D_Tmrt * Pa +
      (2.53016723 * pow(10, (-6))) * va * va * D_Tmrt * D_Tmrt * Pa +
      (-1.72857035 * pow(10, (-8))) * Ta * va * va * D_Tmrt * D_Tmrt * Pa +
      (-3.95079398 * pow(10, (-8))) * va * va * va * D_Tmrt * D_Tmrt * Pa +
      (-3.59413173 * pow(10, (-7))) * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (7.04388046 * pow(10, (-7))) * Ta * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (-1.89309167 * pow(10, (-8))) * Ta * Ta * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (-4.79768731 * pow(10, (-7))) * va * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (7.96079978 * pow(10, (-9))) * Ta * va * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (1.62897058 * pow(10, (-9))) * va * va * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (3.94367674 * pow(10, (-8))) * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (-1.18566247 * pow(10, (-9))) * Ta * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (3.34678041 * pow(10, (-10))) * va * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (-1.15606447 * pow(10, (-10))) * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * Pa +
      (-2.80626406) * Pa * Pa +
      (0.548712484) * Ta * Pa * Pa +
      (-0.00399428410) * Ta * Ta * Pa * Pa +
      (-9.54009191 * pow(10, (-4))) * Ta * Ta * Ta * Pa * Pa +
      (1.93090978 * pow(10, (-5))) * Ta * Ta * Ta * Ta * Pa * Pa +
      (-0.308806365) * va * Pa * Pa +
      (0.0116952364) * Ta * va * Pa * Pa +
      (4.95271903 * pow(10, (-4))) * Ta * Ta * va * Pa * Pa +
      (-1.90710882 * pow(10, (-5))) * Ta * Ta * Ta * va * Pa * Pa +
      (0.00210787756) * va * va * Pa * Pa +
      (-6.98445738 * pow(10, (-4))) * Ta * va * va * Pa * Pa +
      (2.30109073 * pow(10, (-5))) * Ta * Ta * va * va * Pa * Pa +
      (4.17856590 * pow(10, (-4))) * va * va * va * Pa * Pa +
      (-1.27043871 * pow(10, (-5))) * Ta * va * va * va * Pa * Pa +
      (-3.04620472 * pow(10, (-6))) * va * va * va * va * Pa * Pa +
      (0.0514507424) * D_Tmrt * Pa * Pa +
      (-0.00432510997) * Ta * D_Tmrt * Pa * Pa +
      (8.99281156 * pow(10, (-5))) * Ta * Ta * D_Tmrt * Pa * Pa +
      (-7.14663943 * pow(10, (-7))) * Ta * Ta * Ta * D_Tmrt * Pa * Pa +
      (-2.66016305 * pow(10, (-4))) * va * D_Tmrt * Pa * Pa +
      (2.63789586 * pow(10, (-4))) * Ta * va * D_Tmrt * Pa * Pa +
      (-7.01199003 * pow(10, (-6))) * Ta * Ta * va * D_Tmrt * Pa * Pa +
      (-1.06823306 * pow(10, (-4))) * va * va * D_Tmrt * Pa * Pa +
      (3.61341136 * pow(10, (-6))) * Ta * va * va * D_Tmrt * Pa * Pa +
      (2.29748967 * pow(10, (-7))) * va * va * va * D_Tmrt * Pa * Pa +
      (3.04788893 * pow(10, (-4))) * D_Tmrt * D_Tmrt * Pa * Pa +
      (-6.42070836 * pow(10, (-5))) * Ta * D_Tmrt * D_Tmrt * Pa * Pa +
      (1.16257971 * pow(10, (-6))) * Ta * Ta * D_Tmrt * D_Tmrt * Pa * Pa +
      (7.68023384 * pow(10, (-6))) * va * D_Tmrt * D_Tmrt * Pa * Pa +
      (-5.47446896 * pow(10, (-7))) * Ta * va * D_Tmrt * D_Tmrt * Pa * Pa +
      (-3.59937910 * pow(10, (-8))) * va * va * D_Tmrt * D_Tmrt * Pa * Pa +
      (-4.36497725 * pow(10, (-6))) * D_Tmrt * D_Tmrt * D_Tmrt * Pa * Pa +
      (1.68737969 * pow(10, (-7))) * Ta * D_Tmrt * D_Tmrt * D_Tmrt * Pa * Pa +
      (2.67489271 * pow(10, (-8))) * va * D_Tmrt * D_Tmrt * D_Tmrt * Pa * Pa +
      (3.23926897 * pow(10, (-9))) * D_Tmrt * D_Tmrt * D_Tmrt * D_Tmrt * Pa * Pa +
      (-0.0353874123) * Pa * Pa * Pa +
      (-0.221201190) * Ta * Pa * Pa * Pa +
      (0.0155126038) * Ta * Ta * Pa * Pa * Pa +
      (-2.63917279 * pow(10, (-4))) * Ta * Ta * Ta * Pa * Pa * Pa +
      (0.0453433455) * va * Pa * Pa * Pa +
      (-0.00432943862) * Ta * va * Pa * Pa * Pa +
      (1.45389826 * pow(10, (-4))) * Ta * Ta * va * Pa * Pa * Pa +
      (2.17508610 * pow(10, (-4))) * va * va * Pa * Pa * Pa +
      (-6.66724702 * pow(10, (-5))) * Ta * va * va * Pa * Pa * Pa +
      (3.33217140 * pow(10, (-5))) * va * va * va * Pa * Pa * Pa +
      (-0.00226921615) * D_Tmrt * Pa * Pa * Pa +
      (3.80261982 * pow(10, (-4))) * Ta * D_Tmrt * Pa * Pa * Pa +
      (-5.45314314 * pow(10, (-9))) * Ta * Ta * D_Tmrt * Pa * Pa * Pa +
      (-7.96355448 * pow(10, (-4))) * va * D_Tmrt * Pa * Pa * Pa +
      (2.53458034 * pow(10, (-5))) * Ta * va * D_Tmrt * Pa * Pa * Pa +
      (-6.31223658 * pow(10, (-6))) * va * va * D_Tmrt * Pa * Pa * Pa +
      (3.02122035 * pow(10, (-4))) * D_Tmrt * D_Tmrt * Pa * Pa * Pa +
      (-4.77403547 * pow(10, (-6))) * Ta * D_Tmrt * D_Tmrt * Pa * Pa * Pa +
      (1.73825715 * pow(10, (-6))) * va * D_Tmrt * D_Tmrt * Pa * Pa * Pa +
      (-4.09087898 * pow(10, (-7))) * D_Tmrt * D_Tmrt * D_Tmrt * Pa * Pa * Pa +
      (0.614155345) * Pa * Pa * Pa * Pa +
      (-0.0616755931) * Ta * Pa * Pa * Pa * Pa +
      (0.00133374846) * Ta * Ta * Pa * Pa * Pa * Pa +
      (0.00355375387) * va * Pa * Pa * Pa * Pa +
      (-5.13027851 * pow(10, (-4))) * Ta * va * Pa * Pa * Pa * Pa +
      (1.02449757 * pow(10, (-4))) * va * va * Pa * Pa * Pa * Pa +
      (-0.00148526421) * D_Tmrt * Pa * Pa * Pa * Pa +
      (-4.11469183 * pow(10, (-5))) * Ta * D_Tmrt * Pa * Pa * Pa * Pa +
      (-6.80434415 * pow(10, (-6))) * va * D_Tmrt * Pa * Pa * Pa * Pa +
      (-9.77675906 * pow(10, (-6))) * D_Tmrt * D_Tmrt * Pa * Pa * Pa * Pa +
      (0.0882773108) * Pa * Pa * Pa * Pa * Pa +
      (-0.00301859306) * Ta * Pa * Pa * Pa * Pa * Pa +
      (0.00104452989) * va * Pa * Pa * Pa * Pa * Pa +
      (2.47090539 * pow(10, (-4))) * D_Tmrt * Pa * Pa * Pa * Pa * Pa +
      (0.00148348065) * Pa * Pa * Pa * Pa * Pa * Pa;

  return UTCI_approx;
}

double es(double ta){
  // calculates saturation vapour pressure over water in hPa for input air temperature (ta) in celsius according to:
  // Hardy, R.; ITS-90 Formulations for Vapor Pressure, Frostpoint Temperature, Dewpoint Temperature and Enhancement Factors in the Range -100 to 100 °C;
  // Proceedings of Third International Symposium on Humidity and Moisture; edited by National Physical Laboratory (NPL), London, 1998, pp. 214-221
  // http://www.thunderscientific.com/tech_info/reflibrary/its90formulas.pdf (retrieved 2008-10-01)

  List<double> g =  [-2836.5744, -6028.076559, 19.54263612, -0.02737830188, 0.000016261698, 7.0229056 * pow(10, -10), -1.8680009 * pow(10, -13)] ;
  double tk = ta + 273.15;
  double es = 2.7150305 * log(tk);
  //for count, i in enumerate(g):
  for (int count = 0; count < g.length; count++){
    double i = g[count];
    es = es + (i * pow(tk, (count - 2)));
  }
  es = exp(es) * 0.01;
  return es;
}