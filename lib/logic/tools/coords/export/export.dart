import 'dart:ui';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:flutter_map/flutter_map.dart';



Future<Map<String, dynamic>> exportCoordinates(String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<MapCircle> circles, {bool kmlFormat = false}) async {
  String xml;

  if ((points == null || points.length == 0) && (geodetics == null || geodetics.length == 0) && (circles == null || circles.length == 0))
    return null;

  if (kmlFormat)
    xml = _KmlWriter().asString(name, points, geodetics, convertCircles(circles));
  else
    xml = _GpxWriter().asString(name, points, geodetics, convertCircles(circles));

  try {
    var fileName = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '_' + 'coordinates' + (kmlFormat ? '.kml' : '.gpx');
    return saveStringToFile(xml, fileName,  subDirectory : 'coordinate_export');
  } on Exception {
    return null;
  }
}

List<Polyline> convertCircles(List<MapCircle> circles) {

  List<Polyline> _polylines =  circles.map((_circle) {
    return Polyline(
      points: _circle.shape,
      strokeWidth: 3.0,
      color: _circle.color,
    );
  }).toList();

  return _polylines;
}


/// Convert points into GPX
class _GpxWriter {
  /// Convert points into GPX XML (v1.0) as String
  String asString(String name, List<MapPoint> points, geodetics, circles) => _build(name, points, geodetics, circles).toXmlString(pretty: true, indent: '\t');

  /// Convert Gpx into GPX XML (v1.0) as XmlNode
  XmlNode asXml(String name, List<MapPoint> points, geodetics, circles) => _build(name, points, geodetics, circles);


  XmlNode _build(String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<Polyline> circles) {final builder = XmlBuilder();

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
      //builder.attribute('xmlns:cgeo', 'http://www.cgeo.org/wptext/1/0');


      if (points != null) {
        for (var i=0; i < points.length; i++) {
          if (i==0)
            _writePoint(builder, false, name, 'S' + i.toString(), points[i]);
          _writePoint(builder, true, name, 'S' + i.toString(), points[i]);
        }
      }

      if (circles != null) {
        circles.forEach((circle) {
          _writeCircle(builder, name, circle);
        });
      }

      if (geodetics != null) {
        geodetics.forEach((geodetic) {
          _writeGeodetic(builder, name, geodetic);
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
            _writeAttribute(builder, 'id', '');
            _writeAttribute(builder, 'available', 'True');
            _writeAttribute(builder, 'archived', 'False');

            _writeElement(builder, 'groundspeak:name', cacheName);
            _writeElement(builder, 'groundspeak:placed_by', 'You');
            //_writeElement(builder, 'groundspeak:owner', '');
            _writeElement(builder, 'groundspeak:type', 'User defined cache');
            _writeElement(builder, 'groundspeak:container', 'Unknown');
            //_writeElement(builder, 'groundspeak:difficulty', 0);
            //_writeElement(builder, 'groundspeak:terrain', 0);
            //_writeElement(builder, 'groundspeak:country', '');
            //_writeElement(builder, 'groundspeak:state', '');
            builder.element('groundspeak:short_description', nest: () {
              _writeAttribute(builder, 'html', 'False');
            });
            builder.element('groundspeak:long_description', nest: () {
              //_writeAttribute(builder, 'text', 'Userdefinied Cache');
              _writeAttribute(builder, 'html', 'False');
            });
            _writeElement(builder, 'groundspeak:encoded_hints', '');
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

  void _writeCircle(XmlBuilder builder, String cacheName, Polyline circle) {
    if (circle != null) {
      builder.element('trk', nest: () {
        _writeElement(builder, 'name', 'circle');
        builder.element('gsak:wptExtension', nest: () {
          _writeElement(builder, 'gsak:Parent', cacheName);
        });
        circle.points.forEach((point) {
          builder.element('trkpt', nest: () {
            _writeAttribute(builder, 'lat', point.latitude);
            _writeAttribute(builder, 'lon', point.longitude);
          });
        });
      });
    }
  }

  void _writeGeodetic(XmlBuilder builder, String cacheName, MapGeodetic geodetic) {
    if (geodetic != null) {
      _writeCircle(builder, cacheName, Polyline(points: List.from([geodetic.start, geodetic.end])));
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

  XmlNode _build(String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<Polyline> circles) {
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
/*
        // Highlighted waypoint style
        builder.element('Style', nest: () {
          builder.attribute('id', 'waypoint_h');
          builder.element('IconStyle', nest: () {
           // _writeElement(builder, 'scale', 1.2);
            builder.element('Icon', nest: () {
              _writeElement(builder, 'href', 'https://maps.google.com/mapfiles/kml/pal4/icon61.png');
            });
          });
        });
*/
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
            _writeCircle(builder, 'circle', circle.color, circle);
          });
        }

        if (geodetics != null && geodetics.length > 0) {
          geodetics.forEach((geodetic) {
            _writeGeodetic(builder, 'line', geodetic.color, geodetic);
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

  void _writeCircle(XmlBuilder builder, String name, Color color, Polyline circle) {
    if (circle != null) {
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
            circle.points.map((point) => [point.longitude, point.latitude].join(',') + ' \n'));
        });
      });
    }
  }

  void _writeGeodetic(XmlBuilder builder, String name, Color color, MapGeodetic geodetic) {
    if (geodetic != null) {
      _writeCircle(builder, name, color, Polyline(points: List.from([geodetic.start, geodetic.end])));
    }
  }

  void _writeElement(XmlBuilder builder, String tagName, value) {
    if (value != null) {
      builder.element(tagName, nest: value);
    }
  }
}
