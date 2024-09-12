import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/persistence/json_provider.dart';
import 'package:gc_wizard/tools/coords/map_view/persistence/mapview_persistence_adapter.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/utils/string_utils.dart';

const String _apiSpecification = '''
{
  "/coords_openmap" : {
    "get": {
      "summary": "Map View",
      "responses": {
        "204": {
          "description": "Tool loaded. No response data."
        }
      },
      "parameters" : [
        {
          "in": "query",
          "name": "content",
          "required": false,
          "description": "gzip compressed json data",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  }
}
''';

class MapView extends GCWWebStatefulWidget {
  MapView({Key? key}) : super(key: key, apiSpecification: _apiSpecification);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  var points = <GCWMapPoint>[];
  var polyGeodetics = <GCWMapPolyline>[];

  @override
  Widget build(BuildContext context) {
    var mapView =  GCWMapView(
      points: points,
      polylines: polyGeodetics,
      isEditable: true,
    );

    if (widget.hasWebParameter()) {
      if (widget.getWebParameter(uriContent) != null && widget.getWebParameter(uriContent)!.isNotEmpty) {
        String? json;
        try {
          json = decompressString(widget.getWebParameter(uriContent)!);
        } catch (e) {
          json = '';
        }

        if (json.isNotEmpty) {
          json = MapViewPersistenceAdapter.replaceJsonMarker(json, true);
          var viewData = restoreJsonMapViewData(json);

          points.clear();
          polyGeodetics.clear();
          points.addAll(viewData.points.map((point) => MapViewPersistenceAdapter.mapPointDAOToGCWMapPoint(point)));
          polyGeodetics.addAll(viewData.polylines.map((polyline) =>
              MapViewPersistenceAdapter.mapPolylineDAOToGCWMapPolyline(polyline, points)));
        }
      }
      widget.webParameter = null;
    }

    return mapView;
  }
}
