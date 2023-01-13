import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/coords_text_geo3x3_textinputformatter/widget/coords_text_geo3x3_textinputformatter.dart';

class GCWCoordsGeo3x3 extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsGeo3x3({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsGeo3x3State createState() => GCWCoordsGeo3x3State();
}

class GCWCoordsGeo3x3State extends State<GCWCoordsGeo3x3> {
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
      var geo3x3 = widget.coordinates is Geo3x3
          ? widget.coordinates as Geo3x3
          : Geo3x3.fromLatLon(widget.coordinates.toLatLng(), 20);
      _currentCoord = geo3x3.text;

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
      widget.onChanged(Geo3x3.parse(_currentCoord));
    } catch (e) {}
  }
}
