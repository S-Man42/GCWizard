import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_utm_lonzone_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsMGRS extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsMGRS({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsMGRSState createState() => GCWCoordsMGRSState();
}

class GCWCoordsMGRSState extends State<GCWCoordsMGRS> {
  var _LonZoneController;
  var _EastingController;
  var _NorthingController;

  var _currentLatZone = 'A';
  var _currentDigraphEasting = 'A';
  var _currentDigraphNorthing = 'A';

  var _currentLonZone = {'text': '', 'value': 0};
  var _currentEasting = {'text': '', 'value': 0.0};
  var _currentNorthing = {'text': '', 'value': 0.0};

  @override
  void initState() {
    super.initState();
    _LonZoneController = TextEditingController(text: _currentLonZone['text']);

    _EastingController = TextEditingController(text: _currentEasting['text']);
    _NorthingController = TextEditingController(text: _currentNorthing['text']);
  }

  @override
  void dispose() {
    _LonZoneController.dispose();
    _EastingController.dispose();
    _NorthingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: GCWIntegerTextField(
                    hintText: i18n(context, 'coords_formatconverter_mgrs_lonzone'),
                    textInputFormatter: CoordsIntegerUTMLonZoneTextInputFormatter(),
                    controller: _LonZoneController,
                    onChanged: (ret) {
                      setState(() {
                        _currentLonZone = ret;
                        //   _setCurrentValueAndEmitOnChange();
                      });
                    }
                  ),
                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                )
              ),
              Expanded(
                child: Container(
                  child: GCWDropDownButton(
                    value: _currentLatZone,
                    onChanged: (newValue) {
                      setState(() {
                        _currentLatZone = newValue;
                        // _setCurrentValueAndEmitOnChange();
                      });
                    },
                    items: digraphLettersEast.split('').map((char) {
                      return GCWDropDownMenuItem(
                        value: char,
                        child: char,
                      );
                    }).toList(),
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN)
                )
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: GCWDropDownButton(
                    value: _currentDigraphEasting,
                    onChanged: (newValue) {
                      setState(() {
                        _currentDigraphEasting = newValue;
                        // _setCurrentValueAndEmitOnChange();
                      });
                    },
                    items: digraphLettersEast.split('').map((char) {
                      return GCWDropDownMenuItem(
                        value: char,
                        child: char,
                      );
                    }).toList(),
                  ),
                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                )
              ),
              Expanded(
                child: Container(
                  child: GCWDropDownButton(
                    value: _currentDigraphNorthing,
                    onChanged: (newValue) {
                      setState(() {
                        _currentDigraphNorthing = newValue;
                        //_setCurrentValueAndEmitOnChange();
                      });
                    },
                    items: digraphLettersNorth.split('').map((char) {
                      return GCWDropDownMenuItem(
                        value: char,
                        child: char,
                      );
                    }).toList(),
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN),
                )
              )
            ],
          ),
          GCWDoubleTextField(
            hintText: i18n(context, 'coords_formatconverter_mgrs_easting'),
            min: 0.0,
            controller: _EastingController,
            onChanged: (ret) {
              setState(() {
                _currentEasting = ret;
                _setCurrentValueAndEmitOnChange();
              });
            }
          ),
          GCWDoubleTextField(
              hintText: i18n(context, 'coords_formatconverter_mgrs_northing'),
              min: 0.0,
              controller: _NorthingController,
              onChanged: (ret) {
                setState(() {
                  _currentNorthing = ret;
                  _setCurrentValueAndEmitOnChange();
                });
              }
          ),
        ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    double easting = fillUpNumber(_currentEasting['value'], _EastingController.text, 5);

    double northing = fillUpNumber(_currentNorthing['value'], _NorthingController.text, 5);

    var _lonZone = _currentLonZone['value'];
    var zone = UTMZone(_lonZone, _lonZone, _currentLatZone);
    var mgrs = MGRS(zone, _currentDigraphEasting + _currentDigraphNorthing, easting, northing);

    LatLng coords = mgrsToLatLon(mgrs, defaultEllipsoid());

    widget.onChanged(coords);
  }
}