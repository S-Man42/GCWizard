import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_dec.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_deg.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_dms.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_gausskrueger.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_geohash.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_maidenhead.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_mercator.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_mgrs.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_swissgrid.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_utm.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:latlong/latlong.dart';

class GCWColors extends StatefulWidget {
  final Function onChanged;
  final String colorFormat;
  final String text;

  const GCWColors({Key key, this.text, this.onChanged, this.colorFormat}) : super(key: key);

  @override
  GCWColorsState createState() => GCWColorsState();
}

class GCWColorsState extends State<GCWColors> {

  String _currentCoordsFormat = defaultCoordFormat();
  Map<String, LatLng> _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = Map.fromIterable(allCoordFormats, key: (format) => format.key, value: (format) => defaultCoordinate);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _currentColor = [

    ];

    List<CoordinateFormat> _onlyCoordinateFormats = _currentColor
      .map((entry) => entry['coordFormat'] as CoordinateFormat)
      .toList();

    Column _widget = Column(
      children: <Widget>[
        GCWTextDivider(
          text: widget.text
        ),
        GCWCoordsDropDownButton(
          value: widget.colorFormat ?? _currentCoordsFormat,
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

//    var _currentWidget = _coordsWidgets
//      .firstWhere((entry) => entry['coordFormat'].key == widget.colorFormat ?? _currentCoordsFormat)['widget'];
//
//    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({
      'coordsFormat': _currentCoordsFormat,
      'value': _currentValue[_currentCoordsFormat]
    });
  }
}