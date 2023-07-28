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
  late TextEditingController _LongitudeController;
  late TextEditingController _LatitudeController;
  late DateTime _currentDate;

  var _currentLongitude = defaultIntegerText;
  var _currentLatitude = defaultIntegerText;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);

    _LongitudeController = TextEditingController(text: _currentLongitude.text);
    _LatitudeController = TextEditingController(text: _currentLatitude.text);
  }

  @override
  void dispose() {
    _LongitudeController.dispose();
    _LatitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isDefault && !_initialized) {
      var geohashing = widget.coordinates;
      _currentLatitude.value = geohashing.latitude;
      _currentLongitude.value = geohashing.longitude;

      _LatitudeController.text = _currentLatitude.value.toString();
      _LongitudeController.text = _currentLongitude.value.toString();

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
        children: [
          Expanded(
            child:
              GCWIntegerTextField(
                hintText: i18n(context, 'coords_common_latitude'),
                controller: _LatitudeController,
                onChanged: (ret) {
                  setState(() {
                    _currentLatitude = ret;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child:
            GCWIntegerTextField(
                hintText: i18n(context, 'coords_common_longitude'),
                controller: _LongitudeController,
                onChanged: (ret) {
                  setState(() {
                    _currentLongitude = ret;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),

          )
      ])
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    var geohashing = Geohashing(_currentDate, _currentLatitude.value, _currentLongitude.value);

    widget.onChanged(geohashing);
  }
}
