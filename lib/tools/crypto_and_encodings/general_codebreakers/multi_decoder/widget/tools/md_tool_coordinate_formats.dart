import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
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
  MultiDecoderToolCoordinateFormats({
    Key? key,
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
                    coords = DEC.parse(input, wholeString: true);
                    break;
                  case CoordinateFormatKey.DMM:
                    coords = DMM.parse(input, wholeString: true);
                    break;
                  case CoordinateFormatKey.DMS:
                    coords = DMS.parse(input, wholeString: true);
                    break;
                  case CoordinateFormatKey.UTM:
                    coords = UTMREF.parse(input);
                    break;
                  case CoordinateFormatKey.MGRS:
                    coords = MGRS.parse(input);
                    break;
                  case CoordinateFormatKey.XYZ:
                    coords = XYZ.parse(input);
                    break;
                  case CoordinateFormatKey.SWISS_GRID:
                    coords = SwissGrid.parse(input);
                    break;
                  case CoordinateFormatKey.SWISS_GRID_PLUS:
                    coords = SwissGridPlus.parse(input);
                    break;
                  case CoordinateFormatKey.GAUSS_KRUEGER:
                    coords = GaussKrueger.parse(input);
                    break;
                  case CoordinateFormatKey.LAMBERT:
                    coords = Lambert.parse(input);
                    break;
                  case CoordinateFormatKey.DUTCH_GRID:
                    coords = DutchGrid.parse(input);
                    break;
                  case CoordinateFormatKey.MAIDENHEAD:
                    coords = Maidenhead.parse(input);
                    break;
                  case CoordinateFormatKey.MERCATOR:
                    coords = Mercator.parse(input);
                    break;
                  case CoordinateFormatKey.NATURAL_AREA_CODE:
                    coords = NaturalAreaCode.parse(input);
                    break;
                  case CoordinateFormatKey.GEOHASH:
                    coords = Geohash.parse(input);
                    break;
                  case CoordinateFormatKey.GEOHEX:
                    coords = GeoHex.parse(input);
                    break;
                  case CoordinateFormatKey.GEO3X3:
                    coords = Geo3x3.parse(input);
                    break;
                  case CoordinateFormatKey.OPEN_LOCATION_CODE:
                    coords = OpenLocationCode.parse(input);
                    break;
                  case CoordinateFormatKey.QUADTREE:
                    coords = Quadtree.parse(input);
                    break;
                  case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
                    coords = ReverseWherigoWaldmeister.parse(input);
                    break;
                  case CoordinateFormatKey.REVERSE_WIG_DAY1976:
                    coords = ReverseWherigoDay1976.parse(input);
                    break;
                  case CoordinateFormatKey.SLIPPY_MAP:
                    coords = SlippyMap.parse(input);
                    break;
                  case CoordinateFormatKey.MAKANEY:
                    coords = Makaney.parse(input);
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
    return createMultiDecoderToolConfiguration(
        context, {
      MDT_COORDINATEFORMATS_OPTION_FORMAT: GCWDropDown<CoordinateFormatKey>(
        value: _getCoordinateFormatKey(widget.options, MDT_COORDINATEFORMATS_OPTION_FORMAT),
        onChanged: (newValue) {
          setState(() {
            widget.options[MDT_COORDINATEFORMATS_OPTION_FORMAT] = coordinateFormatMetadataByKey(newValue).persistenceKey;
          });

        },
        items: allCoordinateFormatMetadata.where((format) => format.type != CoordinateFormatKey.SLIPPY_MAP).map((format) {
          return GCWDropDownMenuItem<CoordinateFormatKey>(
            value: format.type,
            child: i18n(context, format.name, ifTranslationNotExists: format.name),
          );
        }).toList(),
      ),
    }
    );
  }
}

CoordinateFormatKey _getCoordinateFormatKey(Map<String, Object?> options, String option) {
  var key = checkStringFormatOrDefaultOption(MDT_INTERNALNAMES_COORDINATEFORMATS, options, MDT_COORDINATEFORMATS_OPTION_FORMAT);
  var formatKey = coordinateFormatMetadataByPersistenceKey(key)?.type;
  if (formatKey != null) return formatKey;

  key = toStringOrNull(getDefaultValue(MDT_INTERNALNAMES_COORDINATEFORMATS, MDT_COORDINATEFORMATS_OPTION_FORMAT)) ?? '';
  return coordinateFormatMetadataByPersistenceKey(key)?.type ?? defaultCoordinateFormat.type;
}