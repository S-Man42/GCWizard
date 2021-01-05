import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gc_wizard/persistence/map_view/json_provider.dart';
import 'package:gc_wizard/persistence/map_view/model.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';
import 'package:latlong/latlong.dart';

class MapViewPersistenceAdapter {
  final GCWMapView mapWidget;
  MapViewDAO _mapViewDAO;

  MapViewPersistenceAdapter(this.mapWidget) {
    _initializeMapView();
  }
  
  MapPointDAO _gcwMapPointToMapPointDAO(GCWMapPoint gcwMapPoint) {
    return MapPointDAO(
      gcwMapPoint.uuid,
      gcwMapPoint.point.latitude,
      gcwMapPoint.point.longitude,
      gcwMapPoint.coordinateFormat['format'],
      colorToHexString(gcwMapPoint.color),
      gcwMapPoint.hasCircle() ? gcwMapPoint.circle.radius : null,
      gcwMapPoint.circleColorSameAsPointColor,
      gcwMapPoint.hasCircle() ? colorToHexString(gcwMapPoint.circle.color) : null,
    );
  }
  
  GCWMapPoint _mapPointDAOToGCWMapPoint(MapPointDAO mapPointDAO) {
    return GCWMapPoint(
      uuid: mapPointDAO.uuid,
      point: LatLng(mapPointDAO.latitude, mapPointDAO.longitude),
      coordinateFormat: {'format': mapPointDAO.coordinateFormat},
      color: hexStringToColor(mapPointDAO.color),
      circle: mapPointDAO.radius != null ? GCWMapCircle(
        radius: mapPointDAO.radius,
        color: hexStringToColor(mapPointDAO.circleColor)
      ) : null,
      circleColorSameAsPointColor: mapPointDAO.circleColorSameAsColor,
      isEditable: true
    );
  }
  
  MapPolylineDAO _gcwMapPolylineToMapPolylineDAO(GCWMapPolyline gcwMapPolyline) {
    return MapPolylineDAO(
      gcwMapPolyline.uuid,
      gcwMapPolyline.points.map((point) => point.uuid).toList(),
      colorToHexString(gcwMapPolyline.color)
    );
  }
  
  GCWMapPolyline _mapPolylineDAOToGCWMapPolyline(MapPolylineDAO mapPolylineDAO) {
    return GCWMapPolyline(
      uuid: mapPolylineDAO.uuid,
      points: mapPolylineDAO.pointUUIDs
        .map((uuid) => mapWidget.points.firstWhere((point) => point.uuid == uuid))
        .toList(),
      color: hexStringToColor(mapPolylineDAO.color)
    );
  }
  
  _initializeMapView() {
    refreshMapViews();
  
    if (mapViews.length == 0) {
      insertMapViewDAO(MapViewDAO([], []));
    }
    _mapViewDAO = mapViews.last;
  
    if (mapWidget.points != null) {
      _mapViewDAO.points.addAll(
        mapWidget.points
          .where((point) => !_mapViewDAO.points.map((pointDAO) => pointDAO.uuid).toList().contains(point.uuid))
          .map((point) => _gcwMapPointToMapPointDAO(point))
          .toList()
      );
  
      mapWidget.points.addAll(
        _mapViewDAO.points
          .where((pointDAO) => !mapWidget.points.map((point) => point.uuid).toList().contains(pointDAO.uuid))
          .map((pointDAO) => _mapPointDAOToGCWMapPoint(pointDAO))
          .toList()
      );
    }
  
    if (mapWidget.polylines != null) {
      _mapViewDAO.polylines.addAll(
        mapWidget.polylines
          .where((polyline) => !_mapViewDAO.polylines.map((polylineDAO) => polylineDAO.uuid).toList().contains(polyline.uuid))
          .map((polyline) => _gcwMapPolylineToMapPolylineDAO(polyline))
          .toList()
      );
  
      mapWidget.polylines.addAll(
        _mapViewDAO.polylines
          .where((polylineDAO) => !mapWidget.polylines.map((polyline) => polyline.uuid).toList().contains(polylineDAO.uuid))
          .map((polylineDAO) => _mapPolylineDAOToGCWMapPolyline(polylineDAO))
          .toList()
      );
    }
  }
  
  GCWMapPoint addMapPoint(LatLng coordinate) {
    var random = Random();
    var mapPoint = GCWMapPoint(
      point: coordinate,
      coordinateFormat: defaultCoordFormat(),
      isEditable: true,
      color: HSVColor.fromAHSV(1.0, random.nextDouble() * 360.0, 1.0, random.nextDouble() / 2 + 0.5).toColor(),
      circleColorSameAsPointColor: true
    );
  
    insertMapPointDAO(_gcwMapPointToMapPointDAO(mapPoint), _mapViewDAO);
  
    mapWidget.points.add(mapPoint);
    return mapPoint;
  }
  
