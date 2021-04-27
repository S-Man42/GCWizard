import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsSwissGridPlus extends StatefulWidget {
  final Function onChanged;
  final LatLng coordinates;

  const GCWCoordsSwissGridPlus({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsSwissGridPlusState createState() => GCWCoordsSwissGridPlusState();
}

class GCWCoordsSwissGridPlusState extends State<GCWCoordsSwissGridPlus> {
  var _EastingController;
  var _NorthingController;

  var _currentEasting = {'text': '', 'value': 0.0};
  var _currentNorthing = {'text': '', 'value': 0.0};

  @override
  void initState() {
    super.initState();
    _EastingController = TextEditingController(text: _currentEasting['text']);
    _NorthingController = TextEditingController(text: _currentNorthing['text']);
  }

  @override
  void dispose() {
    _EastingController.dispose();
    _NorthingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var swissGrid = latLonToSwissGridPlus(widget.coordinates, defaultEllipsoid());
      _currentEasting['value'] = swissGrid.easting;
      _currentNorthing['value'] = swissGrid.northing;

      _EastingController.text = _currentEasting['value'].toString();
      _NorthingController.text = _currentNorthing['value'].toString();
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_swissgrid_easting'),
          min: 0.0,
          controller: _EastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_swissgrid_northing'),
          min: 0.0,
          controller: _NorthingController,
          onChanged: (ret) {
            setState(() {
              _currentNorthing = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    var swissGrid = SwissGrid(_currentEasting['value'], _currentNorthing['value']);

    LatLng coords = swissGridPlusToLatLon(swissGrid, defaultEllipsoid());
    widget.onChanged(coords);
  }
}
