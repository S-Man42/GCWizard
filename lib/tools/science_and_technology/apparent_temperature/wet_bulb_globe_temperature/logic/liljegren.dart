import 'dart:math';

class liljegrenOutputWBGT {
  final int Status;
  final double Tg;
  final double Tnwb;
  final double Tpsy;
  final double Twbg;
  final double Tdew;
  final double est_speed;

  liljegrenOutputWBGT(
      {this.Status = 0,
      this.Tg = 0.0,
      this.Tnwb = 0.0,
      this.Tpsy = 0.0,
      this.Twbg = 0.0,
      this.Tdew = 0.0,
      this.est_speed = 0.0});
}

class liljegrenOutputSolarPosition {
  final int Status;
  final double ap_ra; // Apparent solar right ascension.
  final double ap_dec; // Apparent solar declination.
  //  [degrees; -90.0 <= *ap_dec <= 90.0]
  final double elev; // Solar altitude, uncorrected for refraction.
  //  [degrees; -90.0 <= *altitude <= 90.0]
  final double refr; // Refraction correction for solar altitude.
  //  Add this to altitude to compensate for refraction.
  //  [degrees; 0.0 <= *refraction]
  final double azim; // Solar azimuth.
  //  [degrees; 0.0 <= *azimuth < 360.0, East is 90.0]
  final double soldist; // Distance of Sun from Earth (heliocentric-geocentric).
  //  [astronomical units; 1 a.u. is mean distance]

  liljegrenOutputSolarPosition(
      {this.Status = 0,
      this.ap_ra = 0.0,
      this.ap_dec = 0.0,
      this.elev = 0.0,
      this.refr = 0.0,
      this.azim = 0.0,
      this.soldist = 0.0});
}

class liljegrenOutputSolarParameter {
  final int Status;
  final double solar; // solar irradiance (W/m2)
  final double cza; // cosine of solar zenith angle
  final double fdir; // fraction of solar irradiance due to direct beam

  liljegrenOutputSolarParameter({this.Status = 0, this.solar = 0.0, this.cza = 0.0, this.fdir = 0.0});
}

// https://raw.githubusercontent.com/mdljts/wbgt/master/src/wbgt.c.original
// https://github.com/mdljts/wbgt/blob/master/src/wbgt.c

/*
               Copyright © 2008, UChicago Argonne, LLC
                       All Rights Reserved

                        WBGT, Version 1.1

			     James C. Liljegren
              Decision & Information Sciences Division

			     OPEN SOURCE LICENSE

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.  Software changes,
   modifications, or derivative works, should be noted with comments and
   the author and organization’s name.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the names of UChicago Argonne, LLC or the Department of Energy
   nor the names of its contributors may be used to endorse or promote products
   derived from this software without specific prior written permission.

4. The software and the end-user documentation included with the
   redistribution, if any, must include the following acknowledgment:

   "This product includes software produced by UChicago Argonne, LLC
   under Contract No. DE-AC02-06CH11357 with the Department of Energy.”

******************************************************************************************
DISCLAIMER

THE SOFTWARE IS SUPPLIED "AS IS" WITHOUT WARRANTY OF ANY KIND.

NEITHER THE UNITED STATES GOVERNMENT, NOR THE UNITED STATES DEPARTMENT OF ENERGY,
NOR UCHICAGO ARGONNE, LLC, NOR ANY OF THEIR EMPLOYEES, MAKES ANY WARRANTY, EXPRESS
OR IMPLIED, OR ASSUMES ANY LEGAL LIABILITY OR RESPONSIBILITY FOR THE ACCURACY,
COMPLETENESS, OR USEFULNESS OF ANY INFORMATION, DATA, APPARATUS, PRODUCT, OR
PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY OWNED RIGHTS.

******************************************************************************************/

/*
 *  Purpose: to demonstrate the use of the subroutine calc_wbgt to calculate
 *           the wet bulb-globe temperature (WBGT).  The program reads input
 *           data from a file containing meteorological measurements then
 *           calls calc_wbgt to compute the WBGT.
 *
 *           The inputs and outputs are fully described in calc_wbgt.
 *
 *  Author:  James C. Liljegren
 *		 Decision and Information Sciences Division
 *		 Argonne National Laboratory
 */

/* ============================================================================
 *  Purpose: to calculate the outdoor wet bulb-globe temperature, which is
 *           the weighted sum of the air temperature (dry bulb), the globe temperature,
 *           and the natural wet bulb temperature: Twbg = 0.1 * Tair + 0.7 * Tnwb + 0.2 * Tg.
 *
 *           The program predicts Tnwb and Tg using meteorological input data then combines
 *           the results to produce Twbg.
 *
 *		 Modified 2-Nov-2009: calc_wbgt returns -1 if either subroutines Tg or Tnwb return -9999,
 *		 which signals a failure to converge, probably due to a bad input value; otherwise, calc_wbgt
 *		 returns 0.
 *
 *           If the 2-m wind speed is not available, it is estimated using a wind speed at another level.
 *
 *  Reference: Liljegren, J. C., R. A. Carhart, P. Lawday, S. Tschopp, and R. Sharp:
 *             Modeling the Wet Bulb Globe Temperature Using Standard Meteorological
 *             Measurements. The Journal of Occupational and Environmental Hygiene,
 *             vol. 5:10, pp. 645-655, 2008.
 *
 *  Author:  James C. Liljegren
 *		 Decision and Information Sciences Division
 *		 Argonne National Laboratory
 */

