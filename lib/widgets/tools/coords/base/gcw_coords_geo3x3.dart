import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geo3x3.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohex.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_geo3x3_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsGeo3x3 extends StatefulWidget {
  final Function onChanged;
  final LatLng coordinates;

  const GCWCoordsGeo3x3({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsGeo3x3State createState() => GCWCoordsGeo3x3State();
}

class GCWCoordsGeo3x3State extends State<GCWCoordsGeo3x3> {
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
    if (widget.coordinates != null) {
      _currentCoord = latLonToGeo3x3(widget.coordinates, 20);

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geo3x3_locator'),
          controller: _controller,
          inputFormatters: [CoordsTextGeo3x3TextInputFormatter()],
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
      LatLng coords = geo3x3ToLatLon(_currentCoord);
      widget.onChanged(coords);
    } catch (e) {}
  }
}
