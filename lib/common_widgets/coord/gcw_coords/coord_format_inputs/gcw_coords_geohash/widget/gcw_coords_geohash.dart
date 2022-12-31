import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/coords_text_geohash_textinputformatter/widget/coords_text_geohash_textinputformatter.dart';

class GCWCoordsGeohash extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsGeohash({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsGeohashState createState() => GCWCoordsGeohashState();
}

class GCWCoordsGeohashState extends State<GCWCoordsGeohash> {
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
      var geohash = widget.coordinates is Geohash
          ? widget.coordinates as Geohash
          : Geohash.fromLatLon(widget.coordinates.toLatLng(), 14);
      _currentCoord = geohash.text;

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geohash_locator'),
          controller: _controller,
          inputFormatters: [CoordsTextGeohashTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(Geohash.parse(_currentCoord));
  }
}
