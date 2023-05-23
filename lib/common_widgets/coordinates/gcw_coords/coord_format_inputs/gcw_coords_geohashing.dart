part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGeohashing extends StatefulWidget {
  final void Function(Mercator) onChanged;
  final Mercator coordinates;
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
      var mercator = widget.coordinates;
      _currentEasting.value = mercator.easting;
      _currentNorthing.value = mercator.northing;

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
    var mercator = Mercator(_currentEasting.value, _currentNorthing.value);

    widget.onChanged(mercator);
  }
}
