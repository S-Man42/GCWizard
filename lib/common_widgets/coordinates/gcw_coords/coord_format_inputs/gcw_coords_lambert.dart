part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsLambert extends StatefulWidget {
  final void Function(Lambert) onChanged;
  final BaseCoordinates? coordinates;
  final CoordFormatKey subtype;

  const _GCWCoordsLambert({Key? key, required this.onChanged, this.coordinates, this.subtype: defaultLambertType})
      : super(key: key);

  @override
  _GCWCoordsLambertState createState() => _GCWCoordsLambertState();
}

class _GCWCoordsLambertState extends State<_GCWCoordsLambert> {
  late TextEditingController _eastingController;
  late TextEditingController _northingController;

  var _currentEasting = defaultDoubleText;
  var _currentNorthing = defaultDoubleText;

  var _currentSubtype = defaultLambertType;

  _setLambertSubType() {
    if (isSubtypeOfCoordFormat(CoordFormatKey.LAMBERT, widget.subtype))
      _currentSubtype = widget.subtype;
    else
      _currentSubtype = defaultLambertType;
  }

  @override
  void initState() {
    super.initState();

    _setLambertSubType();

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
    if (widget.coordinates != null) {
      var lambert = widget.coordinates is Lambert
          ? widget.coordinates as Lambert
          : Lambert.fromLatLon(widget.coordinates!.toLatLng(), _currentSubtype, defaultEllipsoid());
      _currentEasting.value = lambert.easting;
      _currentNorthing.value = lambert.northing;
      _currentSubtype = lambert.subtype;

      _eastingController.text = _currentEasting.value.toString();
      _northingController.text = _currentNorthing.value.toString();
    } else if (_subtypeChanged()) {
      _setLambertSubType();

      WidgetsBinding.instance.addPostFrameCallback((_) => _setCurrentValueAndEmitOnChange());
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _eastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
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
    return _currentSubtype != widget.subtype;
  }

  _setCurrentValueAndEmitOnChange() {
    var lambert = Lambert(_currentSubtype, _currentEasting.value, _currentNorthing.value);
    widget.onChanged(lambert);
  }
}
