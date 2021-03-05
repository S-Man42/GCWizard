import 'dart:ui';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'package:universal_html/html.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:latlong/latlong.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_lines.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

Future<Map<String, dynamic>> importCoordinates(String xml, {bool kmlFormat = false}) async {
  // String xml;

  // if ((points == null || points.length == 0) && (polylines == null || polylines.length == 0))
  //   return null;
  //
  // if (kmlFormat)
  //   xml = _KmlWriter().asString(name, points, polylines);
  // else
  //   xml = _GpxWriter().asString(name, points, polylines);
  //
  // try {
  //   var fileName = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '_' + 'coordinates' + (kmlFormat ? '.kml' : '.gpx');
  //   return saveStringToFile(xml, fileName,  subDirectory : 'coordinate_export');
  // } on Exception {
  //   return null;
  // }

  // , List<GCWMapPoint> points, List<GCWMapPolyline> polylines,
  var xmlDoc = XmlDocument.parse(xml);
}

/// Convert points into GPX
class _GpxReader {
  Map<String, dynamic> _parse(XmlDocument xmlDocument) {
    if (xmlDocument.parentElement.name != 'gpx') {
      var elements = new Map<String, dynamic>();
      var points = new List<GCWMapPoint>();
      var lines = new List<GCWMapPolyline>();

      xmlDocument.parentElement.findElements('wpt').forEach((xmlWpt) {
        var wpt = _readPoint(xmlWpt);
        if (wpt.circle != null)
          points.add(wpt);
      });
      xmlDocument.parentElement.findElements('trk').forEach((xmlTrk) {
        xmlTrk.findElements('trkseg').forEach((xmlTrkseg) {
          var line = _readLine(xmlTrkseg);
          if (line != null && line.length > 0)
            lines.add(line);
        });
      });
      if (points != null && points.length > 0)
        elements.addAll({'points' : points});
      if (lines != null && lines.length > 0)
        elements.addAll({'lines' : lines});

      if (elements.length > 0)
        return elements;
    };
  return null;
    // if ((points == null || points.length == 0) && (polylines == null || polylines.length == 0))
    //   return null;
    //
    // builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    // builder.element('gpx', nest: () {
    //   builder.attribute('version', '1.0');
    //   builder.attribute('creator', 'GC Wizard');
    //   builder.attribute('xsi:schemaLocation', '"http://www.topografix.com/GPX/1/0 http://www.topografix.com/GPX/1/0/gpx.xsd http://www.groundspeak.com/cache/1/0/1 http://www.groundspeak.com/cache/1/0/1/cache.xsd http://www.gsak.net/xmlv1/6 http://www.gsak.net/xmlv1/6/gsak.xsd');
    //   builder.attribute('xmlns', 'http://www.topografix.com/GPX/1/0');
    //   builder.attribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
    //   builder.attribute('xmlns:groundspeak', 'http://www.groundspeak.com/cache/1/0/1');
    //   builder.attribute('xmlns:gsak', 'http://www.gsak.net/xmlv1/6');
    //
    //   if (points != null) {
    //     for (var i=0; i < points.length; i++) {
    //       if (i==0)
    //         _writePoint(builder, false, name, 'S' + i.toString(), points[i]);
    //       _writePoint(builder, true, name, 'S' + i.toString(), points[i]);
    //     }
    //   }
    //
    //   var circles = points
    //     .where((point) => point.hasCircle())
    //     .map((point) => point.circle)
    //     .toList();
    //
    //   if (circles != null) {
    //     circles.forEach((circle) {
    //       _writeLines(builder, name, 'circle', circle.shape);
    //     });
    //   }
    //
    //   if (polylines != null) {
    //     polylines.forEach((geodetic) {
    //       _writeLines(builder, name, 'line', geodetic.shape);
    //     });
    //   }
    // });
    //
    // return builder.buildDocument();
  }

