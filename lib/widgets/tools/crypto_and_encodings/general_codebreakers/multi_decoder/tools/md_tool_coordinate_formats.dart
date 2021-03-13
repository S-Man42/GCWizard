import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dmm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dms.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohex.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/natural_area_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/xyz.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:latlong/latlong.dart';

const MDT_INTERNALNAMES_COORDINATEFORMATS = 'multidecoder_tool_coordinateformats_title';
const MDT_COORDINATEFORMATS_OPTION_FORMAT = 'multidecoder_tool_coordinateformats_option_format';

class MultiDecoderToolCoordinateFormats extends GCWMultiDecoderTool {
  MultiDecoderToolCoordinateFormats({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_COORDINATEFORMATS,
            onDecode: (String input) {
              input = input.replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
              LatLng coords;
              try {
                switch (options[MDT_COORDINATEFORMATS_OPTION_FORMAT]) {
                  case keyCoordsDEC:
                    coords = parseDEC(input, wholeString: true);
                    break;
                  case keyCoordsDMM:
                    coords = parseDMM(input, wholeString: true);
                    break;
                  case keyCoordsDMS:
                    coords = parseDMS(input, wholeString: true);
                    break;
                  case keyCoordsUTM:
                    coords = parseUTM(input, defaultEllipsoid());
                    break;
                  case keyCoordsMGRS:
                    coords = parseMGRS(input, defaultEllipsoid());
                    break;
                  case keyCoordsXYZ:
                    coords = parseXYZ(input, defaultEllipsoid());
                    break;
                  case keyCoordsSwissGrid:
                    coords = parseSwissGrid(input, defaultEllipsoid());
                    break;
                  case keyCoordsSwissGridPlus:
                    coords = parseSwissGrid(input, defaultEllipsoid(), isSwissGridPlus: true);
                    break;
                  case keyCoordsGaussKrueger:
                    coords = parseGaussKrueger(input, defaultEllipsoid());
                    break;
                  case keyCoordsMaidenhead:
                    coords = maidenheadToLatLon(input);
                    break;
                  case keyCoordsMercator:
                    coords = parseMercator(input, defaultEllipsoid());
                    break;
                  case keyCoordsNaturalAreaCode:
                    coords = parseNaturalAreaCode(input);
                    break;
                  case keyCoordsGeohash:
                    coords = geohashToLatLon(input);
                    break;
                  case keyCoordsGeoHex:
                    coords = geoHexToLatLon(input);
                    break;
                  case keyCoordsOpenLocationCode:
                    coords = openLocationCodeToLatLon(input);
                    break;
                  case keyCoordsQuadtree:
                    coords = parseQuadtree(input);
                    break;
                  case keyCoordsReverseWhereIGoWaldmeister:
                    coords = parseWaldmeister(input);
                    break;
                  case keyCoordsSlippyMap:
                    coords = parseSlippyMap(input);
                    break;
                }
              } catch (e) {}

              if (coords == null) return null;

              return formatCoordOutput(coords, defaultCoordFormat(), defaultEllipsoid());
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_COORDINATEFORMATS_OPTION_FORMAT: GCWStatefulDropDownButton(
                value: options[MDT_COORDINATEFORMATS_OPTION_FORMAT],
                onChanged: (newValue) {
                  options[MDT_COORDINATEFORMATS_OPTION_FORMAT] = newValue;
                },
                items: allCoordFormats.where((format) => format.key != keyCoordsSlippyMap).map((format) {
                  return GCWDropDownMenuItem(
                    value: format.key,
                    child: i18n(context, format.name) ?? format.name,
                  );
                }).toList(),
              ),
            }));
}