const TRUE = true;
const FALSE = false;

// define functions
double _max(double a, double b) {
  if (a > b) return a;
  return b;
}

double _min(double a, double b) {
  if (a < b) return a;
  return b;
}

double _fabs(double x) {
  return x.abs();
}

double _modf(double x, double y) {
  return (x - x.floorToDouble());
}

// define mathematical constants
const _PI = pi; // 3.1415926535897932
const _TWOPI = 2 * pi; // 6.2831853071795864
const _DEG_RAD = pi / 180; // 0.017453292519943295
const _RAD_DEG = 180 / pi; // 57.295779513082323

// define physical constants
const SOLAR_CONST = 1367.0;
const GRAVITY = 9.807;
const STEFANB = 5.6696E-8;
const Cp = 1003.5;
const M_AIR = 28.97;
const M_H2O = 18.015;
const RATIO = (Cp * M_AIR / M_H2O);
const R_GAS = 8314.34;
const R_AIR = (R_GAS / M_AIR);
const Pr = (Cp / (Cp + 1.25 * R_AIR));

// define wick constants
const EMIS_WICK = 0.95;
const ALB_WICK = 0.4;
const D_WICK = 0.007;
const L_WICK = 0.0254;

// define globe constants
const EMIS_GLOBE = 0.95;
const ALB_GLOBE = 0.05;
const D_GLOBE = 0.0508;

// define surface constants
const EMIS_SFC = 0.999;
const ALB_SFC = 0.45;

// define computational and physical limits
const CZA_MIN = 0.00873;
const NORMSOLAR_MAX = 0.85;
const REF_HEIGHT = 2.0;
const MIN_SPEED = 0.13;
const CONVERGENCE = 0.02;
const MAX_ITER = 50;

liljegrenOutputWBGT calc_wbgt({
  required int year, // 4-digit, e.g. 2007
  required int month, // month (1-12) or month = 0 implies iday is day of year
  required int day, // day of month or day of year (1-366)
  required int hour, // hour in local standard time (LST)
  required int minute, // minutes past the hour
  required int gmt, // LST-GMT difference, hours (negative in USA)
  required int avg, // averaging time of meteorological inputs, minutes
  required double lat, // north latitude, decimal
  required double lon, // east longitude, decimal (negative in USA)
  required double solar, // solar irradiance, W/m2
  required double pres, // barometric pressure, mb
  required double Tair, // air (dry bulb) temperature, degC	*/
  required double relhum, // relative humidity, %
  required double speed, // wind speed, m/s
  required double zspeed, // height of wind speed measurement, m
  required double dT, // vertical temperature difference (upper minus lower), degC
  required int urban, // select "urban" (1) or "rural" (0) wind speed power law exponent
}) {
  double Tg = 0.0; // globe temperature, degC
  double Tnwb = 0.0; // natural wet bulb temperature, degC
  double Tpsy = 0.0; // psychrometric wet bulb temperature, degC
  double Twbg = 0.0; // wet bulb globe temperature, degC
  double Tdew = 0.0; // dew point temperAture
  double est_speed = 0.0; // estimated speed at reference height, m/s
  double cza = 0.0; // cosine of solar zenith angle
  double fdir = 0.0; // fraction of solar irradiance due to direct beam
  double tk = 0.0; // temperature converted to kelvin
  double rh = 0.0; // relative humidity, fraction between 0 and 1
  double hour_gmt = 0.0;
  double dday = 0.0;

  int daytime;
  int stability_class;

  // convert time to GMT and center in avg period;
  hour_gmt = hour - gmt + (minute - 0.5 * avg) / 60.0;
  dday = day + hour_gmt / 24.0;

  // calculate the cosine of the solar zenith angle and fraction of solar irradiance
  // due to the direct beam; adjust the solar irradiance if it is out of bounds
  liljegrenOutputSolarParameter solpar = _calc_solar_parameters(year, month, dday, solar, lat, lon);
  solar = solpar.solar;
  cza = solpar.cza;
  fdir = solpar.fdir;

  // estimate the wind speed, if necessary
  if (zspeed != REF_HEIGHT) {
    if (cza > 0.0) {
      daytime = 1;
    } else {
      daytime = 0;
    }
    stability_class = _stab_srdt(daytime, speed, solar, dT);
    est_speed = _est_wind_speed(speed, zspeed, stability_class, urban);
    speed = est_speed;
  }

  // unit conversions
  tk = Tair + 273.15; // degC to kelvin
  rh = 0.01 * relhum; // % to fraction

  // calculate the globe, natural wet bulb, psychrometric wet bulb and outdoor wet bulb globe temperatures
  Tg = Tglobe(tk, rh, pres, speed, solar, fdir, cza);
  Tnwb = _Twb(tk, rh, pres, speed, solar, fdir, cza, 1); // - 273.15;
  Tpsy = _Twb(tk, rh, pres, speed, solar, fdir, cza, 0); // - 273.15;
  Twbg = 0.1 * Tair + 0.2 * Tg + 0.7 * Tnwb;
  Tdew = _dew_point(rh * _esat(tk, 0), 0) - 273.15;

  if (Tg == -9999 || Tnwb == -9999) {
    Twbg = -9999;
    return liljegrenOutputWBGT(
        Status: -1, Tg: Tg, Tnwb: Tnwb, Tpsy: Tpsy, Twbg: Twbg, Tdew: Tdew, est_speed: est_speed);
  } else {
    return liljegrenOutputWBGT(Status: 0, Tg: Tg, Tnwb: Tnwb, Tpsy: Tpsy, Twbg: Twbg, Tdew: Tdew, est_speed: est_speed);
  }
}

