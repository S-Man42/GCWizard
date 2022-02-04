import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';

class GCWCoordsDutchGrid extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsDutchGrid({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsDutchGridState createState() => GCWCoordsDutchGridState();
}

class GCWCoordsDutchGridState extends State<GCWCoordsDutchGrid> {
  TextEditingController _xController;
  TextEditingController _yController;

  var _currentX = {'text': '', 'value': 0.0};
  var _currentY = {'text': '', 'value': 0.0};

  @override
  void initState() {
    super.initState();
    _xController = TextEditingController(text: _currentX['text']);
    _yController = TextEditingController(text: _currentY['text']);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var dutchGrid = widget.coordinates is DutchGrid
          ? widget.coordinates as DutchGrid
          : DutchGrid.fromLatLon(widget.coordinates.toLatLng());
      _currentX['value'] = dutchGrid.x;
      _currentY['value'] = dutchGrid.y;

      _xController.text = _currentX['value'].toString();
      _yController.text = _currentY['value'].toString();
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_dutchgrid_x'),
          controller: _xController,
          onChanged: (ret) {
            setState(() {
              _currentX = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_dutchgrid_y'),
          controller: _yController,
          onChanged: (ret) {
            setState(() {
              _currentY = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(DutchGrid(_currentX['value'], _currentY['value']));
  }
}
