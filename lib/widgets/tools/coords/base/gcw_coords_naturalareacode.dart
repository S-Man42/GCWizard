import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_naturalareacode_textinputformatter.dart';

class GCWCoordsNaturalAreaCode extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsNaturalAreaCode({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsNaturalAreaCodeState createState() => GCWCoordsNaturalAreaCodeState();
}

class GCWCoordsNaturalAreaCodeState extends State<GCWCoordsNaturalAreaCode> {
  TextEditingController _controllerX;
  TextEditingController _controllerY;
  var _currentX = '';
  var _currentY = '';

  @override
  void initState() {
    super.initState();

    _controllerX = TextEditingController(text: _currentX);
    _controllerY = TextEditingController(text: _currentY);
  }

  @override
  void dispose() {
    _controllerX.dispose();
    _controllerY.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var naturalAreaCode = widget.coordinates is NaturalAreaCode
          ? widget.coordinates as NaturalAreaCode
          : NaturalAreaCode.fromLatLon(widget.coordinates.toLatLng());
      _currentX = naturalAreaCode.x;
      _currentY = naturalAreaCode.y;

      _controllerX.text = _currentX;
      _controllerY.text = _currentY;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _controllerX,
          inputFormatters: [CoordsTextNaturalAreaCodeTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentX = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
          controller: _controllerY,
          inputFormatters: [CoordsTextNaturalAreaCodeTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentY = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(NaturalAreaCode(_currentX, _currentY));
  }
}