  GCWMapPoint _readPoint(XmlElement xmlElement) {
    var lat = xmlElement.getElement('lat');
    var lon = xmlElement.getElement('lon');
    if (lat != null && lon != null) {
      var wpt = GCWMapPoint();
      wpt.point= new LatLng(double.tryParse(lat.innerText), double.tryParse(lon.innerText));
      wpt.markerText = xmlElement.getElement('desc').innerText;
      return wpt;
    }
    return null;
  }

  GCWMapPolyline _readLine(XmlElement xmlElement) {
    if (xmlElement.name != "trkseg")
      return null;
    var line = new GCWMapPolyline();

    xmlElement.findElements('trkpt').forEach((trkpt) {

      var lat = trkpt.attributes.firstWhere((attr) => attr.name == 'lat');
      var lon = trkpt.attributes.firstWhere((attr) => attr.name == 'lon');
      if (lat != null && lon != null) {
        var latLng = new LatLng(double.tryParse(lat.value), double.tryParse(lon.value));
        line.shape.add(latLng);
      };
    });
    return line;
  }
}

bool isClosedLine(GCWMapPolyline line) {
  return  ((line.shape.first.latitude - line.shape.last.latitude) < epsilon) && ((line.shape.first.longitude - line.shape.last.longitude) < epsilon);
}

bool completeCircle(GCWMapPolyline line, List<GCWMapPoint> points) {
  const toller = 2/100;
  if (points.length < 4)
    return false;

  var pt1 = points[0].point;
  var pt2 = points[(points.length/2).toInt()].point;
  var pt3 = points[(points.length/4).toInt()].point;
  var pt4 = points[(points.length * 3/4).toInt()].point;
  var ells = defaultEllipsoid();
  DistanceBearingData length1 = distanceBearing(pt1, pt2, ells);
  DistanceBearingData length2 = distanceBearing(pt3, pt4, ells);
  double dist = (length1.distance - length2.distance);
  if (dist.abs() > length1.distance * toller)
   return false;

  var crossPoint = intersectFourPoints(pt1, pt2, pt3, pt4, ells);
  GCWMapPoint center ;
  double minDist = double.maxFinite;

  points.forEach((wpt) {
    var dist = distanceBearing(wpt.point, crossPoint, ells);
    if (dist.distance < minDist && !wpt.hasCircle()) {
      minDist = dist.distance;
      center = wpt;
    }

  });

}

/// Convert Gpx into KML
class _KmlWriter {
  /// Convert points into KML as String
  String asString(String name, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) => _build(name, points, polylines).toXmlString(pretty: true, indent: '\t');

  /// Convert points into KML as XmlNode
  XmlNode asXml(String name, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) => _build(name, points, polylines);

