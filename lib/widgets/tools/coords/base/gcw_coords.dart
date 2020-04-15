import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dec.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_deg.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dms.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_gausskrueger.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_geohash.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_maidenhead.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_mercator.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_mgrs.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_swissgrid.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_utm.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

class GCWCoords extends StatefulWidget {
  final Function onChanged;
  final String coordsFormat;
  final String text;

  const GCWCoords({Key key, this.text, this.onChanged, this.coordsFormat}) : super(key: key);

  @override
  GCWCoordsState createState() => GCWCoordsState();
}

class GCWCoordsState extends State<GCWCoords> {

  String _currentCoordsFormat = defaultCoordFormat();
  Map<String, LatLng> _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = Map.fromIterable(allCoordFormats, key: (format) => format.key, value: (format) => defaultCoordinate);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _coordsWidgets = [
      {
        'coordFormat': getCoordFormatByKey(keyCoordsDEC),
        'widget': GCWCoordsDEC(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsDEC] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsDEG),
        'widget': GCWCoordsDEG(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsDEG] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsDMS),
        'widget': GCWCoordsDMS(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsDMS] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
       'coordFormat': getCoordFormatByKey(keyCoordsUTM),
       'widget': GCWCoordsUTM(
         onChanged: (newValue) {
           setState(() {
             _currentValue[keyCoordsUTM] = newValue;
             _setCurrentValueAndEmitOnChange();
           });
         },
       ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsMGRS),
        'widget': GCWCoordsMGRS(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsMGRS] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsSwissGrid),
        'widget': GCWCoordsSwissGrid(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsSwissGrid] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsSwissGridPlus),
        'widget': GCWCoordsSwissGrid(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsSwissGridPlus] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsGaussKrueger1, context: context),
        'widget': GCWCoordsGaussKrueger(
          gaussKruegerCode: 1,
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsGaussKrueger1] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsGaussKrueger2, context: context),
        'widget': GCWCoordsGaussKrueger(
          gaussKruegerCode: 2,
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsGaussKrueger2] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsGaussKrueger3, context: context),
        'widget': GCWCoordsGaussKrueger(
          gaussKruegerCode: 3,
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsGaussKrueger3] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsGaussKrueger4, context: context),
        'widget': GCWCoordsGaussKrueger(
          gaussKruegerCode: 4,
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsGaussKrueger4] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsGaussKrueger5, context: context),
        'widget': GCWCoordsGaussKrueger(
          gaussKruegerCode: 5,
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsGaussKrueger5] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsMaidenhead),
        'widget': GCWCoordsMaidenhead(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsMaidenhead] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsMercator),
        'widget': GCWCoordsMercator(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsMercator] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'coordFormat': getCoordFormatByKey(keyCoordsGeohash),
        'widget': GCWCoordsGeohash(
          onChanged: (newValue) {
            setState(() {
              _currentValue[keyCoordsGeohash] = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
    ];

    List<CoordinateFormat> _onlyCoordinateFormats = _coordsWidgets
      .map((entry) => entry['coordFormat'] as CoordinateFormat)
      .toList();

    Column _widget = Column(
      children: <Widget>[
        GCWTextDivider(
          text: widget.text
        ),
        GCWCoordsDropDownButton(
          value: widget.coordsFormat ?? _currentCoordsFormat,
          itemList: _onlyCoordinateFormats,
          onChanged: (newValue){
            setState(() {
              _currentCoordsFormat = newValue;
              _setCurrentValueAndEmitOnChange();
              FocusScope.of(context).requestFocus(new FocusNode()); //Release focus from previous edited field
            });
          },
        ),
      ],
    );

    var _currentWidget = _coordsWidgets
      .firstWhere((entry) => entry['coordFormat'].key == widget.coordsFormat ?? _currentCoordsFormat)['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({
      'coordsFormat': _currentCoordsFormat,
      'value': _currentValue[_currentCoordsFormat]
    });
  }
}