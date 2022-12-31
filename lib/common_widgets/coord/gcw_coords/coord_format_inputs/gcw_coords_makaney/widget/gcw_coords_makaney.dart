import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/coords_text_makaney_textinputformatter/widget/coords_text_makaney_textinputformatter.dart';

class GCWCoordsMakaney extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsMakaney({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsMakaneyState createState() => GCWCoordsMakaneyState();
}

class GCWCoordsMakaneyState extends State<GCWCoordsMakaney> {
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
      var makaney = widget.coordinates is Makaney
          ? widget.coordinates as Makaney
          : Makaney.fromLatLon(widget.coordinates.toLatLng());
      _currentCoord = makaney.toString();

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_makaney_locator'),
          controller: _controller,
          inputFormatters: [CoordsTextMakaneyTextInputFormatter()],
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
      widget.onChanged(Makaney.parse(_currentCoord));
    } catch (e) {}
  }
}
