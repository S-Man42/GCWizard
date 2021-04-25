import 'dart:typed_data';
import 'dart:ui';
import 'package:xml/xml.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:archive/archive_io.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_lines.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/mapview_persistence_adapter.dart';
import 'package:gc_wizard/persistence/map_view/model.dart';


Future<MapViewDAO> importCoordinatesFile(String fileName, Uint8List bytes) async {
  switch (path.extension(fileName).toLowerCase()) {
    case '.gpx':
      var xml = String.fromCharCodes(bytes);
      return parseCoordinatesFile(xml);
      break;
    case '.kml':
      var xml = String.fromCharCodes(bytes);
      return parseCoordinatesFile(xml, kmlFormat: true);
      break;
    case '.kmz':
      InputStream input = new InputStream(bytes.buffer.asByteData());
      // Decode the Zip file
      final archive = ZipDecoder().decodeBuffer(input);
      if (archive.files.isNotEmpty) {
        var file = archive.first;
        file.decompress();
        var xml = String.fromCharCodes(file.content);
        return parseCoordinatesFile(xml, kmlFormat: true);
      }
      break;
  };
  return null;
}

MapViewDAO parseCoordinatesFile(String xml, {bool kmlFormat = false}) {
  try {
    var xmlDoc = XmlDocument.parse(xml);
    if (kmlFormat)
      return _KmlReader()._parse(xmlDoc);
    else
      return _GpxReader()._parse(xmlDoc);
  }
  catch (e) {
    return null;
  }
}

/// Convert GPX-XML into points
class _GpxReader {
  MapViewDAO _parse(XmlDocument xmlDocument) {
    var parent = xmlDocument.getElement('gpx');
    if (parent != null) {
      var points = <GCWMapPoint>[];
      var lines = <GCWMapPolyline>[];
      
      parent.findAllElements('wpt').forEach((xmlWpt) {
        var wpt = _readPoint(xmlWpt);
        if (wpt != null)
          points.add(wpt);
      });
      parent.findAllElements('trk').forEach((xmlTrk) {
        xmlTrk.findElements('trkseg').forEach((xmlTrkseg) {
          var line = _readLine(xmlTrkseg);
          if (line?.points != null && line.points.length > 0){
            lines.add(line);
            points.addAll(line.points);
          }
        });
      });

      _restoreCircles(points, lines);
      return _convertToMapViewDAO(points, lines);
    };
    return null;
  }

  GCWMapPoint _readPoint(XmlElement xmlElement) {
    var lat = xmlElement.getAttribute('lat');
    var lon = xmlElement.getAttribute('lon');
    if (lat != null && lon != null) {
      var wpt = GCWMapPoint(point : new LatLng(double.tryParse(lat), double.tryParse(lon)), isEditable: true);
      wpt.markerText = xmlElement.getElement('desc')?.innerText;
      return wpt;
    }
    return null;
  }

  GCWMapPolyline _readLine(XmlElement xmlElement) {
    var line = new GCWMapPolyline(points : <GCWMapPoint>[]);

    xmlElement.findAllElements('trkpt').forEach((trkpt) {
      var lat = trkpt.getAttribute('lat');
      var lon = trkpt.getAttribute('lon');
      if (lat != null && lon != null) {
        line.points.add(GCWMapPoint(point : new LatLng(double.tryParse(lat), double.tryParse(lon)), isEditable: true));
      };
    });
    return line;
  }
}

/// Convert KML-XML into points
class _KmlReader {
  MapViewDAO _parse(XmlDocument xmlDocument) {
    var parent = xmlDocument.getElement('kml');

    if (parent != null) {
      var document = parent.getElement('Document');
      if (document != null) {
        var points = <GCWMapPoint>[];
        var lines = <GCWMapPolyline>[];

        document.findAllElements('Placemark').forEach((xmlPlacemark) {
          var points = _readPoints(xmlPlacemark, parent);
          if (points != null)
            lines.add(points);
        });

        _restorePoints(points, lines);
        _restoreCircles(points, lines);

        return _convertToMapViewDAO(points, lines);
      }
    };
    return null;
  }

  GCWMapPolyline _readPoints(XmlElement xmlElement, XmlElement styleParent) {
    var group = xmlElement.getElement('Point');
    if (group == null)
      group = xmlElement.getElement('LineString');;
    if (group == null)
      return null;
    var coords = group.getElement('coordinates');
    if (coords == null)
      return null;

    var line = GCWMapPolyline(points : <GCWMapPoint>[]);
    var regExp = RegExp(r'([\.0-9]+),([\.0-9]+),?([\.0-9]+)?');

    regExp.allMatches(coords.innerText).forEach((coordinates) {
      var lat = coordinates.group(2);
      var lon = coordinates.group(1);
      if (lat != null && lon != null) {
        // Todo: Format wieder raus
        var wpt = GCWMapPoint(point : new LatLng(double.tryParse(lat), double.tryParse(lon)), coordinateFormat: {'format' : keyCoordsDMS});
        wpt.markerText = xmlElement.getElement('description')?.innerText;

        if (line.points.length == 0)
          wpt = _readPointStyleMap(wpt, xmlElement.getElement('styleUrl')?.innerText, styleParent);

        line.points.add(wpt);
      }
    });

    if (line.points.length == 0)
      return null;

    return line;
  }

