import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_geohash_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsGeohash extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsGeohash({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsGeohashState createState() => GCWCoordsGeohashState();
}

class GCWCoordsGeohashState extends State<GCWCoordsGeohash> {
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
            hintText: i18n(context, 'coords_formatconverter_geohash_locator'),
            controller: _controller,
            inputFormatters: [CoordsTextGeohashTextInputFormatter()],
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
    LatLng coords = geohashToLatLon(_currentCoord);
    widget.onChanged(coords);
  }
}