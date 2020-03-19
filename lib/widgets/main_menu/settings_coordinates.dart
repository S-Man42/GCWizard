import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_ellipsoid.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_sign_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:prefs/prefs.dart';

class CoordinatesSettings extends StatefulWidget {
  @override
  CoordinatesSettingsState createState() => CoordinatesSettingsState();
}

class CoordinatesSettingsState extends State<CoordinatesSettings> {
  var _currentDefaultFormat = Prefs.getString('coord_default_format');
  var _currentDefaultHemisphereLatitude = Prefs.getString('coord_default_hemisphere_latitude');
  var _currentDefaultHemisphereLongitude = Prefs.getString('coord_default_hemisphere_longitude');
  Ellipsoid _currentDefaultEllipsoid = defaultEllipsoid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultformat'),
        ),
        GCWCoordsDropDownButton(
          value: _currentDefaultFormat,
          itemList: allCoordFormats.map((format) => getCoordFormatByKey(format.key, context: context)).toList(),
          onChanged: (newValue){
            setState(() {
              _currentDefaultFormat = newValue;
              Prefs.setString('coord_default_format', _currentDefaultFormat);
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaulthemispheres'),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'coords_common_latitude'),
              ),
              flex: 1
            ),
            Expanded(
              child: GCWCoordsSignDropDownButton(
                itemList: [i18n(context, 'coords_common_north'), i18n(context, 'coords_common_south')],
                value: _currentDefaultHemisphereLatitude == HemisphereLatitude.North.toString() ? 1 : -1,
                onChanged: (value) {
                  setState(() {
                    _currentDefaultHemisphereLatitude = value > 0 ? HemisphereLatitude.North.toString() : HemisphereLatitude.South.toString();
                    Prefs.setString('coord_default_hemisphere_latitude', _currentDefaultHemisphereLatitude);
                  });
                }
              ),
              flex: 4
            )
          ]
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'coords_common_longitude'),
              ),
              flex: 1
            ),
            Expanded(
              child: GCWCoordsSignDropDownButton(
                itemList: [i18n(context, 'coords_common_east'), i18n(context, 'coords_common_west')],
                value: _currentDefaultHemisphereLongitude == HemisphereLongitude.East.toString() ? 1 : -1,
                onChanged: (value) {
                  setState(() {
                    _currentDefaultHemisphereLongitude = value > 0 ? HemisphereLongitude.East.toString() : HemisphereLongitude.West.toString();
                    Prefs.setString('coord_default_hemisphere_longitude', _currentDefaultHemisphereLongitude);
                  });
                }
              ),
              flex: 4
            )
          ]
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultrotationellipsoid'),
        ),
        GCWCoordsEllipsoid(
          onChanged: (ells) {
            _currentDefaultEllipsoid = ells;

            switch(_currentDefaultEllipsoid.type) {
              case EllipsoidType.STANDARD:
                Prefs.setString('coord_default_ellipsoid_type', EllipsoidType.STANDARD.toString());
                Prefs.setString('coord_default_ellipsoid_name', ells.name);
                break;
              case EllipsoidType.USER_DEFINED:
                Prefs.setString('coord_default_ellipsoid_type', EllipsoidType.USER_DEFINED.toString());
                Prefs.setDouble('coord_default_ellipsoid_a', ells.a);
                Prefs.setDouble('coord_default_ellipsoid_invf', ells.invf);
                break;
            }
          },
        )
      ],
    );
  }
}