  GCWMapPoint _readPointStyleMap(GCWMapPoint point, String styleUrl, XmlElement styleParent) {
    if (styleUrl.startsWith('#'))
      styleUrl = styleUrl.replaceFirst('#', '');

    styleParent.findAllElements('StyleMap').forEach((xmlElement) {
      if (xmlElement.getAttribute('id') == styleUrl) {
        var pair = xmlElement.getElement('Pair');
        if (pair != null) {
          var styleUrl = pair.getElement('styleUrl');
          if (styleUrl != null)
            return _readPointStyle(point, styleUrl.innerText, styleParent);
        }
      }
    });

    return point;
  }

  GCWMapPoint _readPointStyle(GCWMapPoint point, String styleUrl, XmlElement styleParent) {
    if (styleUrl.startsWith('#'))
      styleUrl = styleUrl.replaceFirst('#', '');

    styleParent.findAllElements('Style').forEach((xmlElement) {
      if (xmlElement.getAttribute('id') == styleUrl) {
        var color = xmlElement.findAllElements('color');
        if (color != null && color.length > 0)
          point.color = _ColorCode(color.first.innerText);
      }
    });

    return point;
  }

  _restorePoints(List<GCWMapPoint> points , List<GCWMapPolyline> lines) {
    for (int i = lines.length-1; i >= 0; i--) {
      points.addAll(lines[i].points);
      if (lines[i].points.length == 1) {
        lines.removeAt(i);
      } else {
        lines[i].color = lines[i].points[0].color;
      }
    }
  }

  Color _ColorCode(String color){
    if (color.length == 8)
      color = color.substring(0,2) + color.substring(6,8) + color.substring(4,6) + color.substring(2,4);
    return Color(int.parse(color, radix: 16));
  }
}

_restoreCircles(List<GCWMapPoint> points , List<GCWMapPolyline> lines) {
  for (int i = lines.length-1; i >= 0; i--) {
    if (_isClosedLine(lines[i]) && _completeCircle(lines[i], points)){
      lines[i].points.forEach((point) {
        points.remove(point);
      });
      lines.removeAt(i);
    }
  }
}

bool _isClosedLine(GCWMapPolyline line) {
  return  ((line.points.first.point.latitude - line.points.last.point.latitude) < epsilon) && ((line.points.first.point.longitude - line.points.last.point.longitude) < epsilon);
}

bool _completeCircle(GCWMapPolyline line, List<GCWMapPoint> points) {
  const toller = 2/100;
  if (line.points.length < 36)
    return false;

  var pt1 = line.points[0].point;
  var pt2 = line.points[(line.points.length/2).toInt()].point;
  var pt3 = line.points[(line.points.length/4).toInt()].point;
  var pt4 = line.points[(line.points.length * 3/4).toInt()].point;
  var ells = defaultEllipsoid();

  DistanceBearingData length1 = distanceBearing(pt1, pt2, ells);
  DistanceBearingData length2 = distanceBearing(pt3, pt4, ells);
  double dist = (length1.distance - length2.distance);
  double distToller = length1.distance * toller;
  if (dist.abs() > distToller)
    return false;

  var crossPoint = intersectFourPoints(pt1, pt2, pt3, pt4, ells);
  GCWMapPoint center;
  double minDist = double.maxFinite;

  points.forEach((wpt) {
    var dist = distanceBearing(wpt.point, crossPoint, ells);
    if (dist.distance < minDist && !wpt.hasCircle()) {
      minDist = dist.distance;
      center = wpt;
    }
  });
  if (minDist > distToller)
    return false;

  var radius = length1.distance / 2;
  distToller = distToller / 2;
  line.points.forEach((wpt) {
    dist = distanceBearing(wpt.point, center.point, ells).distance;
    if ((dist - radius).abs() > distToller)
      return false;
  });
  center.circle = new GCWMapCircle(centerPoint: center.point, radius: radius);
  center.circleColorSameAsPointColor = (center.color == line.color);
  return true;
}

MapViewDAO _convertToMapViewDAO(List<GCWMapPoint> points , List<GCWMapPolyline> lines) {
  var daoPoints = <MapPointDAO>[];
  var daoLines = <MapPolylineDAO>[];
  if (points != null) {
    points.forEach((point) {
      daoPoints.add(MapViewPersistenceAdapter.gcwMapPointToMapPointDAO(point));
    });
  }
  if (lines != null) {
    lines.forEach((line) {
      daoLines.add(MapViewPersistenceAdapter.gcwMapPolylineToMapPolylineDAO(line));
    });
  }

  return MapViewDAO(daoPoints, daoLines);
}




