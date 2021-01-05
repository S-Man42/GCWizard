import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/coords/antipodes.dart';
import 'package:gc_wizard/widgets/tools/coords/center_three_points.dart';
import 'package:gc_wizard/widgets/tools/coords/center_two_points.dart';
import 'package:gc_wizard/widgets/tools/coords/cross_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/ellipsoid_transform.dart';
import 'package:gc_wizard/widgets/tools/coords/equilateral_triangle.dart';
import 'package:gc_wizard/widgets/tools/coords/format_converter.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearing_and_circle.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearings.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_four_points.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_three_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_two_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersection.dart';
import 'package:gc_wizard/widgets/tools/coords/resection.dart';
import 'package:gc_wizard/widgets/tools/coords/variable_coordinate/variable_coordinate_formulas.dart';
import 'package:gc_wizard/widgets/tools/coords/waypoint_projection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CoordsSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWTool> _toolList =
      Registry.toolList.where((element) {
        return [
          className(WaypointProjection()),
          className(DistanceBearing()),
          className(FormatConverter()),
          className(VariableCoordinateFormulas()),
          className(CenterTwoPoints()),
          className(CenterThreePoints()),
          className(Antipodes()),
          className(CrossBearing()),
          className(IntersectBearings()),
          className(IntersectFourPoints()),
          className(IntersectGeodeticAndCircle()),
          className(IntersectTwoCircles()),
          className(IntersectThreeCircles()),
          className(Intersection()),
          className(Resection()),
          className(EquilateralTriangle()),
          className(EllipsoidTransform()),
        ].contains(className(element.tool));
      }).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}