part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGaussKrueger extends StatefulWidget {
  final void Function(GaussKrueger) onChanged;
  GaussKrueger coordinates;
  final bool initialize;

  _GCWCoordsGaussKrueger({Key? key, required this.onChanged, required this.coordinates, this.initialize = false})
      : super(key: key);

  @override
  _GCWCoordsGaussKruegerState createState() => _GCWCoordsGaussKruegerState();
}

class _GCWCoordsGaussKruegerState extends State<_GCWCoordsGaussKrueger> {
  late TextEditingController _eastingController;
  late TextEditingController _northingController;

  var _currentEasting = defaultDoubleText;
  var _currentNorthing = defaultDoubleText;

  CoordinateFormatKey _currentSubtype = GaussKrueger.emptyCoordinate.defaultSubtype;

  @override
  void initState() {
    super.initState();

    _eastingController = TextEditingController(text: _currentEasting.text);
    _northingController = TextEditingController(text: _currentNorthing.text);
  }

  @override
  void dispose() {
    _eastingController.dispose();
    _northingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentSubtype = widget.coordinates.format.subtype!;

    if (_subtypeChanged()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _setCurrentValueAndEmitOnChange());
    } else if (widget.initialize) {
      var gausskrueger = widget.coordinates;
      _currentEasting.value = gausskrueger.easting;
      _currentNorthing.value = gausskrueger.northing;

      _eastingController.text = _currentEasting.value.toString();
      _northingController.text = _currentNorthing.value.toString();
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_gausskrueger_easting'),
          controller: _eastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_gausskrueger_northing'),
          controller: _northingController,
          onChanged: (ret) {
            setState(() {
              _currentNorthing = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  bool _subtypeChanged() {
    return _currentSubtype != widget.coordinates.format.subtype;
  }

  void _setCurrentValueAndEmitOnChange() {
    var subtype = _currentSubtype;
    var gaussKrueger = GaussKrueger(_currentEasting.value, _currentNorthing.value, subtype);

    widget.onChanged(gaussKrueger);
  }
}
