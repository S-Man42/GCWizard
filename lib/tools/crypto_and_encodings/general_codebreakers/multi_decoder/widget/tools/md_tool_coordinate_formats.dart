import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dec/logic/dec.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dmm/logic/dmm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dms/logic/dms.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dutchgrid/logic/dutchgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/gausskrueger/logic/gauss_krueger.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geo3x3/logic/geo3x3.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohash/logic/geohash.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohex/logic/geohex.dart';
import 'package:gc_wizard/tools/coords/_common/formats/lambert/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/_common/formats/maidenhead/logic/maidenhead.dart';
import 'package:gc_wizard/tools/coords/_common/formats/makaney/logic/makaney.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mercator/logic/mercator.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mgrs_utm/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/_common/formats/natural_area_code/logic/natural_area_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/openlocationcode/logic/open_location_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/quadtree/logic/quadtree.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_day1976/logic/reverse_wherigo_day1976.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_waldmeister/logic/reverse_wherigo_waldmeister.dart';
import 'package:gc_wizard/tools/coords/_common/formats/slippymap/logic/slippy_map.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgrid/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgridplus/logic/swissgridplus.dart';
import 'package:gc_wizard/tools/coords/_common/formats/utm/logic/utm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/xyz/logic/xyz.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_metadata.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_text_formatter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';

const MDT_INTERNALNAMES_COORDINATEFORMATS = 'multidecoder_tool_coordinateformats_title';
const MDT_COORDINATEFORMATS_OPTION_FORMAT = 'multidecoder_tool_coordinateformats_option_format';

class MultiDecoderToolCoordinateFormats extends AbstractMultiDecoderTool {
  MultiDecoderToolCoordinateFormats(
      {Key? key,
      required int id,
      required String name,
      required Map<String, Object?> options,
      required BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_COORDINATEFORMATS,
            onDecode: (String input, String key) {
              input = input.replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
              BaseCoordinate? coords;
              try {
                var coordinateFormatKey = _getCoordinateFormatKey(options, MDT_COORDINATEFORMATS_OPTION_FORMAT);
                switch (coordinateFormatKey) {
                  case CoordinateFormatKey.DEC:
                    coords = DECCoordinate.parse(input, wholeString: true);
                    break;
                  case CoordinateFormatKey.DMM:
                    coords = DMMCoordinate.parse(input, wholeString: true);
                    break;
                  case CoordinateFormatKey.DMS:
                    coords = DMSCoordinate.parse(input, wholeString: true);
                    break;
                  case CoordinateFormatKey.UTM:
                    coords = UTMREFCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.MGRS:
                    coords = MGRSCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.XYZ:
                    coords = XYZCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.SWISS_GRID:
                    coords = SwissGridCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.SWISS_GRID_PLUS:
                    coords = SwissGridPlusCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.GAUSS_KRUEGER:
                    coords = GaussKruegerCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.LAMBERT:
                    coords = LambertCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.DUTCH_GRID:
                    coords = DutchGridCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.MAIDENHEAD:
                    coords = MaidenheadCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.MERCATOR:
                    coords = MercatorCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.NATURAL_AREA_CODE:
                    coords = NaturalAreaCodeCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.GEOHASH:
                    coords = GeohashCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.GEOHEX:
                    coords = GeoHexCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.GEO3X3:
                    coords = Geo3x3Coordinate.parse(input);
                    break;
                  case CoordinateFormatKey.OPEN_LOCATION_CODE:
                    coords = OpenLocationCodeCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.QUADTREE:
                    coords = QuadtreeCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
                    coords = ReverseWherigoWaldmeisterCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.REVERSE_WIG_DAY1976:
                    coords = ReverseWherigoDay1976Coordinate.parse(input);
                    break;
                  case CoordinateFormatKey.SLIPPY_MAP:
                    coords = SlippyMapCoordinate.parse(input);
                    break;
                  case CoordinateFormatKey.MAKANEY:
                    coords = MakaneyCoordinate.parse(input);
                    break;
                  default:
                    coords = null;
                }
                var latlng = coords?.toLatLng();
                if (latlng == null) return null;

                return formatCoordOutput(latlng, defaultCoordinateFormat, defaultEllipsoid);
              } catch (e) {}
              return null;
            },
            options: options);
  @override
  State<StatefulWidget> createState() => _MultiDecoderToolCoordinateFormatsState();
}

class _MultiDecoderToolCoordinateFormatsState extends State<MultiDecoderToolCoordinateFormats> {
  @override
  Widget build(BuildContext context) {
    return createMultiDecoderToolConfiguration(context, {
      MDT_COORDINATEFORMATS_OPTION_FORMAT: GCWDropDown<CoordinateFormatKey>(
        value: _getCoordinateFormatKey(widget.options, MDT_COORDINATEFORMATS_OPTION_FORMAT),
        onChanged: (newValue) {
          setState(() {
            widget.options[MDT_COORDINATEFORMATS_OPTION_FORMAT] =
                coordinateFormatDefinitionByKey(newValue).persistenceKey;
          });
        },
        items:
            allCoordinateFormatMetadata.where((format) => format.type != CoordinateFormatKey.SLIPPY_MAP).map((format) {
          return GCWDropDownMenuItem<CoordinateFormatKey>(
            value: format.type,
            child: i18n(context, format.name, ifTranslationNotExists: format.name),
          );
        }).toList(),
      ),
    });
  }
}

CoordinateFormatKey _getCoordinateFormatKey(Map<String, Object?> options, String option) {
  var key = checkStringFormatOrDefaultOption(
      MDT_INTERNALNAMES_COORDINATEFORMATS, options, MDT_COORDINATEFORMATS_OPTION_FORMAT);
  var formatKey = coordinateFormatDefinitionByPersistenceKey(key)?.type;
  if (formatKey != null) return formatKey;

  key = toStringOrNull(getDefaultValue(MDT_INTERNALNAMES_COORDINATEFORMATS, MDT_COORDINATEFORMATS_OPTION_FORMAT)) ?? '';
  return coordinateFormatDefinitionByPersistenceKey(key)?.type ?? defaultCoordinateFormat.type;
}
