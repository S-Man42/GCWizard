import 'package:xml/xml.dart';
import 'package:latlong/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';



Future<Map<String, dynamic>> exportCoordinates(String name, List<MapPoint> points, {bool kmlFormat = false}) async {
  String xml;
  if (kmlFormat)
    xml = _KmlWriter().asString(name, points);
  else
    xml = _GpxWriter().asString(name, points);

  // ToDo nur testweise drin
  var xmlTmp = _KmlWriter().asString(name, points);
  _exportFile(xmlTmp, kmlFormat : !kmlFormat);

  return _exportFile(xml, kmlFormat : kmlFormat);
}

Future<Map<String, dynamic>> _exportFile(String xml, {bool kmlFormat = false}) async {
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
  String asString(String name, List<MapPoint> points) => _build(name, points).toXmlString();

  /// Convert Gpx into GPX XML (v1.0) as XmlNode
  XmlNode asXml(String name, List<MapPoint> points) => _build(name, points);


  XmlNode _build(String name, List<MapPoint> points) {
    final builder = XmlBuilder();

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
            _writeElement(builder, 'groundspeak:owner', '');
            _writeElement(builder, 'groundspeak:type', 'User defined cache');
            _writeElement(builder, 'groundspeak:container', 'Unknown');
            _writeElement(builder, 'groundspeak:difficulty', 0);
            _writeElement(builder, 'groundspeak:terrain', 0);
            _writeElement(builder, 'groundspeak:country', '');
            _writeElement(builder, 'groundspeak:state', '');
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

  void _writeStage(XmlBuilder builder, String parentName, String tagName, String name, MapPoint wpt) {
    if (wpt != null) {
      builder.element(tagName, nest: () {
        _writeAttribute(builder, 'lat', wpt.point.latitude);
        _writeAttribute(builder, 'lon', wpt.point.longitude);

        _writeElement(builder, 'name', tagName);
        _writeElement(builder, 'cmt', '');
        _writeElement(builder, 'desc', wpt.markerText);
        _writeElement(builder, 'sym', 'Virtual Stage');
        _writeElement(builder, 'type', 'Waypoint|Virtual Stage');
        builder.element('gsak:wptExtension', nest: () {
          _writeAttribute(builder, 'gsak:Parent', parentName);
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

  void _writeElementWithTime(
      XmlBuilder builder, String tagName, DateTime value) {
    if (value != null) {
      builder.element(tagName, nest: value.toUtc().toIso8601String());
    }
  }
/*
  void _writeMetadata(XmlBuilder builder, Metadata metadata) {
    builder.element(GpxTagV11.metadata, nest: () {
      _writeElement(builder, GpxTagV11.name, metadata.name);
      _writeElement(builder, GpxTagV11.desc, metadata.desc);

      _writeElement(builder, GpxTagV11.keywords, metadata.keywords);

      if (metadata.author != null) {
        builder.element(GpxTagV11.author, nest: () {
          _writeElement(builder, GpxTagV11.name, metadata.author.name);

          if (metadata.author.email != null) {
            builder.element(GpxTagV11.email, nest: () {
              _writeAttribute(builder, GpxTagV11.id, metadata.author.email.id);
              _writeAttribute(
                  builder, GpxTagV11.domain, metadata.author.email.domain);
            });
          }

          _writeLinks(builder, [metadata.author.link]);
        });
      }

      if (metadata.copyright != null) {
        builder.element(GpxTagV11.copyright, nest: () {
          _writeAttribute(builder, GpxTagV11.author, metadata.copyright.author);

          _writeElement(builder, GpxTagV11.year, metadata.copyright.year);
          _writeElement(builder, GpxTagV11.license, metadata.copyright.license);
        });
      }

      _writeLinks(builder, metadata.links);

      _writeElementWithTime(builder, GpxTagV11.time, metadata.time);

      if (metadata.bounds != null) {
        builder.element(GpxTagV11.bounds, nest: () {
          _writeAttribute(
              builder, GpxTagV11.minLatitude, metadata.bounds.minlat);
          _writeAttribute(
              builder, GpxTagV11.minLongitude, metadata.bounds.minlon);
          _writeAttribute(
              builder, GpxTagV11.maxLatitude, metadata.bounds.maxlat);
          _writeAttribute(
              builder, GpxTagV11.maxLongitude, metadata.bounds.maxlon);
        });
      }

      _writeExtensions(builder, metadata.extensions);
    });
  }

  void _writeRoute(XmlBuilder builder, Rte rte) {
    builder.element(GpxTagV11.route, nest: () {
      _writeElement(builder, GpxTagV11.name, rte.name);
      _writeElement(builder, GpxTagV11.desc, rte.desc);
      _writeElement(builder, GpxTagV11.comment, rte.cmt);
      _writeElement(builder, GpxTagV11.type, rte.type);

      _writeElement(builder, GpxTagV11.src, rte.src);
      _writeElement(builder, GpxTagV11.number, rte.number);

      _writeExtensions(builder, rte.extensions);

      for (final wpt in rte.rtepts) {
        _writePoint(builder, GpxTagV11.routePoint, wpt);
      }

      _writeLinks(builder, rte.links);
    });
  }

  void _writeTrack(XmlBuilder builder, Trk trk) {
    builder.element(GpxTagV11.track, nest: () {
      _writeElement(builder, GpxTagV11.name, trk.name);
      _writeElement(builder, GpxTagV11.desc, trk.desc);
      _writeElement(builder, GpxTagV11.comment, trk.cmt);
      _writeElement(builder, GpxTagV11.type, trk.type);

      _writeElement(builder, GpxTagV11.src, trk.src);
      _writeElement(builder, GpxTagV11.number, trk.number);

      _writeExtensions(builder, trk.extensions);

      for (final trkseg in trk.trksegs) {
        builder.element(GpxTagV11.trackSegment, nest: () {
          for (final wpt in trkseg.trkpts) {
            _writePoint(builder, GpxTagV11.trackPoint, wpt);
          }

          _writeExtensions(builder, trkseg.extensions);
        });
      }

      _writeLinks(builder, trk.links);
    });
  }



  void _writeExtensions(XmlBuilder builder, Map<String, String> value) {
    if (value != null && value.isNotEmpty) {
      builder.element(GpxTagV11.extensions, nest: () {
        value.forEach((k, v) {
          _writeElement(builder, k, v);
        });
      });
    }
  }

  void _writeLinks(XmlBuilder builder, List<Link> value) {
    if (value != null) {
      for (final link in value.where((link) => link != null)) {
        builder.element(GpxTagV11.link, nest: () {
          _writeAttribute(builder, GpxTagV11.href, link.href);

          _writeElement(builder, GpxTagV11.text, link.text);
          _writeElement(builder, GpxTagV11.type, link.type);
        });
      }
    }
  }






  */

}

/// Convert Gpx into KML
class _KmlWriter {
  /// Convert points into KML as String
  String asString(String name, List<MapPoint> points) =>
      _build(name, points).toXmlString();

  /// Convert points into KML as XmlNode
  XmlNode asXml(String name, List<MapPoint> points) => _build(name, points);

  XmlNode _build(String name, List<MapPoint> points) {
    final builder = XmlBuilder();

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(KmlTagV22.kml, nest: () {
      builder.attribute('xmlns', 'http://www.opengis.net/kml/2.2');

      builder.element(KmlTagV22.document, nest: () {

        if (points != null) {
          for (final wpt in points) {
            _writePoint(builder, KmlTagV22.placemark, name, wpt);
          }
        }

        /*
        if (gpx.rtes != null) {
          for (final rte in gpx.rtes) {
            _writeRoute(builder, rte);
          }
        }

        if (gpx.trks != null) {
          for (final trk in gpx.trks) {
            _writeTrack(builder, trk);
          }
        }

         */
      });
    });

    return builder.buildDocument();
  }

  void _writePoint(XmlBuilder builder, String tagName, String name, MapPoint wpt) {
    if (wpt != null) {
      builder.element(tagName, nest: () {
        _writeElement(builder, 'name', name);
        _writeElement(builder, 'desc', wpt.markerText);

        //_writeElementWithTime(builder, DateTime.now());

        //_writeAtomLinks(builder, wpt.links);
/*
        builder.element(KmlTagV22.extendedData, nest: () {
          _writeExtendedElement(builder, GpxTagV11.magVar, wpt.magvar);

          _writeExtendedElement(builder, GpxTagV11.sat, wpt.sat);
          _writeExtendedElement(builder, GpxTagV11.src, wpt.src);

          _writeExtendedElement(builder, GpxTagV11.hDOP, wpt.hdop);
          _writeExtendedElement(builder, GpxTagV11.vDOP, wpt.vdop);
          _writeExtendedElement(builder, GpxTagV11.pDOP, wpt.pdop);

          _writeExtendedElement(
              builder, GpxTagV11.geoidHeight, wpt.geoidheight);
          _writeExtendedElement(
              builder, GpxTagV11.ageOfData, wpt.ageofdgpsdata);
          _writeExtendedElement(builder, GpxTagV11.dGPSId, wpt.dgpsid);

          _writeExtendedElement(builder, GpxTagV11.comment, wpt.cmt);
          _writeExtendedElement(builder, GpxTagV11.type, wpt.type);
        });
*/
        builder.element('Point', nest: () {
          _writeElement(builder, 'coordinates', [wpt.point.longitude, wpt.point.longitude, 0].join(','));
        });
      });
    }
  }

  void _writeElement(XmlBuilder builder, String tagName, value) {
    if (value != null) {
      builder.element(tagName, nest: value);
    }
  }

  void _writeExtendedElement(XmlBuilder builder, String tagName, value) {
    if (value != null) {
      builder.element('Data', nest: () {
        builder.attribute('name', tagName);
        builder.element('value', nest: value);
      });
    }
  }

  void _writeElementWithTime(XmlBuilder builder, DateTime value) {
    if (value != null) {
      builder.element('timestamp', nest: () {
        builder.element('when', nest: value.toUtc().toIso8601String());
      });
    }
  }
/*
  void _writeMetadata(XmlBuilder builder, Metadata metadata) {
    _writeElement(builder, KmlTagV22.name, metadata.name);
    _writeElement(builder, KmlTagV22.desc, metadata.desc);

    if (metadata.author != null) {
      builder.element('atom:author', nest: () {
        _writeElement(builder, 'atom:name', metadata.author.name);
        _writeElement(builder, 'atom:email',
            '${metadata.author.email.id}@${metadata.author.email.domain}');

        _writeElement(builder, 'atom:uri', metadata.author.link.href);
      });
    }

    builder.element(KmlTagV22.extendedData, nest: () {
      _writeExtendedElement(builder, GpxTagV11.keywords, metadata.keywords);

      if (metadata.time != null) {
        _writeExtendedElement(
            builder, GpxTagV11.time, metadata.time.toIso8601String());
      }

      if (metadata.copyright != null) {
        _writeExtendedElement(builder, GpxTagV11.copyright,
            '${metadata.copyright.author}, ${metadata.copyright.year}');
      }
    });
  }

  void _writeRoute(XmlBuilder builder, Rte rte) {
    builder.element(KmlTagV22.placemark, nest: () {
      _writeElement(builder, GpxTagV11.name, rte.name);
      _writeElement(builder, GpxTagV11.desc, rte.desc);
      _writeAtomLinks(builder, rte.links);

      builder.element(KmlTagV22.extendedData, nest: () {
        _writeExtendedElement(builder, GpxTagV11.comment, rte.cmt);
        _writeExtendedElement(builder, GpxTagV11.type, rte.type);

        _writeExtendedElement(builder, GpxTagV11.src, rte.src);
        _writeExtendedElement(builder, GpxTagV11.number, rte.number);
      });

      builder.element(KmlTagV22.track, nest: () {
        _writeElement(builder, KmlTagV22.extrude, 1);
        _writeElement(builder, KmlTagV22.tessellate, 1);
        _writeElement(builder, KmlTagV22.altitudeMode, 'absolute');

        _writeElement(
            builder,
            KmlTagV22.coordinates,
            rte.rtepts
                .map((wpt) => [wpt.lon, wpt.lat, wpt.ele ?? 0].join(','))
                .join('\n'));
      });
    });
  }

  void _writeTrack(XmlBuilder builder, Trk trk) {
    builder.element(KmlTagV22.placemark, nest: () {
      _writeElement(builder, KmlTagV22.name, trk.name);
      _writeElement(builder, KmlTagV22.desc, trk.desc);
      _writeAtomLinks(builder, trk.links);

      builder.element(KmlTagV22.extendedData, nest: () {
        _writeExtendedElement(builder, GpxTagV11.comment, trk.cmt);
        _writeExtendedElement(builder, GpxTagV11.type, trk.type);

        _writeExtendedElement(builder, GpxTagV11.src, trk.src);
        _writeExtendedElement(builder, GpxTagV11.number, trk.number);
      });

      builder.element(KmlTagV22.track, nest: () {
        _writeElement(builder, KmlTagV22.extrude, 1);
        _writeElement(builder, KmlTagV22.tessellate, 1);
        _writeElement(builder, KmlTagV22.altitudeMode, 'absolute');

        _writeElement(
            builder,
            KmlTagV22.coordinates,
            trk.trksegs
                .expand((trkseg) => trkseg.trkpts)
                .map((wpt) => [wpt.lon, wpt.lat, wpt.ele ?? 0].join(','))
                .join('\n'));
      });
    });
  }
*/

}

/// GPX tags names.
class GpxTagV11 {
  static const gpx = 'gpx';
  static const version = 'version';
  static const creator = 'creator';
  static const metadata = 'metadata';
  static const wayPoint = 'wpt';
  static const route = 'rte';
  static const routePoint = 'rtept';
  static const track = 'trk';
  static const trackSegment = 'trkseg';
  static const trackPoint = 'trkpt';
  static const latitude = 'lat';
  static const longitude = 'lon';
  static const elevation = 'ele';
  static const time = 'time';
  static const name = 'name';
  static const desc = 'desc';
  static const comment = 'cmt';
  static const src = 'src';
  static const link = 'link';
  static const sym = 'sym';
  static const number = 'number';
  static const type = 'type';
  static const fix = 'fix';
  static const text = 'text';
  static const author = 'author';
  static const copyright = 'copyright';
  static const keywords = 'keywords';
  static const bounds = 'bounds';
  static const extensions = 'extensions';
  static const minLatitude = 'minlat';
  static const minLongitude = 'minlon';
  static const maxLatitude = 'maxlat';
  static const maxLongitude = 'maxlon';
  static const href = 'href';
  static const year = 'year';
  static const license = 'license';
  static const email = 'email';
  static const id = 'id';
  static const domain = 'domain';

  static const hDOP = 'hdop';
  static const vDOP = 'vdop';
  static const pDOP = 'pdop';

  static const magVar = 'magvar';

  static const sat = 'sat';

  static const geoidHeight = 'geoidheight';
  static const ageOfData = 'ageofdgpsdata';
  static const dGPSId = 'dgpsid';
}

/// KML tags names.
class KmlTagV22 {
  static const kml = 'kml';

  static const document = 'Document';

  static const placemark = 'Placemark';
  static const name = 'name';
  static const desc = 'description';

  static const point = 'Point';
  static const track = 'LineString';
  static const coordinates = 'coordinates';

  static const extendedData = 'ExtendedData';
  static const data = 'Data';

  static const value = 'value';

  static const altitudeMode = 'altitudeMode';
  static const extrude = 'extrude';
  static const tessellate = 'tessellate';

  static const timestamp = 'timestamp';
  static const when = 'when';

// <altitudeMode>absolute</altitudeMode>

}