/* ============================================================================
 *  Purpose: to calculate the cosine solar zenith angle and the fraction of the
 *		 solar irradiance due to the direct beam.
 *
 *  Author:  James C. Liljegren
 *		 Decision and Information Sciences Division
 *		 Argonne National Laboratory
 */
liljegrenOutputSolarParameter _calc_solar_parameters(
  int year, // 4-digit year, e.g., 2007
  int month, // 2-digit month; month = 0 implies day = day of year
  double day, // day.fraction of month if month > 0;
  // else day.fraction of year if month = 0 (GMT)
  double solar, // solar irradiance (W/m2)
  double lat, // north latitude
  double lon, // east latitude (negative in USA)
) {
  double cza; // cosine of solar zenith angle
  double fdir; // fraction of solar irradiance due to direct beam

  double toasolar = 0.0;
  double normsolar = 0.0;

  double days_1900 = 0.0;
  double ap_ra = 0.0;
  double ap_dec = 0.0;
  double elev = 0.0;
  double refr = 0.0;
  double azim = 0.0;
  double soldist = 0.0;

  liljegrenOutputSolarPosition solpos = _solarposition(year, month, day, days_1900, lat, lon);
  ap_ra = solpos.ap_ra;
  ap_dec = solpos.ap_dec;
  elev = solpos.elev;
  refr = solpos.refr;
  azim = solpos.azim;
  soldist = solpos.soldist;

  cza = cos((90.0 - elev) * _DEG_RAD);
  toasolar = SOLAR_CONST * _max(0.0, cza) / soldist * soldist;

  //  if the sun is not fully above the horizon set the maximum (top of atmosphere) solar = 0
  if (cza < CZA_MIN) toasolar = 0.0;
  if (toasolar > 0.0) {
    // account for any solar sensor calibration errors and make the solar irradiance consistent with normsolar
    normsolar = _min(solar / toasolar, NORMSOLAR_MAX);
    solar = normsolar * toasolar;
    // calculate the fraction of the solar irradiance due to the direct beam
    if (normsolar > 0.0) {
      fdir = exp(3.0 - 1.34 * normsolar - 1.65 / normsolar);
      fdir = _max(_min(fdir, 0.9), 0.0);
    } else {
      fdir = 0.0;
    }
  } else {
    fdir = 0.0;
  }

  return liljegrenOutputSolarParameter(Status: 0, fdir: fdir, solar: solar, cza: cza);
}

/* ============================================================================
 *  Purpose: to calculate the natural wet bulb temperature.
 *
 *  Author:  James C. Liljegren
 *		 Decision and Information Sciences Division
 *		 Argonne National Laboratory
 */
double _Twb(
  double Tair, // air (dry bulb) temperature, degC
  double rh, // relative humidity
  double Pair, // barometric pressure, mb
  double speed, // wind speed, m/s
  double solar, // solar irradiance, W/m2
  double fdir, // fraction of solar irradiance due to direct beam
  double cza, // cosine of solar zenith angle
  int rad, // switch to enable/disable radiative heating;
  // no radiative heating --> pyschrometric wet bulb temp
) {
  double a = 0.56; // from Bedingfield and Drew

  double sza = 0.0;
  double Tsfc = 0.0;
  double Tdew = 0.0;
  double Tref = 0.0;
  double Twb_prev = 0.0;
  double Twb_new = 0.0;
  double eair = 0.0;
  double ewick = 0.0;
  double density = 0.0;
  double Sc = 0.0; // Schmidt number
  double h = 0.0; // convective heat transfer coefficient
  double Fatm = 0.0; // radiative heating term

  bool converged;
  int iter;

  Tsfc = Tair;
  sza = acos(cza); // solar zenith angle, radians
  eair = rh * _esat(Tair, 0);
  Tdew = _dew_point(eair, 0);
  Twb_prev = Tdew; // first guess is the dew point temperature
  converged = FALSE;
  iter = 0;
  do {
    iter++;
    Tref = 0.5 * (Twb_prev + Tair); // evaluate properties at the average temperature
    h = _h_cylinder_in_air(D_WICK, L_WICK, Tref, Pair, speed);
    Fatm = STEFANB *
            EMIS_WICK *
            (0.5 * (_emis_atm(Tair, rh) * pow(Tair, 4.0) + EMIS_SFC * pow(Tsfc, 4.0)) - pow(Twb_prev, 4.0)) +
        (1.0 - ALB_WICK) *
            solar *
            ((1.0 - fdir) * (1.0 + 0.25 * D_WICK / L_WICK) +
                fdir * ((tan(sza) / _PI) + 0.25 * D_WICK / L_WICK) +
                ALB_SFC);
    ewick = _esat(Twb_prev, 0);
    density = Pair * 100.0 / (R_AIR * Tref);
    Sc = _viscosity(Tref) / (density * _diffusivity(Tref, Pair));
    Twb_new = Tair - _evap(Tref) / RATIO * (ewick - eair) / (Pair - ewick) * pow(Pr / Sc, a) + (Fatm / h * rad);
    if (_fabs(Twb_new - Twb_prev) < CONVERGENCE) converged = TRUE;
    Twb_prev = 0.9 * Twb_prev + 0.1 * Twb_new;
  } while (!converged && iter < MAX_ITER);
  if (converged) {
    return (Twb_new - 273.15);
  } else {
    return (-9999.0);
  }
}