  XmlNode _build(String name, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) {
    final builder = XmlBuilder();
    var i = 0;

    if ((points == null || points.length == 0) && (polylines == null || polylines.length == 0))
      return null;

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('kml', nest: () {
      builder.attribute('xmlns', 'http://www.opengis.net/kml/2.2');

      builder.element('Document', nest: () {
        _writeElement(builder, 'name', 'GC Wizard');

        if (points != null) {
          for (i=0; i < points.length; i++) {
            builder.element('StyleMap', nest: () {
              builder.attribute('id', 'waypoint' + i.toString());

              builder.element('Pair', nest: () {
                _writeElement(builder, 'key', 'normal');
                _writeElement(builder, 'styleUrl', '#waypoint' + i.toString());
              });
            });
          }
          for (i=0; i < points.length; i++) {
            builder.element('Style', nest: () {
              builder.attribute('id', 'waypoint' + i.toString());
              _writeElement(builder, 'color', _ColorCode(points[i].color));
              builder.element('IconStyle', nest: () {
                builder.element('Icon', nest: () {
                  _writeElement(builder, 'href', 'https://maps.google.com/mapfiles/kml/pal4/icon61.png');
                });
              });
            });
          }
        }

        var circles = points
          .where((point) => point.hasCircle())
          .map((point) => point.circle)
          .toList();

        if (circles != null) {
          for (i=0; i < circles.length; i++) {
            builder.element('StyleMap', nest: () {
              builder.attribute('id', 'circle' + i.toString());

              builder.element('Pair', nest: () {
                _writeElement(builder, 'key', 'normal');
                _writeElement(builder, 'styleUrl', '#circle' + i.toString());
              });
            });
          }
          for (i=0; i < circles.length; i++) {
            builder.element('Style', nest: () {
              builder.attribute('id', 'circle' + i.toString());
              builder.element('LineStyle', nest: () {
                _writeElement(builder, 'color', _ColorCode(circles[i].color));
                _writeElement(builder, 'width', 3);
              });
              _writeElement(builder, 'color', _ColorCode(circles[i].color));
            });
          }
        }

        if (polylines != null) {
          for (i=0; i < polylines.length; i++) {
            builder.element('StyleMap', nest: () {
              builder.attribute('id', 'polyline' + i.toString());

              builder.element('Pair', nest: () {
                _writeElement(builder, 'key', 'normal');
                _writeElement(builder, 'styleUrl', '#polyline' + i.toString());
              });
            });
          }
          for (i=0; i < polylines.length; i++) {
            builder.element('Style', nest: () {
              builder.attribute('id', 'polyline' + i.toString());
              builder.element('LineStyle', nest: () {
                _writeElement(builder, 'color', _ColorCode(polylines[i].color));
                _writeElement(builder, 'width', 3);
              });
              _writeElement(builder, 'color', _ColorCode(polylines[i].color));
            });
          }
        }

        builder.element('Folder', nest: () {
          _writeElement(builder, 'name', 'Waypoints');
          if (points != null) {
            for (i=0; i < points.length; i++) {
              if (i==0)
                _writePoint(builder, false, name, 'S' + i.toString(), points[i], '#waypoint' + i.toString());
              _writePoint(builder, true, name, 'S' + i.toString(), points[i], '#waypoint' + i.toString());
            }
          }
        });

        if (circles != null) {
          for (i=0; i < circles.length; i++) {
            _writeLines(builder, 'circle', circles[i].shape, '#circle' + i.toString());
          }
        }

        if (polylines != null && polylines.length > 0) {
          for (i=0; i < polylines.length; i++) {
            _writeLines(builder, 'line', polylines[i].shape, '#polyline' + i.toString());
          }
        }
      });
    });

    return builder.buildDocument();
  }

  void _writePoint(XmlBuilder builder, bool waypoint, String cacheName, String stageName, GCWMapPoint wpt, String styleId) {
    if (wpt != null) {
      builder.element('Placemark', nest: () {
        if (!waypoint) {
          _writeElement(builder, 'name', cacheName);
        } else {
          _writeElement(builder, 'description', wpt.markerText);
        }
        _writeElement(builder, 'styleUrl', '#waypoint');
        _writeElement(builder, 'altitudeMode', 'absolute');
        _writeElement(builder, 'styleUrl', styleId);
        builder.element('Point', nest: () {
          _writeElement(builder, 'coordinates', [wpt.point.longitude, wpt.point.latitude].join(','));
        });
      });
    }
  }

  void _writeLines(XmlBuilder builder, String name, List<LatLng> shapes, String styleId) {
    if (shapes != null) {
      builder.element('Placemark', nest: () {
        _writeElement(builder, 'name', name);
        _writeElement(builder, 'visibility', 1);
        _writeElement(builder, 'styleUrl', styleId);

        builder.element('LineString', nest: () {
          _writeElement(builder, 'tesselerate', 1);
          _writeElement(builder, 'altitudeMode', 'absolute');
          _writeElement(builder, 'coordinates',
            shapes.map((point) => [point.longitude, point.latitude].join(',') + ' \n'));
        });
      });
    }
  }

  void _writeElement(XmlBuilder builder, String tagName, value) {
    if (value != null) {
      builder.element(tagName, nest: value);
    }
  }

  String _ColorCode(Color color){
    var s = color.value.toRadixString(16);
    return s.substring(0,2) + s.substring(6,8) + s.substring(4,6) + s.substring(2,4) ;
  }
}
