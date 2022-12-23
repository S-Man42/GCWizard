import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/data/logic/coordinates.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/coords_text_geohex_textinputformatter/widget/coords_text_geohex_textinputformatter.dart';

class GCWCoordsGeoHex extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsGeoHex({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsGeoHexState createState() => GCWCoordsGeoHexState();
}

class GCWCoordsGeoHexState extends State<GCWCoordsGeoHex> {
  TextEditingController _controller;
  var _currentCoord = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentCoord);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var geohHex = widget.coordinates is GeoHex
          ? widget.coordinates as GeoHex
          : GeoHex.fromLatLon(widget.coordinates.toLatLng(), 20);
      _currentCoord = geohHex.text;

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geohex_locator'),
          controller: _controller,
          inputFormatters: [CoordsTextGeoHexTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    try {
      widget.onChanged(GeoHex.parse(_currentCoord));
    } catch (e) {}
  }
}