/* ============================================================================
 * Purpose: to calculate the convective heat transfer coefficient in W/(m2 K)
 *          for a long cylinder in cross flow.
 *
 * Reference: Bedingfield and Drew, eqn 32
 *
 */
double _h_cylinder_in_air(
  double diameter, // cylinder diameter, m
  double length, // cylinder length, m
  double Tair, // air temperature, K
  double Pair, // barometric pressure, mb
  double speed, // fluid (wind) speed, m/s
) {
  double a = 0.56; // parameters from Bedingfield and Drew
  double b = 0.281;
  double c = 0.4;

  double density = 0.0;
  double Re = 0.0; // Reynolds number
  double Nu = 0.0; // Nusselt number

  density = Pair * 100.0 / (R_AIR * Tair);
  Re = _max(speed, MIN_SPEED) * density * diameter / _viscosity(Tair);
  Nu = b * pow(Re, (1.0 - c)) * pow(Pr, (1.0 - a));
  return (Nu * _thermal_cond(Tair) / diameter);
}

/* ============================================================================
 *  Purpose: to calculate the globe temperature.
 *
 *  Author:  James C. Liljegren
 *		 Decision and Information Sciences Division
 *		 Argonne National Laboratory
 */
double Tglobe(
  double Tair, // air (dry bulb) temperature, degC
  double rh, // relative humidity, fraction between 0 and 1
  double Pair, // barometric pressure, mb
  double speed, // wind speed, m/s
  double solar, // solar irradiance, W/m2
  double fdir, // fraction of solar irradiance due to direct beam
  double cza, // cosine of solar zenith angle
) {
  double Tsfc = 0.0;
  double Tref = 0.0;
  double Tglobe_prev = 0.0;
  double Tglobe_new = 0.0;
  double h = 0.0;

  bool converged;
  int iter;

  Tsfc = Tair;
  Tglobe_prev = Tair; // first guess is the air temperature
  converged = FALSE;
  iter = 0;
  do {
    iter++;
    Tref = 0.5 * (Tglobe_prev + Tair); // evaluate properties at the average temperature
    h = _h_sphere_in_air(D_GLOBE, Tref, Pair, speed);
    Tglobe_new = pow(
        0.5 * (_emis_atm(Tair, rh) * pow(Tair, 4.0) + EMIS_SFC * pow(Tsfc, 4.0)) -
            h / (STEFANB * EMIS_GLOBE) * (Tglobe_prev - Tair) +
            solar /
                (2.0 * STEFANB * EMIS_GLOBE) *
                (1.0 - ALB_GLOBE) *
                (fdir * (1.0 / (2.0 * cza) - 1.0) + 1.0 + ALB_SFC),
        0.25) as double;
    if (_fabs(Tglobe_new - Tglobe_prev) < CONVERGENCE) converged = TRUE;
    Tglobe_prev = 0.9 * Tglobe_prev + 0.1 * Tglobe_new;
  } while (!converged && iter < MAX_ITER);

  if (converged) {
    return (Tglobe_new - 273.15);
  } else {
    return (-9999.0);
  }
}

/* ============================================================================
 * Purpose: to calculate the convective heat transfer coefficient, W/(m2 K)
 *          for flow around a sphere.
 *
 * Reference: Bird, Stewart, and Lightfoot (BSL), page 409.
 *
 */
double _h_sphere_in_air(
  double diameter, // sphere diameter, m
  double Tair, // air temperature, K
  double Pair, // barometric pressure, mb
  double speed, // fluid (air) speed, m/s
) {
  double density = 0.0;
  double Re = 0.0; // Reynolds number
  double Nu = 0.0; // Nusselt number

  density = Pair * 100.0 / (R_AIR * Tair);
  Re = _max(speed, MIN_SPEED) * density * diameter / _viscosity(Tair);
  Nu = 2.0 + 0.6 * sqrt(Re) * pow(Pr, 0.3333);
  return (Nu * _thermal_cond(Tair) / diameter);
}

/* ============================================================================
 *  Purpose: calculate the saturation vapor pressure (mb) over liquid water
 *           (phase = 0) or ice (phase = 1).
 *
 *  Reference: Buck's (1981) approximation (eqn 3) of Wexler's (1976) formulae.
 */
double _esat(
    double tk, // air temperature, K
    int phase) {
  // 0 = over liquid water; 1 = over ice
  double y = 0.0;
  double es = 0.0;

  if (phase == 0) {
    /* over liquid water */
    y = (tk - 273.15) / (tk - 32.18);
    es = 6.1121 * exp(17.502 * y);
//		es = (1.0007 + (3.46E-6 * pres)) * es /* correction for moist air, if pressure is available
  } else {
    /* over ice */
    y = (tk - 273.15) / (tk - 0.6);
    es = 6.1115 * exp(22.452 * y);
//		es = (1.0003 + (4.18E-6 * pres)) * es /* correction for moist air, if pressure is available
  }

  es = 1.004 * es; /* correction for moist air, if pressure is not available; for pressure > 800 mb */
//	es = 1.0034 * es; /* correction for moist air, if pressure is not available; for pressure down to 200 mb

  return (es);
}

/* ============================================================================
 *  Purpose: calculate the dew point (phase=0) or frost point (phase=1)
 *           temperature, K.
 */
