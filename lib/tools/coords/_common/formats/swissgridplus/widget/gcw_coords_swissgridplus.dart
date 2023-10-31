part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordsSwissGridPlus extends _GCWCoordWidget {

  _GCWCoordsSwissGridPlus({super.key, required super.onChanged, required BaseCoordinate coordinates, super.initialize = false}) :
        super(coordinates: coordinates is SwissGridPlusCoordinate ? coordinates : SwissGridPlusCoordinate.defaultCoordinate,
          type: CoordinateFormatKey.SWISS_GRID_PLUS, i18nKey: swissGridPlusKey);

  @override
  _GCWCoordsSwissGridPlusState createState() => _GCWCoordsSwissGridPlusState();
}

class _GCWCoordsSwissGridPlusState extends State<_GCWCoordsSwissGridPlus> {
  late TextEditingController _EastingController;
  late TextEditingController _NorthingController;

  var _currentEasting = defaultDoubleText;
  var _currentNorthing = defaultDoubleText;

  @override
  void initState() {
    super.initState();
    _EastingController = TextEditingController(text: _currentEasting.text);
    _NorthingController = TextEditingController(text: _currentNorthing.text);
  }

  @override
  void dispose() {
    _EastingController.dispose();
    _NorthingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialize) {
      var swissGridPlus = widget.coordinates is SwissGridPlusCoordinate
          ? widget.coordinates as SwissGridPlusCoordinate
          : SwissGridPlusCoordinate.fromLatLon(widget.coordinates.toLatLng() ?? defaultCoordinate, defaultEllipsoid);
      _currentEasting.value = swissGridPlus.easting;
      _currentNorthing.value = swissGridPlus.northing;

      _EastingController.text = _currentEasting.value.toString();
      _NorthingController.text = _currentNorthing.value.toString();
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _EastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
          controller: _NorthingController,
          onChanged: (ret) {
            setState(() {
              _currentNorthing = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(SwissGridPlusCoordinate(_currentEasting.value, _currentNorthing.value));
  }
}
