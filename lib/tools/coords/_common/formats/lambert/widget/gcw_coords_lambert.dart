part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordWidgetInfoLambert extends _GCWCoordWidgetWithSubtypeInfo {
  @override
  CoordinateFormatKey get type => CoordinateFormatKey.LAMBERT;
  @override
  String get i18nKey => lambertKey;
  @override
  String get name => 'coords_formatconverter_lambert';
  @override
  String get example => 'X: 8837763.4, Y: 5978799.1';

  @override
  _GCWCoordWidget mainWidget({
    Key? key,
    required void Function(BaseCoordinate?) onChanged,
    required BaseCoordinate coordinates,
    bool? initialize,
  }) {
    return _GCWCoordsLambert(key: key, onChanged: onChanged, coordinates: coordinates, initialize: initialize = false);
  }

  @override
  Widget inputWidget() {
    // TODO: implement inputWidget
    throw UnimplementedError();
  }

  @override
  Widget outputWidget() {
    // TODO: implement outputWidget
    throw UnimplementedError();
  }
}

class _GCWCoordsLambert extends _GCWCoordWidget {

  _GCWCoordsLambert({super.key, required super.onChanged, required BaseCoordinate coordinates, super.initialize = false}) :
        super(coordinates: coordinates is LambertCoordinate ? coordinates : LambertCoordinate.defaultCoordinate);

  @override
  _GCWCoordsLambertState createState() => _GCWCoordsLambertState();
}

class _GCWCoordsLambertState extends State<_GCWCoordsLambert> {
  late TextEditingController _eastingController;
  late TextEditingController _northingController;

  var _currentEasting = defaultDoubleText;
  var _currentNorthing = defaultDoubleText;

  var _currentSubtype = LambertCoordinate.defaultCoordinate.defaultSubtype;

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
      var lambert = widget.coordinates as LambertCoordinate;
      _currentEasting.value = lambert.easting;
      _currentNorthing.value = lambert.northing;

      _eastingController.text = _currentEasting.value.toString();
      _northingController.text = _currentNorthing.value.toString();
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
    return _currentSubtype != widget.coordinates.format.subtype;
  }

  void _setCurrentValueAndEmitOnChange() {
    var lambert = LambertCoordinate(_currentEasting.value, _currentNorthing.value, _currentSubtype);
    widget.onChanged(lambert);
  }
}