double _dew_point(
    double e, // vapor pressure, mb
    int phase) {
  // 0 = dewpoint; 1 = frostpoint

  double z = 0.0;
  double tdk = 0.0;

  if (phase == 0) {
    /* dew point */
    z = log(e / (6.1121 * 1.004));
    tdk = 273.15 + 240.97 * z / (17.502 - z);
  } else {
    /* frost point */
    z = log(e / (6.1115 * 1.004));
    tdk = 273.15 + 272.55 * z / (22.452 - z);
  }

  return (tdk);
}

/* ============================================================================
 *  Purpose: calculate the viscosity of air, kg/(m s)
 *
 *  Reference: BSL, page 23.
 */
double _viscosity(double Tair) {
  /* air temperature, K */
  double sigma = 3.617;
  double eps_kappa = 97.0;

  double Tr = 0.0;
  double omega = 0.0;

  Tr = Tair / eps_kappa;
  omega = (Tr - 2.9) / 0.4 * (-0.034) + 1.048;
  return (2.6693E-6 * sqrt(M_AIR * Tair) / (sigma * sigma * omega));
}

/* ============================================================================
 *  Purpose: calculate the thermal conductivity of air, W/(m K)
 *
 *  Reference: BSL, page 257.
 */
double _thermal_cond(double Tair // air temperature, K
    ) {
  return ((Cp + 1.25 * R_AIR) * _viscosity(Tair));
}

/* ============================================================================
 *  Purpose: calculate the diffusivity of water vapor in air, m2/s
 *
 *  Reference: BSL, page 505.
 */
double _diffusivity(
  double Tair, // Air temperature, K
  double Pair, // Barometric pressure, mb
) {
  double Pcrit_air = 36.4;
  double Pcrit_h2o = 218.0;
  double Tcrit_air = 132.0;
  double Tcrit_h2o = 647.3;
  double a = 3.640E-4;
  double b = 2.334;

  double Patm, Pcrit13, Tcrit512, Tcrit12, Mmix;

  Pcrit13 = pow((Pcrit_air * Pcrit_h2o), (1.0 / 3.0)) as double;
  Tcrit512 = pow((Tcrit_air * Tcrit_h2o), (5.0 / 12.0)) as double;
  Tcrit12 = sqrt(Tcrit_air * Tcrit_h2o);
  Mmix = sqrt(1.0 / M_AIR + 1.0 / M_H2O);
  Patm = Pair / 1013.25; /* convert pressure from mb to atmospheres */

  return (a * pow((Tair / Tcrit12), b) * Pcrit13 * Tcrit512 * Mmix / Patm * 1E-4);
}

/* ============================================================================
 *  Purpose: calculate the heat of evaporation, J/(kg K), for temperature
 *           in the range 283-313 K.
 *
 *  Reference: Van Wylen and Sonntag, Table A.1.1
 */
double _evap(double Tair // air temperature, K
    ) {
  return ((313.15 - Tair) / 30.0 * (-71100.0) + 2.4073E6);
}

/* ============================================================================
 *  Purpose: calculate the atmospheric emissivity.
 *
 *  Reference: Oke (2nd edition), page 373.
 */
double _emis_atm(
    double Tair, // air temperature, K
    double rh // relative humidity, fraction between 0 and 1
    ) {

  double e = rh * _esat(Tair, 0);
  return (0.575 * pow(e, 0.143));
}

/* ============================================================================
 *  Version 3.0 - February 20, 1992.
 *
 *  solarposition() employs the low precision formulas for the Sun's coordinates
 *  given in the "Astronomical Almanac" of 1990 to compute the Sun's apparent
 *  right ascension, apparent declination, altitude, atmospheric refraction
 *  correction applicable to the altitude, azimuth, and distance from Earth.
 *  The "Astronomical Almanac" (A. A.) states a precision of 0.01 degree for the
 *  apparent coordinates between the years 1950 and 2050, and an accuracy of
 *  0.1 arc minute for refraction at altitudes of at least 15 degrees.
 *
 *  The following assumptions and simplifications are made:
 *  -> refraction is calculated for standard atmosphere pressure and temperature
 *     at sea level.
 *  -> diurnal parallax is ignored, resulting in 0 to 9 arc seconds error in
 *     apparent position.
 *  -> diurnal aberration is also ignored, resulting in 0 to 0.02 second error
 *     in right ascension and 0 to 0.3 arc second error in declination.
 *  -> geodetic site coordinates are used, without correction for polar motion
 *     (maximum amplitude of 0.3 arc second) and local gravity anomalies.
 *  -> local mean sidereal time is substituted for local apparent sidereal time
 *     in computing the local hour angle of the Sun, resulting in an error of
 *     about 0 to 1 second of time as determined explicitly by the equation of
 *     the equinoxes.
 *
 *  Right ascension is measured in hours from 0 to 24, and declination in
 *  degrees from 90 to -90.
 *  Altitude is measured from 0 degrees at the horizon to 90 at the zenith or
 *  -90 at the nadir. Azimuth is measured from 0 to 360 degrees starting at
 *  north and increasing toward the east at 90.
 *  The refraction correction should be added to the altitude if Earth's
 *  atmosphere is to be accounted for.
 *  Solar distance from Earth is in astronomical units, 1 a.u. representing the
 *  mean value.
 *
 *  The necessary input parameters are:
 *  -> the date, specified in one of three ways:
 *       1) year, month, day.fraction
 *       2) year, daynumber.fraction
 *       3) days.fraction elapsed since January 0, 1900.
 *  -> site geodetic (geographic) latitude and longitude.
 *
 *  Refer to the function declaration for the parameter type specifications and
 *  formats.
 *
 *  solarposition() returns -1 if an input parameter is out of bounds, or 0 if
 *  values were written to the locations specified by the output parameters.
 *
 *  Author: Nels Larson
 *          Pacific Northwest National Laboratory
 *          P.O. Box 999
 *          Richland, WA 99352
 *          U.S.A.
 */
