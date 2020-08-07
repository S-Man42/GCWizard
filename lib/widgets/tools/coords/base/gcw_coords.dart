import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dec.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_deg.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dms.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_formatselector.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_gausskrueger.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_geohash.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_maidenhead.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_mercator.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_mgrs.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_openlocationcode.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_quadtree.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_reversewhereigo_waldmeister.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_slippymap.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_swissgrid.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_utm.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

class GCWCoords extends StatefulWidget {
  final Function onChanged;
  final Map<String, String> coordsFormat;
  final String text;

  const GCWCoords({Key key, this.text, this.onChanged, this.coordsFormat}) : super(key: key);

  @override
  GCWCoordsState createState() => GCWCoordsState();
}

class GCWCoordsState extends State<GCWCoords> {

  Map<String, String> _currentCoordsFormat;
  LatLng _currentValue;

  LatLng _pastedCoords;

  var _currentWidget;

  @override
  void initState() {
    super.initState();

    _currentCoordsFormat = widget.coordsFormat ?? defaultCoordFormat();
    _currentValue = defaultCoordinate;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _coordsWidgets = [
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsDEC),
        'widget': GCWCoordsDEC(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsDEG),
        'widget': GCWCoordsDEG(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsDMS),
        'widget': GCWCoordsDMS(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
       'coordFormat': getCoordinateFormatByKey(keyCoordsUTM),
       'widget': GCWCoordsUTM(
         onChanged: (newValue) {
           setState(() {
             _setCurrentValueAndEmitOnChange(newValue);
           });
         },
       ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsMGRS),
        'widget': GCWCoordsMGRS(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsSwissGrid),
        'widget': GCWCoordsSwissGrid(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsSwissGridPlus),
        'widget': GCWCoordsSwissGrid(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsGaussKrueger),
        'widget': GCWCoordsGaussKrueger(
          subtype: _currentCoordsFormat['subtype'],
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsMaidenhead),
        'widget': GCWCoordsMaidenhead(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsMercator),
        'widget': GCWCoordsMercator(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsSlippyMap),
        'widget': GCWCoordsSlippyMap(
          zoom: _currentCoordsFormat['subtype'],
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsGeohash),
        'widget': GCWCoordsGeohash(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsOpenLocationCode),
        'widget': GCWCoordsOpenLocationCode(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsQuadtree),
        'widget': GCWCoordsQuadtree(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsReverseWhereIGoWaldmeister),
        'widget': GCWCoordsReverseWhereIGoWaldmeister(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
    ];

    _pastedCoords = null;

    Column _widget = Column(
      children: <Widget>[
        GCWTextDivider(
          text: widget.text,
          bottom: 0.0,
          trailing: GCWPasteButton(
            onSelected: _parseClipboardAndSetCoords
          ),
        ),
        GCWCoordsFormatSelector(
          format: _currentCoordsFormat,
          onChanged: (newValue){
            setState(() {
              if (_currentCoordsFormat != newValue) {
                _currentCoordsFormat = newValue;
                _currentValue = defaultCoordinate;

                _setCurrentValueAndEmitOnChange();
              }
              FocusScope.of(context).requestFocus(new FocusNode()); //Release focus from previous edited field
            });
          },
        ),
      ],
    );

    _currentWidget = _coordsWidgets
      .firstWhere((entry) => entry['coordFormat'].key == _currentCoordsFormat['format'])['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange([LatLng newValue]) {
    widget.onChanged({
      'coordsFormat': _currentCoordsFormat,
      'value': newValue ?? _currentValue
    });
  }

  _parseClipboardAndSetCoords(text) {
    var parsed = parseLatLon(text);
    if (parsed == null) {
      showToast(i18n(context, 'coords_common_clipboard_nocoordsfound'));
      return;
    }

    _pastedCoords = parsed['coordinate'];
    if (_pastedCoords == null)
      return;

    switch(_currentCoordsFormat['format']) {
      case keyCoordsDEC:
      case keyCoordsDEG:
      case keyCoordsDMS:
        break;
      default:
        _currentCoordsFormat = {'format': keyCoordsDEG};
    }

    _currentValue = _pastedCoords;
    _setCurrentValueAndEmitOnChange();
  }
}