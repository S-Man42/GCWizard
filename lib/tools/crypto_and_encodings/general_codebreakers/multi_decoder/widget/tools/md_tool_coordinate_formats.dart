import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_stateful_dropdown.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coord_format_getter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';
import 'package:latlong2/latlong.dart';

const MDT_INTERNALNAMES_COORDINATEFORMATS = 'multidecoder_tool_coordinateformats_title';
const MDT_COORDINATEFORMATS_OPTION_FORMAT = 'multidecoder_tool_coordinateformats_option_format';

class MultiDecoderToolCoordinateFormats extends AbstractMultiDecoderTool {
  MultiDecoderToolCoordinateFormats({Key? key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_COORDINATEFORMATS,
            onDecode: (String input, String key) {
              input = input.replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
              LatLng coords;
              try {
                switch (options[MDT_COORDINATEFORMATS_OPTION_FORMAT]) {
                  case CoordFormatKey.DEC:
                    coords = DEC.parse(input, wholeString: true)?.toLatLng();
                    break;
                  case CoordFormatKey.DMM:
                    coords = DMM.parse(input, wholeString: true)?.toLatLng();
                    break;
                  case CoordFormatKey.DMS:
                    coords = DMS.parse(input, wholeString: true)?.toLatLng();
                    break;
                  case CoordFormatKey.UTM:
                    coords = UTMREF.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.MGRS:
                    coords = MGRS.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.XYZ:
                    coords = XYZ.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.SWISS_GRID:
                    coords = SwissGrid.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.SWISS_GRID_PLUS:
                    coords = SwissGridPlus.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.GAUSS_KRUEGER:
                    coords = GaussKrueger.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.LAMBERT:
                    coords = Lambert.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.DUTCH_GRID:
                    coords = DutchGrid.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.MAIDENHEAD:
                    coords = Maidenhead.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.MERCATOR:
                    coords = Mercator.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case CoordFormatKey.NATURAL_AREA_CODE:
                    coords = NaturalAreaCode.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.GEOHASH:
                    coords = Geohash.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.GEOHEX:
                    coords = GeoHex.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.GEO3X3:
                    coords = Geo3x3.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.OPEN_LOCATION_CODE:
                    coords = OpenLocationCode.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.QUADTREE:
                    coords = Quadtree.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.REVERSE_WIG_WALDMEISTER:
                    coords = ReverseWherigoWaldmeister.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.REVERSE_WIG_DAY1976:
                    coords = ReverseWherigoDay1976.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.SLIPPY_MAP:
                    coords = SlippyMap.parse(input)?.toLatLng();
                    break;
                  case CoordFormatKey.MAKANEY:
                    coords = Makaney.parse(input)?.toLatLng();
                    break;
                }
              } catch (e) {}

              if (coords == null) return null;

              return formatCoordOutput(coords, defaultCoordFormat(), defaultEllipsoid());
            },
            options: options,
            configurationWidget: MultiDecoderToolConfiguration(widgets: {
              MDT_COORDINATEFORMATS_OPTION_FORMAT: GCWStatefulDropDown(
                value: options[MDT_COORDINATEFORMATS_OPTION_FORMAT],
                onChanged: (newValue) {
                  options[MDT_COORDINATEFORMATS_OPTION_FORMAT] = newValue;
                },
                items: allCoordFormats.where((format) => format.key != CoordFormatKey.SLIPPY_MAP).map((format) {
                  return GCWDropDownMenuItem(
                    value: format.key,
                    child: i18n(context, format.name, ifTranslationNotExists: format.name),
                  );
                }).toList(),
              ),
            }));
}
