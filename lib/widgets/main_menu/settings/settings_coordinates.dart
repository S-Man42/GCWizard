import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_ellipsoid.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_formatselector.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_sign_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:prefs/prefs.dart';

class CoordinatesSettings extends StatefulWidget {
  @override
  CoordinatesSettingsState createState() => CoordinatesSettingsState();
}

class CoordinatesSettingsState extends State<CoordinatesSettings> {
  var _currentDefaultFormat = {
    'format': Prefs.getString(PREFERENCE_COORD_DEFAULT_FORMAT),
    'subtype': Prefs.getString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE)
  };
  var _currentDefaultHemisphereLatitude = Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE);
  var _currentDefaultHemisphereLongitude = Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE);
  Ellipsoid _currentDefaultEllipsoid = defaultEllipsoid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultformat'),
        ),
        GCWCoordsFormatSelector(
          format: _currentDefaultFormat,
          onChanged: (newValue) {
            setState(() {
              _currentDefaultFormat = newValue;
              Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT, _currentDefaultFormat['format']);
              Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE, _currentDefaultFormat['subtype']);
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaulthemispheres'),
        ),
        Row(children: <Widget>[
          Expanded(
              child: GCWText(
                text: i18n(context, 'coords_common_latitude'),
              ),
              flex: 1),
          Expanded(
              child: GCWCoordsSignDropDownButton(
                  itemList: [i18n(context, 'coords_common_north'), i18n(context, 'coords_common_south')],
                  value: _currentDefaultHemisphereLatitude == HemisphereLatitude.North.toString() ? 1 : -1,
                  onChanged: (value) {
                    setState(() {
                      _currentDefaultHemisphereLatitude =
                          value > 0 ? HemisphereLatitude.North.toString() : HemisphereLatitude.South.toString();
                      Prefs.setString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE, _currentDefaultHemisphereLatitude);
                    });
                  }),
              flex: 4)
        ]),
        Row(children: <Widget>[
          Expanded(
              child: GCWText(
                text: i18n(context, 'coords_common_longitude'),
              ),
              flex: 1),
          Expanded(
              child: GCWCoordsSignDropDownButton(
                  itemList: [i18n(context, 'coords_common_east'), i18n(context, 'coords_common_west')],
                  value: _currentDefaultHemisphereLongitude == HemisphereLongitude.East.toString() ? 1 : -1,
                  onChanged: (value) {
                    setState(() {
                      _currentDefaultHemisphereLongitude =
                          value > 0 ? HemisphereLongitude.East.toString() : HemisphereLongitude.West.toString();
                      Prefs.setString(
                          PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE, _currentDefaultHemisphereLongitude);
                    });
                  }),
              flex: 4)
        ]),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultrotationellipsoid'),
        ),
        GCWCoordsEllipsoid(
          onChanged: (ells) {
            _currentDefaultEllipsoid = ells;

            switch (_currentDefaultEllipsoid.type) {
              case EllipsoidType.STANDARD:
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE, EllipsoidType.STANDARD.toString());
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_NAME, ells.name);
                break;
              case EllipsoidType.USER_DEFINED:
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE, EllipsoidType.USER_DEFINED.toString());
                Prefs.setDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_A, ells.a);
                Prefs.setDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_INVF, ells.invf);
                break;
            }
          },
        )
      ],
    );
  }
}
