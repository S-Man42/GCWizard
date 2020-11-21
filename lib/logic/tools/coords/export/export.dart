import 'dart:ui';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


Future<Map<String, dynamic>> exportCoordinates(String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<MapCircle> circles, {bool kmlFormat = false}) async {
  String xml;

  if ((points == null || points.length == 0) && (geodetics == null || geodetics.length == 0) && (circles == null || circles.length == 0))
    return null;

  if (kmlFormat)
    xml = _KmlWriter().asString(name, points, geodetics, circles);
  else
    xml = _GpxWriter().asString(name, points, geodetics, circles);

  try {
    var fileName = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '_' + 'coordinates' + (kmlFormat ? '.kml' : '.gpx');
    return saveStringToFile(xml, fileName,  subDirectory : 'coordinate_export');
  } on Exception {
    return null;
  }
}

/// Convert points into GPX
class _GpxWriter {
  /// Convert points into GPX XML (v1.0) as String
  String asString(String name, List<MapPoint> points, geodetics, circles) => _build(name, points, geodetics, circles).toXmlString(pretty: true, indent: '\t');

  /// Convert Gpx into GPX XML (v1.0) as XmlNode
  XmlNode asXml(String name, List<MapPoint> points, geodetics, circles) => _build(name, points, geodetics, circles);


  XmlNode _build(String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<MapCircle> circles) {final builder = XmlBuilder();

    if ((points == null || points.length == 0) && (geodetics == null || geodetics.length == 0)  && (circles == null || circles.length == 0))
      return null;

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('gpx', nest: () {
      builder.attribute('version', '1.0');
      builder.attribute('creator', 'GC Wizard');
      builder.attribute('xsi:schemaLocation', '"http://www.topografix.com/GPX/1/0 http://www.topografix.com/GPX/1/0/gpx.xsd http://www.groundspeak.com/cache/1/0/1 http://www.groundspeak.com/cache/1/0/1/cache.xsd http://www.gsak.net/xmlv1/6 http://www.gsak.net/xmlv1/6/gsak.xsd');
      builder.attribute('xmlns', 'http://www.topografix.com/GPX/1/0');
      builder.attribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
      builder.attribute('xmlns:groundspeak', 'http://www.groundspeak.com/cache/1/0/1');
      builder.attribute('xmlns:gsak', 'http://www.gsak.net/xmlv1/6');


      if (points != null) {
        for (var i=0; i < points.length; i++) {
          if (i==0)
            _writePoint(builder, false, name, 'S' + i.toString(), points[i]);
          _writePoint(builder, true, name, 'S' + i.toString(), points[i]);
        }
      }

      if (circles != null) {
        circles.forEach((circle) {
          _writeLines(builder, name, 'circle', circle.shape);
        });
      }

      if (geodetics != null) {
        geodetics.forEach((geodetic) {
          _writeLines(builder, name, 'line', geodetic.shape);
        });
      }
    });

    return builder.buildDocument();
  }

  void _writePoint(XmlBuilder builder, bool waypoint, String cacheName, String stageName, MapPoint wpt) {
    if (wpt != null) {
      builder.element('wpt', nest: () {
        _writeAttribute(builder, 'lat', wpt.point.latitude);
        _writeAttribute(builder, 'lon', wpt.point.longitude);
        if (!waypoint) {
          _writeElement(builder, 'name', cacheName);
          _writeElement(builder, 'desc', wpt.markerText);
          _writeElement(builder, 'urlname', cacheName);
          _writeElement(builder, 'sym', 'Geocache');
          _writeElement(builder, 'type', 'Geocache|User defined cache');
          builder.element('groundspeak:cache', nest: () {
            _writeElement(builder, 'groundspeak:name', cacheName);
            _writeElement(builder, 'groundspeak:placed_by', 'You');
            _writeElement(builder, 'groundspeak:type', 'User defined cache');
            _writeElement(builder, 'groundspeak:container', 'Unknown');
            builder.element('groundspeak:short_description', nest: () {
              _writeAttribute(builder, 'html', 'False');
            });
          });
        } else {
          _writeElement(builder, 'name', stageName);
          _writeElement(builder, 'cmt', '');
          _writeElement(builder, 'desc', wpt.markerText);
          _writeElement(builder, 'sym', 'Virtual Stage');
          _writeElement(builder, 'type', 'Waypoint|Virtual Stage');
          builder.element('gsak:wptExtension', nest: () {
            _writeElement(builder, 'gsak:Parent', cacheName);
          });
        }
      });
    }
  }

