import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsGaussKrueger extends StatefulWidget {
  final Function onChanged;
  final gaussKruegerCode;

  const GCWCoordsGaussKrueger({Key key, this.gaussKruegerCode: 1, this.onChanged}) : super(key: key);

  @override
  GCWCoordsGaussKruegerState createState() => GCWCoordsGaussKruegerState();
}

class GCWCoordsGaussKruegerState extends State<GCWCoordsGaussKrueger> {
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
            hintText: i18n(context, 'coords_formatconverter_gausskrueger_easting'),
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
            hintText: i18n(context, 'coords_formatconverter_gausskrueger_northing'),
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
    var gaussKrueger = GaussKrueger(widget.gaussKruegerCode, _currentEasting['value'], _currentNorthing['value']);
    LatLng coords = gaussKruegerToLatLon(gaussKrueger, defaultEllipsoid());

    widget.onChanged(coords);
  }
}