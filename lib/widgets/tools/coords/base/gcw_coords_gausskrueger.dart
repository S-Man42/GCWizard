import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsGaussKrueger extends StatefulWidget {
  final Function onChanged;
  final String subtype;

  const GCWCoordsGaussKrueger({Key key, this.subtype: keyCoordsGaussKruegerGK1, this.onChanged}) : super(key: key);

  @override
  GCWCoordsGaussKruegerState createState() => GCWCoordsGaussKruegerState();
}

class GCWCoordsGaussKruegerState extends State<GCWCoordsGaussKrueger> {
  var _eastingController;
  var _northingController;

  var _currentEasting = {'text': '', 'value': 0.0};
  var _currentNorthing = {'text': '', 'value': 0.0};

  var _currentSubtype;

  @override
  void initState() {
    super.initState();

    _currentSubtype = widget.subtype;

    _eastingController = TextEditingController(text: _currentEasting['text']);
    _northingController = TextEditingController(text: _currentNorthing['text']);
  }

  @override
  void dispose() {
    _eastingController.dispose();
    _northingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentSubtype != widget.subtype) {
      _eastingController.clear();
      _northingController.clear();

      _currentSubtype = widget.subtype;
    }

    return Column (
      children: <Widget>[
        GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_gausskrueger_easting'),
          min: 0.0,
          controller: _eastingController,
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
          controller: _northingController,
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
    var code;
    switch (widget.subtype) {
      case keyCoordsGaussKruegerGK1: code = 1; break;
      case keyCoordsGaussKruegerGK2: code = 2; break;
      case keyCoordsGaussKruegerGK3: code = 3; break;
      case keyCoordsGaussKruegerGK4: code = 4; break;
      case keyCoordsGaussKruegerGK5: code = 5; break;
    }

    var gaussKrueger = GaussKrueger(code, _currentEasting['value'], _currentNorthing['value']);
    LatLng coords = gaussKruegerToLatLon(gaussKrueger, defaultEllipsoid());

    widget.onChanged(coords);
  }
}