import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohex.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_geohex_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsGeoHex extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsGeoHex({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsGeoHexState createState() => GCWCoordsGeoHexState();
}

class GCWCoordsGeoHexState extends State<GCWCoordsGeoHex> {
  var _controller;
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
    return Column (
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geohex_locator'),
          controller: _controller,
          inputFormatters: [CoordsTextGeoHexTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
        ),
      ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    try {
      LatLng coords = geoHexToLatLon(_currentCoord);
      widget.onChanged(coords);
    } catch(e) {}
  }
}