liljegrenOutputSolarPosition _solarposition(
  int year,
  // Four digit year (Gregorian calendar).  [1950 through 2049; 0 o.k. if using days_1900]
  int month,
  // Month number.   [1 through 12; 0 o.k. if using daynumber for day]
  double day,
  /* Calendar day.fraction, or daynumber.fraction.
                       *   [If month is NOT 0:
                       *      0 through 32; 31st @ 18:10:00 UT = 31.75694
                       *    If month IS 0:
                       *      0 through 367; 366 @ 18:10:00 UT = 366.75694] */
  double days_1900,
  /* Days since 1900 January 0 @ 00:00:00 UT.
                       *   [18262.0 (1950/01/00) through 54788.0 (2049/12/32);
                       *    1990/01/01 @ 18:10:00 UT = 32873.75694;
                       *    0.0 o.k. if using {year, month, day} or
                       *    {year, daynumber}] */
  double latitude, // Observation site geographic latitude.  [degrees.fraction, North positive]
  double longitude, // Observation site geographic longitude. [degrees.fraction, East positive]
) {

  double ap_ra = 0.0; /* Apparent solar right ascension. [hours; 0.0 <= *ap_ra < 24.0] */
  double ap_dec = 0.0; /* Apparent solar declination. [degrees; -90.0 <= *ap_dec <= 90.0] */
  double altitude = 0.0; // Solar altitude, uncorrected for refraction. [degrees; -90.0 <= *altitude <= 90.0]
  double refraction =
      0.0; // Refraction correction for solar altitude. Add this to altitude to compensate for refraction. [degrees; 0.0 <= *refraction]
  double azimuth = 0.0; // Solar azimuth. [degrees; 0.0 <= *azimuth < 360.0, East is 90.0]
  double distance =
      0.0; // Distance of Sun from Earth (heliocentric-geocentric). [astronomical units; 1 a.u. is mean distance]

  int daynumber = 0; // Sequential daynumber during a year.
  int delta_days = 0; // Whole days since 2000 January 0.
  int delta_years = 0; // Whole years since 2000./
  double cent_J2000 = 0.0; // Julian centuries since epoch J2000.0 at 0h UT.
  double cos_alt = 0.0; // Cosine of the altitude of Sun.
  double cos_apdec = 0.0; // Cosine of the apparent declination of Sun.
  double cos_az = 0.0; // Cosine of the azimuth of Sun.
  double cos_lat = 0.0; // Cosine of the site latitude.
  double cos_lha = 0.0; // Cosine of the local apparent hour angle of Sun.
  double days_J2000 = 0.0; // Days since epoch J2000.0.
  double ecliptic_long = 0.0; // Solar ecliptic longitude.
  double lmst = 0.0; // Local mean sidereal time.
  double local_ha = 0.0; // Local mean hour angle of Sun.
  double gmst0h = 0.0; // Greenwich mean sidereal time at 0 hours UT.
  double integral = 0.0; // Integral portion of double precision number.
  double mean_anomaly = 0.0; // Earth mean anomaly.
  double mean_longitude = 0.0; // Solar mean longitude.
  double mean_obliquity = 0.0; // Mean obliquity of the ecliptic.
  double pressure = 1013.25; // Earth mean atmospheric pressure at sea level in millibars.
  double sin_apdec = 0.0; // Sine of the apparent declination of Sun.
  double sin_az = 0.0; // Sine of the azimuth of Sun.
  double sin_lat = 0.0; // Sine of the site latitude.
  double tan_alt = 0.0; // Tangent of the altitude of Sun.
  double temp = 15.0; // Earth mean atmospheric temperature at sea level in degrees Celsius.
  double ut = 0.0; // UT hours since midnight.

  /* Check latitude and longitude for proper range before calculating dates.
   */
  if (latitude < -90.0 || latitude > 90.0 || longitude < -180.0 || longitude > 180.0) {
    return liljegrenOutputSolarPosition(Status: -1, ap_ra: ap_ra, ap_dec: ap_dec, elev: altitude, azim: azimuth, soldist: distance, refr: refraction);
  }

  /* If year is not zero then assume date is specified by year, month, day.
   * If year is zero then assume date is specified by days_1900.
   */
  if (year != 0)
  /* Date given by {year, month, day} or {year, 0, daynumber}. */
  {
    if (year < 1950 || year > 2049) {
      return liljegrenOutputSolarPosition(Status: -1, ap_ra: ap_ra, ap_dec: ap_dec, elev: altitude, azim: azimuth, soldist: distance, refr: refraction);
    }
    if (month != 0) {
      if (month < 1 || month > 12 || day < 0.0 || day > 33.0) {
        return liljegrenOutputSolarPosition(Status: -1, ap_ra: ap_ra, ap_dec: ap_dec, elev: altitude, azim: azimuth, soldist: distance, refr: refraction);
      }

      daynumber = _daynum(year, month, day.toInt());
    } else {
      if (day < 0.0 || day > 368.0) {
        return liljegrenOutputSolarPosition(Status: -1, ap_ra: ap_ra, ap_dec: ap_dec, elev: altitude, azim: azimuth, soldist: distance, refr: refraction);
      }

      daynumber = day.toInt();
    }

    /* Construct Julian centuries since J2000 at 0 hours UT of date,
     * days.fraction since J2000, and UT hours.
     */
    delta_years = year - 2000;
    /* delta_days is days from 2000/01/00 (1900's are negative). */
    delta_days = (delta_years * 365 + delta_years / 4 + daynumber).toInt();
    if (year > 2000) {
      delta_days += 1;
    }
    /* J2000 is 2000/01/01.5 */
    days_J2000 = delta_days - 1.5;

    cent_J2000 = days_J2000 / 36525.0;

    ut = _modf(day, integral);
    days_J2000 += ut;
    ut *= 24.0;
  } else
  /* Date given by days_1900. */
  {
    /* days_1900 is 18262 for 1950/01/00, and 54788 for 2049/12/32.
     * A. A. 1990, K2-K4. */
    if (days_1900 < 18262.0 || days_1900 > 54788.0) {
      return liljegrenOutputSolarPosition(Status: -1, ap_ra: ap_ra, ap_dec: ap_dec, elev: altitude, azim: azimuth, soldist: distance, refr: refraction);
    }

    /* Construct days.fraction since J2000, UT hours, and
     * Julian centuries since J2000 at 0 hours UT of date.
     */
    /* days_1900 is 36524 for 2000/01/00. J2000 is 2000/01/01.5 */
    days_J2000 = days_1900 - 36525.5;

    ut = _modf(days_1900, integral) * 24.0;

    cent_J2000 = (integral - 36525.5) / 36525.0;
  }

  /* Compute solar position parameters.
   * A. A. 1990, C24.
   */
  mean_anomaly = (357.528 + 0.9856003 * days_J2000);
  mean_longitude = (280.460 + 0.9856474 * days_J2000);

  /* Put mean_anomaly and mean_longitude in the range 0 -> 2 pi. */
  mean_anomaly = _modf(mean_anomaly / 360.0, integral) * _TWOPI;
  mean_longitude = _modf(mean_longitude / 360.0, integral) * _TWOPI;

  mean_obliquity = (23.439 - 4.0e-7 * days_J2000) * _DEG_RAD;
  ecliptic_long = ((1.915 * sin(mean_anomaly)) + (0.020 * sin(2.0 * mean_anomaly))) * _DEG_RAD + mean_longitude;

  distance = 1.00014 - 0.01671 * cos(mean_anomaly) - 0.00014 * cos(2.0 * mean_anomaly);

  /* Tangent of ecliptic_long separated into sine and cosine parts for ap_ra. */
  ap_ra = atan2(cos(mean_obliquity) * sin(ecliptic_long), cos(ecliptic_long));

  /* Change range of ap_ra from -pi -> pi to 0 -> 2 pi. */
  if (ap_ra < 0.0) {
    ap_ra += _TWOPI;
  }
  /* Put ap_ra in the range 0 -> 24 hours. */
  ap_ra = _modf(ap_ra / _TWOPI, integral) * 24.0;

  ap_dec = asin(sin(mean_obliquity) * sin(ecliptic_long));

  /* Calculate local mean sidereal time.
   * A. A. 1990, B6-B7.
   */

  /* Horner's method of polynomial exponent expansion used for gmst0h. */
  gmst0h = 24110.54841 + cent_J2000 * (8640184.812866 + cent_J2000 * (0.093104 - cent_J2000 * 6.2e-6));
  /* Convert gmst0h from seconds to hours and put in the range 0 -> 24. */
  gmst0h = _modf(gmst0h / 3600.0 / 24.0, integral) * 24.0;
  if (gmst0h < 0.0) {
    gmst0h += 24.0;
  }

  /* Ratio of lengths of mean solar day to mean sidereal day is 1.00273790934
   * in 1990. Change in sidereal day length is < 0.001 second over a century.
   * A. A. 1990, B6.
   */
  lmst = gmst0h + (ut * 1.00273790934) + longitude / 15.0;
  /* Put lmst in the range 0 -> 24 hours. */
  lmst = _modf(lmst / 24.0, integral) * 24.0;
  if (lmst < 0.0) {
    lmst += 24.0;
  }

  /* Calculate local hour angle, altitude, azimuth, and refraction correction.
   * A. A. 1990, B61-B62.
   */

  local_ha = lmst - ap_ra;
  /* Put hour angle in the range -12 to 12 hours. */
  if (local_ha < -12.0) {
    local_ha += 24.0;
  } else if (local_ha > 12.0) {
    local_ha -= 24.0;
  }

  /* Convert latitude and local_ha to radians. */
  latitude *= _DEG_RAD;
  local_ha = local_ha / 24.0 * _TWOPI;

  cos_apdec = cos(ap_dec);
  sin_apdec = sin(ap_dec);
  cos_lat = cos(latitude);
  sin_lat = sin(latitude);
  cos_lha = cos(local_ha);

  altitude = asin(sin_apdec * sin_lat + cos_apdec * cos_lha * cos_lat);

  cos_alt = cos(altitude);
  /* Avoid tangent overflow at altitudes of +-90 degrees.
   * 1.57079615 radians is equal to 89.99999 degrees.
   */
  if (_fabs(altitude) < 1.57079615) {
    tan_alt = tan(altitude);
  } else {
    tan_alt = 6.0e6;
  }

  cos_az = (sin_apdec * cos_lat - cos_apdec * cos_lha * sin_lat) / cos_alt;
  sin_az = -(cos_apdec * sin(local_ha) / cos_alt);
  azimuth = acos(cos_az);

  /* Change range of azimuth from 0 -> pi to 0 -> 2 pi. */
  if (atan2(sin_az, cos_az) < 0.0) {
    azimuth = _TWOPI - azimuth;
  }

  /* Convert ap_dec, altitude, and azimuth to degrees. */
  ap_dec *= _RAD_DEG;
  altitude *= _RAD_DEG;
  azimuth *= _RAD_DEG;

  /* Compute refraction correction to be added to altitude to obtain actual
   * position.
   * Refraction calculated for altitudes of -1 degree or more allows for a
   * pressure of 1040 mb and temperature of -22 C. Lower pressure and higher
   * temperature combinations yield less than 1 degree refraction.
   * NOTE:
   * The two equations listed in the A. A. have a crossover altitude of
   * 19.225 degrees at standard temperature and pressure. This crossover point
   * is used instead of 15 degrees altitude so that refraction is smooth over
   * the entire range of altitudes. The maximum residual error introduced by
   * this smoothing is 3.6 arc seconds at 15 degrees. Temperature or pressure
   * other than standard will shift the crossover altitude and change the error.
   */
  if (altitude < -1.0 || tan_alt == 6.0e6) {
    refraction = 0.0;
  } else {
    if (altitude < 19.225) {
      refraction = (0.1594 + (altitude) * (0.0196 + 0.00002 * (altitude))) * pressure;
      refraction /= (1.0 + (altitude) * (0.505 + 0.0845 * (altitude))) * (273.0 + temp);
    } else {
      refraction = 0.00452 * (pressure / (273.0 + temp)) / tan_alt;
    }
  }
/*
 *  to match Michalsky's sunae program, the following line was inserted
 *  by JC Liljegren to add the refraction correction to the solar altitude
 */
  altitude = altitude + refraction;
  return liljegrenOutputSolarPosition(
      Status: 0, elev: altitude, refr: refraction, azim: azimuth, soldist: distance, ap_dec: ap_dec, ap_ra: ap_ra);
}

