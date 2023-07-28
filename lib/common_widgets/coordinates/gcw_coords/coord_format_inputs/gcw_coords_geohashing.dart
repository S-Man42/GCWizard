part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGeohashing extends StatefulWidget {
  final void Function(Geohashing) onChanged;
  final Geohashing coordinates;
  final bool isDefault;

  const _GCWCoordsGeohashing({Key? key, required this.onChanged, required this.coordinates, this.isDefault = true}) : super(key: key);

  @override
  _GCWCoordsGeohashingState createState() => _GCWCoordsGeohashingState();
}

class _GCWCoordsGeohashingState extends State<_GCWCoordsGeohashing> {
  late TextEditingController _EastingController;
  late TextEditingController _NorthingController;
  late DateTime _currentDate;

  var _currentEasting = defaultDoubleText;
  var _currentNorthing = defaultDoubleText;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);

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
    if (!widget.isDefault && !_initialized) {
      var geohashing = widget.coordinates;
      _currentEasting.value = geohashing.location.latitude;
      _currentNorthing.value = geohashing.location.longitude;

      _EastingController.text = _currentEasting.value.toString();
      _NorthingController.text = _currentNorthing.value.toString();

      _initialized = true;
    }

    return Column(children: <Widget>[
      GCWDatePicker(
          date: _currentDate,
          onChanged: (value) {
          setState(() {
            _currentDate = value;
          });
        },
      ),
      Row(
        children: <Widget>[
          GCWDoubleTextField(
              hintText: i18n(context, 'coords_formatconverter_northing'),
              controller: _NorthingController,
              onChanged: (ret) {
                setState(() {
                  _currentNorthing = ret;
                  _setCurrentValueAndEmitOnChange();
                });
              }),
          GCWDoubleTextField(
              hintText: i18n(context, 'coords_formatconverter_easting'),
              controller: _EastingController,
              onChanged: (ret) {
                setState(() {
                  _currentEasting = ret;
                  _setCurrentValueAndEmitOnChange();
                });
              }),
      ])
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    var geohashing = Geohashing(_currentDate, LatLng(_currentEasting.value, _currentNorthing.value));

    widget.onChanged(geohashing);
  }
}
