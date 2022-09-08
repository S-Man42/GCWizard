import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/lambert.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsLambert extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;
  final String subtype;

  const GCWCoordsLambert({Key key, this.onChanged, this.coordinates, this.subtype: keyCoordsGaussKruegerGK1})
      : super(key: key);

  @override
  GCWCoordsLambertState createState() => GCWCoordsLambertState();
}

class GCWCoordsLambertState extends State<GCWCoordsLambert> {
  TextEditingController _eastingController;
  TextEditingController _northingController;

  var _currentEasting = {'text': '', 'value': 0.0};
  var _currentNorthing = {'text': '', 'value': 0.0};

  var _currentSubtype = LambertType.LAMBERT_93;

  @override
  void initState() {
    super.initState();

    _currentSubtype = _getSubType(widget.subtype);

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
    if (widget.coordinates != null) {
      var lambert = widget.coordinates is Lambert
          ? widget.coordinates as Lambert
          : Lambert.fromLatLon(widget.coordinates.toLatLng(), _currentSubtype, defaultEllipsoid());
      _currentEasting['value'] = lambert.easting;
      _currentNorthing['value'] = lambert.northing;
      _currentSubtype = lambert.type;

      _eastingController.text = _currentEasting['value'].toString();
      _northingController.text = _currentNorthing['value'].toString();
    } else if (_subtypeChanged()) {
      _currentSubtype = _getSubType(widget.subtype);
      WidgetsBinding.instance.addPostFrameCallback((_) => _setCurrentValueAndEmitOnChange());
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _eastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
          controller: _northingController,
          onChanged: (ret) {
            setState(() {
              _currentNorthing = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  LambertType _getSubType(String subtype) {
    switch (subtype) {
      case keyCoordsLambert93: return LambertType.LAMBERT_93;
      case keyCoordsLambert2008: return LambertType.LAMBERT_2008;
      case keyCoordsLambertETRS89LCC: return LambertType.ETRS89_LCC;
      case keyCoordsLambert72: return LambertType.LAMBERT_72;
      case keyCoordsLambert93CC42: return LambertType.L93_CC42;
      case keyCoordsLambert93CC43: return LambertType.L93_CC43;
      case keyCoordsLambert93CC44: return LambertType.L93_CC44;
      case keyCoordsLambert93CC45: return LambertType.L93_CC45;
      case keyCoordsLambert93CC46: return LambertType.L93_CC46;
      case keyCoordsLambert93CC47: return LambertType.L93_CC47;
      case keyCoordsLambert93CC48: return LambertType.L93_CC48;
      case keyCoordsLambert93CC49: return LambertType.L93_CC49;
      case keyCoordsLambert93CC50: return LambertType.L93_CC50;
      default: return LambertType.LAMBERT_93;
    }
  }

  bool _subtypeChanged() {
    return _currentSubtype != _getSubType(widget.subtype);
  }

  _setCurrentValueAndEmitOnChange() {
    var lambert = Lambert(_currentSubtype, _currentEasting['value'], _currentNorthing['value']);
    widget.onChanged(lambert);
  }
}