/* ============================================================================
 * 'daynum()' returns the sequential daynumber of a calendar date during a
 *  Gregorian calendar year (for years 1 onward).
 *  The integer arguments are the four-digit year, the month number, and
 *  the day of month number.
 *  (Jan. 1 = 01/01 = 001; Dec. 31 = 12/31 = 365 or 366.)
 *  A value of -1 is returned if the year is out of bounds.
 *
 * Author: Nels Larson
 *         Pacific Northwest Lab.
 *         P.O. Box 999
 *         Richland, WA 99352
 *         U.S.A.
 */
int _daynum(int year, int month, int day) {
  List<int> begmonth = [0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
  int dnum;
  bool leapyr = FALSE;

  /* There is no year 0 in the Gregorian calendar and the leap year cycle
   * changes for earlier years. */

  if (year < 1) {
    return (-1);
  }

  /* Leap years are divisible by 4, except for centurial years not divisible
   * by 400. */

  if (((year % 4) == 0 && (year % 100) != 0) || (year % 400) == 0) {
    leapyr = TRUE;
  }

  dnum = begmonth[month] + day;
  if (leapyr && (month > 2)) {
    dnum += 1;
  }

  return (dnum);
}

/* ============================================================================
 *  Purpose: estimate 2-m wind speed for all stability conditions
 *
 *  Reference: EPA-454/5-99-005, 2000, section 6.2.5
 */
double _est_wind_speed(double speed, double zspeed, int stability_class, int urban) {
  List<double> urban_exp = [0.15, 0.15, 0.20, 0.25, 0.30, 0.30];
  List<double> rural_exp = [0.07, 0.07, 0.10, 0.15, 0.35, 0.55];
  double exponent, est_speed;

  if (urban == 1) {
    exponent = urban_exp[stability_class - 1];
  } else {
    exponent = rural_exp[stability_class - 1];
  }

  est_speed = speed * pow(REF_HEIGHT / zspeed, exponent);
  est_speed = _max(est_speed, MIN_SPEED);
  return (est_speed);
}

/* ============================================================================
 *  Purpose: estimate the stability class
 *
 *  Reference: EPA-454/5-99-005, 2000, section 6.2.5
 */
int _stab_srdt(int daytime, double speed, double solar, double dT) {
  List<List<int>> lsrdt = [
    [1, 1, 2, 4, 0, 5, 6, 0],
    [1, 2, 3, 4, 0, 5, 6, 0],
    [2, 2, 3, 4, 0, 4, 4, 0],
    [3, 3, 4, 4, 0, 0, 0, 0],
    [3, 4, 4, 4, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0]
  ];

  int i, j;

  if (daytime == 1) {
    if (solar >= 925.0) {
      j = 0;
    } else if (solar >= 675.0) {
      j = 1;
    } else if (solar >= 175.0) {
      j = 2;
    } else {
      j = 3;
    }

    if (speed >= 6.0) {
      i = 4;
    } else if (speed >= 5.0) {
      i = 3;
    } else if (speed >= 3.0) {
      i = 2;
    } else if (speed >= 2.0) {
      i = 1;
    } else {
      i = 0;
    }
  } else {
    if (dT >= 0.0) {
      j = 6;
    } else {
      j = 5;
    }

    if (speed >= 2.5) {
      i = 2;
    } else if (speed >= 2.0) {
      i = 1;
    } else {
      i = 0;
    }
  }
  return (lsrdt[i][j]);
}
