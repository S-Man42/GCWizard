import 'dart:convert';

import 'package:gc_wizard/persistence/map_view/model.dart';
import 'package:gc_wizard/persistence/utils.dart';
import 'package:prefs/prefs.dart';

void refreshMapViews() {
  var rawMapViews = Prefs.getStringList('mapview_mapviews');
  if (rawMapViews == null || rawMapViews.length == 0)
    return;

  mapViews = rawMapViews
    .where((view) => view.length > 0)
    .map((view) {
      return MapView.fromJson(jsonDecode(view));
    })
    .toList();
}

_saveData() {
  var jsonData = mapViews
    .map((view) => jsonEncode(view.toMap()))
    .toList();

  Prefs.setStringList('mapview_mapviews', jsonData);
}

int insertMapView(MapView view) {
  view.name = view.name ?? '';
  var id = newID(
    mapViews
      .map((view) => view.id)
      .toList()
  );
  view.id = id;
  mapViews.add(view);

  _saveData();

  return id;
}

void updateMapViews() {
  _saveData();
}

void deleteMapView(int viewId) {
  mapViews.removeWhere((group) => group.id == viewId);

  _saveData();
}

void _updateMapView(MapView view) {
  mapViews = mapViews.map((mapView) {
    if (mapView.id == view.id)
      return view;

    return mapView;
  }).toList();
}

void insertMapPoint(MapPoint point, MapView mapView) {
  mapView.points.add(point);

  _updateMapView(mapView);
  _saveData();
}

void updateMapPoint(MapPoint point, MapView mapView) {
  mapView.points = mapView.points.map((mapPoint) {
    if (mapPoint.uuid == point.uuid)
      return point;

    return mapPoint;
  }).toList();

  _updateMapView(mapView);
  _saveData();
}

void deleteMapPoint(String pointUUID, MapView mapView) {
  mapView.points.removeWhere((point) => point.uuid == pointUUID);

  _updateMapView(mapView);
  _saveData();
}

int insertMapPolyline(MapPolyline polyline, MapView mapView) {
  var id = newID(
    mapView.polylines
      .map((view) => view.id)
      .toList()
  );
  polyline.id = id;
  mapView.polylines.add(polyline);

  _updateMapView(mapView);
  _saveData();

  return id;
}

void updateMapPolyline(MapPolyline polyline, MapView mapView) {
  mapView.polylines = mapView.polylines.map((mapPolyline) {
    if (mapPolyline.id == polyline.id)
      return polyline;

    return mapPolyline;
  }).toList();

  _updateMapView(mapView);
  _saveData();
}

void deleteMapPolyline(int polylineId, MapView mapView) {
  mapView.polylines.removeWhere((polyline) => polyline.id == polylineId);

  _updateMapView(mapView);
  _saveData();
}