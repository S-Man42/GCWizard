/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

typedef ErrorSet = int;

class ErrorCodes {
  /** Indicates successful execution. */
  static const SUCCESS = 0x0;
  /** Indicates that an azimuth value was out of range (e.g.; desired course from pole other than \f$\pm\pi\f$). */
  static const INVALID_CRS_ERR = 0x1;     /*  = 1*1     = 1     = 0000 0000 0000 0000 0001 */
  /** Indicates a latitude not in the range \f$[-\pi/2;\pi/2]\f$ */
  static const INVALID_LAT_ERR = 0x2;     /*  = 2*1     = 2     = 0000 0000 0000 0000 0010 */
  /** Indicates a longitude not in the range \f$[-\pi;\pi]\f$ */
  static const INVALID_LON_ERR = 0x4;     /*  = 4*1     = 4     = 0000 0000 0000 0000 0100 */
  /** Indicates that the inverse function did not converge to a solution MAX_ITERATION_COUNT iterations */
  static const INV_NOT_CONVERGED_ERR = 0x8;     /*  = 8*1     = 8     = 0000 0000 0000 0000 1000 */
  /** Indicates that root could not be found to linear approximation of the error function */
  static const NO_ROOT_ERR = 0x10;    /*  = 1*16    = 16    = 0000 0000 0000 0001 0000 */
  /** Indicates that memory could not be allocated.*/
  static const MALLOC_ERR = 0x20;    /*  = 2*16    = 32    = 0000 0000 0000 0010 0000 */
  /** Indicates that two geodesics lie on top of each other and do not have discrete intersections.  Used as a status code. */
  static const COLLINEAR_COURSE_ERR = 0x40;    /*  = 4*16    = 64    = 0000 0000 0000 0100 0000 */ //This will be a status indicator in future versions.
  /** Indicates that two arcs or circles either do not intersect or are identical. Used as a status code. */
  static const CONCENTRIC_CIRCLE_ERR = 0x80;    /*  = 8*16    = 128   = 0000 0000 0000 1000 0000 */ //This will be a status indicator in future versions.
  /** Status code indicates that no intersection was found in the case that no intersection point gets returned. */
  static const NO_INTERSECTION_ERR = 0x100;   /*  = 1*256   = 256   = 0000 0000 0001 0000 0000 */ //This will be a status indicator in future versions.
  /** Indicates that a NULL pointer was passed for a required reference */
  static const NO_MEMORY_ALLOCATED_ERR = 0x200;   /*  = 2*256   = 512   = 0000 0000 0010 0000 0000 */
  /** Indicates that an intermediate calculation point based on projecting to a geodesic could not be found */
  static const NO_PROJECTED_POINT_ERR = 0x400;   /*  = 4*256   = 1024  = 0000 0000 0100 0000 0000 */
  /** Status code indicates that a point was not on the expected geodesic or locus */
  static const POINT_NOT_ON_LINE_ERR = 0x800;   /*  = 8*256   = 2048  = 0000 0000 1000 0000 0000 */ //This will be a status indicator in future versions.
  /** Status code indicates that no tangent arc could be found. */
  static const NO_TANGENT_ARC_ERR = 0x1000;  /*  = 1*4096  = 4096  = 0000 0001 0000 0000 0000 */ //This will be a status indicator in future versions.
  /** Indicates that no spherical solution was found so iteration could not begin. */
  static const NO_SPHERICAL_SOLUTION_ERR = 0x2000;  /*  = 2*4096  = 8192  = 0000 0010 0000 0000 0000 */
  /** Status code indicates that no geodesic/locus-arc intersection could be found because the geodesic/locus is too far from the arc. */
  static const LINE_TOO_FAR_FROM_ARC_ERR = 0x8000;  /*  = 8*4096  = 32768 = 0000 1000 0000 0000 0000 */ //This will be a status indicator in future versions.
  /** Status code indicates that no arc-arc intersection was found because one arc lies entirely inside the other. */
  static const CIRCLE_INSIDE_CIRCLE_ERR = 0x10000; /*  = 1*65536 = 65536 = 0001 0000 0000 0000 0000 */ //This will be a status indicator in future versions.
  /** Indicates that start/end points used to define an arc are not equidistant from arc center. */
  static const POINT_NOT_ON_ARC_ERR = 0x20000;
  /** Indicates that arc's subtended angle does not meet algorithm requirement. */
  static const SUBTENDED_ANGLE_OUT_OF_RANGE_ERR = 0x40000;
  /** Indicates that the requested tolerance cannot be met due to large requested Vincenty algorithm precision. */
  static const TOL_TOO_SMALL_ERR = 0x80000;
  /** Indicates that two or more passed reference share memory */
  static const DUPLICATE_POINTER_ERR = 0x100000;
  /** Indicates that given radius does not meet algorithm requirement. */
  static const RADIUS_OUT_OF_RANGE_ERR = 0x200000;
  /** Indicates that given azimuth does not meet algorithm requirement. */
  static const AZIMUTH_OUT_OF_RANGE_ERR = 0x400000;
  /** Indicates that the incorrect variable type has been passed. */
  static const INVALID_TYPE_ERR = 0x800000;
  /** Indicates that a shape object has not been defined. */
  static const SHAPE_NOT_DEFINED_ERR = 0x1000000;
  /** Indicates that an invaled shape type has been passed. */
  static const INVALID_SHAPE_ERR = 0x2000000;
  /** Indicates that the direct algorithm failed to converge.  */
  static const FWD_NOT_CONVERGED_ERR = 0x4000000;
  /** Indicates that the secant method failed to converge. */
  static const SEC_NOT_CONVERGED_ERR = 0x8000000;
  /** Indicates that a method has looped more than the allowed iteration count. */
  static const ITERATION_MAX_REACHED_ERR = 0x10000000;
  /** Indicates that an error value has grown larger than allowed. */
  static const ERROR_MAX_REACHED_ERR = 0x20000000;
  /** Indicates that two LLPoints are on opposite sides of the earth ellipsoid. */
  static const ANTIPODAL_POINTS_ERR = 0x40000000;
  /** Indicates that an unknown error has occurred. */
  static const UNEXPECTED_ERR = 0x80000000;
}