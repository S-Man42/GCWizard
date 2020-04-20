import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsMercator extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsMercator({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsMercatorState createState() => GCWCoordsMercatorState();
}

class GCWCoordsMercatorState extends State<GCWCoordsMercator> {
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
    return Column (
        children: <Widget>[
          GCWDoubleTextField(
            hintText: i18n(context, 'coords_formatconverter_swissgrid_easting'),
            min: 0.0,
            controller: _EastingController,
            onChanged: (ret) {
              setState(() {
                _currentEasting = ret;
                _setCurrentValueAndEmitOnChange();
              });
            }
          ),
          GCWDoubleTextField(
              hintText: i18n(context, 'coords_formatconverter_swissgrid_northing'),
              min: 0.0,
              controller: _NorthingController,
              onChanged: (ret) {
                setState(() {
                  _currentNorthing = ret;
                  _setCurrentValueAndEmitOnChange();
                });
              }
          ),
        ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    var mercator = Mercator(_currentEasting['value'], _currentNorthing['value']);

    LatLng coords = mercatorToLatLon(mercator, defaultEllipsoid());
    widget.onChanged(coords);
  }
}