  void _writeLines(XmlBuilder builder, String cacheName, String tagName, List<LatLng> shapes) {
    if (shapes != null) {
      builder.element('trk', nest: () {
        _writeElement(builder, 'name', tagName);

        builder.element('trkseg', nest: () {
          shapes.forEach((point) {
            builder.element('trkpt', nest: () {
              _writeAttribute(builder, 'lat', point.latitude);
              _writeAttribute(builder, 'lon', point.longitude);
            });
          });
        });
      });
    }
  }

  void _writeElement(XmlBuilder builder, String tagName, value) {
    if (value != null) {
      builder.element(tagName, nest: value);
    }
  }

  void _writeAttribute(XmlBuilder builder, String tagName, value) {
    if (value != null) {
      builder.attribute(tagName, value);
    }
  }

}

/// Convert Gpx into KML
class _KmlWriter {
  /// Convert points into KML as String
  String asString(String name, List<MapPoint> points, geodetics, circles) => _build(name, points, geodetics, circles).toXmlString(pretty: true, indent: '\t');

  /// Convert points into KML as XmlNode
  XmlNode asXml(String name, List<MapPoint> points, geodetics, circles) => _build(name, points, geodetics, circles);

  XmlNode _build(String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<MapCircle> circles) {
    final builder = XmlBuilder();

    if ((points == null || points.length == 0) && (geodetics == null || geodetics.length == 0)  && (circles == null || circles.length == 0))
    return null;

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('kml', nest: () {
      builder.attribute('xmlns', 'http://www.opengis.net/kml/2.2');

      builder.element('Document', nest: () {
        _writeElement(builder, 'name', 'GC Wizard');

        // Normal waypoint style
        builder.element('Style', nest: () {
          builder.attribute('id', 'waypoint_n');
          builder.element('IconStyle', nest: () {
            builder.element('Icon', nest: () {
              _writeElement(builder, 'href', 'https://maps.google.com/mapfiles/kml/pal4/icon61.png');
            });
          });
        });

        builder.element('StyleMap', nest: () {
          builder.attribute('id', 'waypoint');
          builder.element('Pair', nest: () {
            _writeElement(builder, 'key', 'normal');
            _writeElement(builder, 'styleUrl', '#waypoint_n');
          });
          builder.element('Pair', nest: () {
            _writeElement(builder, 'key', 'highlight');
            _writeElement(builder, 'styleUrl', '#waypoint_h');
          });
        });

        builder.element('Folder', nest: () {
          _writeElement(builder, 'name', 'Waypoints');
          if (points != null) {
            for (var i=0; i < points.length; i++) {
              if (i==0)
                _writePoint(builder, false, name, 'S' + i.toString(), points[i]);
              _writePoint(builder, true, name, 'S' + i.toString(), points[i]);
            }
          }
        });

        if (circles != null) {
          circles.forEach((circle) {
            _writeLines(builder, 'circle', circle.color, circle.shape);
          });
        }

        if (geodetics != null && geodetics.length > 0) {
          geodetics.forEach((geodetic) {
            _writeLines(builder, 'line', geodetic.color, geodetic.shape);
          });
        }
      });
    });

    return builder.buildDocument();
  }

  void _writePoint(XmlBuilder builder, bool waypoint, String cacheName, String stageName, MapPoint wpt) {
    if (wpt != null) {
      builder.element('Placemark', nest: () {
        if (!waypoint) {
          _writeElement(builder, 'name', cacheName);
        } else {
          _writeElement(builder, 'description', wpt.markerText);
        }
        _writeElement(builder, 'styleUrl', '#waypoint');
        _writeElement(builder, 'altitudeMode', 'absolute');
        builder.element('Point', nest: () {
          _writeElement(builder, 'coordinates', [wpt.point.longitude, wpt.point.latitude].join(','));
        });
      });
    }
  }

  void _writeLines(XmlBuilder builder, String name, Color color, List<LatLng> shapes) {
    if (shapes != null) {
      builder.element('Placemark', nest: () {
        _writeElement(builder, 'name', name);
        _writeElement(builder, 'visibility', 1);

        builder.element('Style', nest: () {
          _writeElement(builder, 'geomColor', color.value.toRadixString(16)); //.substring(2)
        });

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
}
