/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

const M_PI = pi;
const M_2PI = pi * 2;
const M_PI_2 = pi / 2;

/*
 *   \brief Tolerance
 *   \returns double tolerance of 1.0e-9
 *   \note Order 8260.54A Appendix 2, 3.3 Tolerances, states
 *   "Empirical studies have shown that eps = 0.5e-13 and
 *   tol = 1.0-e9 work well."
 *
 */
const TOL = 1.0e-9;

const SPHERE_RADIUS_NMI = 3438.140221487929;

const NMI_IN_METERS = 1852.0;