  MapPointDAO _mapPointDAOByUUID(String uuid) {
    return _mapViewDAO.points.firstWhere((point) => point.uuid == uuid);
  }
  
  MapPolylineDAO _mapPolylineDAOByUUID(String uuid) {
    return _mapViewDAO.polylines.firstWhere((polyline) => polyline.uuid == uuid);
  }
  
  updateMapPoint(GCWMapPoint mapPoint) {
    mapPoint.update();
  
    var mapPointDAO = _mapPointDAOByUUID(mapPoint.uuid);
  
    mapPointDAO.latitude = mapPoint.point.latitude;
    mapPointDAO.longitude = mapPoint.point.longitude;
    mapPointDAO.coordinateFormat = mapPoint.coordinateFormat['format'];
    mapPointDAO.color = colorToHexString(mapPoint.color);
    mapPointDAO.radius = mapPoint.hasCircle() ? mapPoint.circle.radius : null;
    mapPointDAO.circleColorSameAsColor = mapPoint.circleColorSameAsPointColor;
    mapPointDAO.circleColor = mapPoint.hasCircle() ? colorToHexString(mapPoint.circle.color) : null;
  
    updateMapPointDAO(mapPointDAO, _mapViewDAO);

    mapWidget.polylines
      .where((polyline) => polyline.points.contains(mapPoint))
      .forEach((polyline) => updateMapPolyline(polyline));
  }
  
  updateMapPolyline(GCWMapPolyline polyline) {
    polyline.update();
  
    var mapPolylineDAO = _mapPolylineDAOByUUID(polyline.uuid);
    mapPolylineDAO.pointUUIDs = polyline.points.map((point) => point.uuid).toList();
    mapPolylineDAO.color = colorToHexString(polyline.color);
  
    updateMapPolylineDAO(mapPolylineDAO, _mapViewDAO);
  }
  
  removeMapPointFromMapPolyline(GCWMapPoint mapPoint) {
    var removablePolylines = [];
    mapWidget.polylines.forEach((polyline) {
      print(polyline.uuid);
      print(polyline.points.map((e) => e.uuid).toList());
      var polylineDAO = _mapPolylineDAOByUUID(polyline.uuid);
  
      if (polyline.points.indexOf(mapPoint) > -1) {
        print(polyline.points.remove(mapPoint));
        print(polylineDAO.pointUUIDs.remove(mapPoint.uuid));
      }
  
      if (polyline.points.length < 2) {
        removablePolylines.add(polyline);
      } else {
        polyline.update();
        updateMapPolylineDAO(polylineDAO, _mapViewDAO);
      }
    });
  
    removablePolylines.forEach((polyline) {
      removeMapPolyline(polyline);
    });
  }
  
  removeMapPoint(GCWMapPoint mapPoint) {
    removeMapPointFromMapPolyline(mapPoint);
  
    mapWidget.points.remove(mapPoint);
    deleteMapPointDAO(mapPoint.uuid, _mapViewDAO);
  }
  
  removeMapPolyline(GCWMapPolyline polyline, {removePoints: false}) {
    mapWidget.polylines.remove(polyline);
    deleteMapPolylineDAO(polyline.uuid, _mapViewDAO);
  
    if (removePoints) {
      polyline.points.forEach((point) {
        for (GCWMapPolyline anotherPolyline in mapWidget.polylines) {
          if (anotherPolyline.uuid == polyline.uuid)
            continue;
  
          if (anotherPolyline.points.contains(point))
            return;
        }
  
        removeMapPoint(point);
      });
    }
  }
  
  void clearMapView() {
    mapWidget.points.clear();
    mapWidget.polylines.clear();
    clearMapViewDAO(_mapViewDAO);
  }
  
  GCWMapPolyline createMapPolyline() {
    var polyline = GCWMapPolyline(points: []);
    mapWidget.polylines.add(polyline);
    insertMapPolylineDAO(_gcwMapPolylineToMapPolylineDAO(polyline), _mapViewDAO);
  
    return polyline;
  }
  
  addMapPointIntoPolyline(GCWMapPoint mapPoint, GCWMapPolyline polyline) {
    polyline.points.add(mapPoint);
    polyline.update();
  
    var polylineDAO = _mapPolylineDAOByUUID(polyline.uuid);
    polylineDAO.pointUUIDs.add(mapPoint.uuid);
    updateMapPolylineDAO(polylineDAO, _mapViewDAO);
  }
}