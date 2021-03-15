import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_maidenhead_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsMaidenhead extends StatefulWidget {
  final Function onChanged;
  final LatLng coordinates;

  const GCWCoordsMaidenhead({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsMaidenheadState createState() => GCWCoordsMaidenheadState();
}

class GCWCoordsMaidenheadState extends State<GCWCoordsMaidenhead> {
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
      _currentCoord = latLonToMaidenhead(widget.coordinates);

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_maidenhead_locator'),
          controller: _controller,
          inputFormatters: [CoordsTextMaidenheadTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    var maidenhead = _currentCoord;
    if (maidenhead.length % 2 == 1) maidenhead = maidenhead.substring(0, maidenhead.length - 1);

    LatLng coords = maidenheadToLatLon(maidenhead);
    widget.onChanged(coords);
  }
}
