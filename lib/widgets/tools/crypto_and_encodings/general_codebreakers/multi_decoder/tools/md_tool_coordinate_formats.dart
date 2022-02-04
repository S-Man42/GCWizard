import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:latlong2/latlong.dart';

const MDT_INTERNALNAMES_COORDINATEFORMATS = 'multidecoder_tool_coordinateformats_title';
const MDT_COORDINATEFORMATS_OPTION_FORMAT = 'multidecoder_tool_coordinateformats_option_format';

class MultiDecoderToolCoordinateFormats extends GCWMultiDecoderTool {
  MultiDecoderToolCoordinateFormats({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
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
                  case keyCoordsDEC:
                    coords = DEC.parse(input, wholeString: true)?.toLatLng();
                    break;
                  case keyCoordsDMM:
                    coords = DMM.parse(input, wholeString: true)?.toLatLng();
                    break;
                  case keyCoordsDMS:
                    coords = DMS.parse(input, wholeString: true)?.toLatLng();
                    break;
                  case keyCoordsUTM:
                    coords = UTMREF.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsMGRS:
                    coords = MGRS.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsXYZ:
                    coords = XYZ.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsSwissGrid:
                    coords = SwissGrid.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsSwissGridPlus:
                    coords = SwissGridPlus.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsGaussKrueger:
                    coords = GaussKrueger.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsDutchGrid:
                    coords = DutchGrid.parse(input)?.toLatLng();
                    break;
                  case keyCoordsMaidenhead:
                    coords = Maidenhead.parse(input)?.toLatLng();
                    break;
                  case keyCoordsMercator:
                    coords = Mercator.parse(input)?.toLatLng(ells: defaultEllipsoid());
                    break;
                  case keyCoordsNaturalAreaCode:
                    coords = NaturalAreaCode.parse(input)?.toLatLng();
                    break;
                  case keyCoordsGeohash:
                    coords = Geohash.parse(input)?.toLatLng();
                    break;
                  case keyCoordsGeoHex:
                    coords = GeoHex.parse(input)?.toLatLng();
                    break;
                  case keyCoordsGeo3x3:
                    coords = Geo3x3.parse(input)?.toLatLng();
                    break;
                  case keyCoordsOpenLocationCode:
                    coords = OpenLocationCode.parse(input)?.toLatLng();
                    break;
                  case keyCoordsQuadtree:
                    coords = Quadtree.parse(input)?.toLatLng();
                    break;
                  case keyCoordsReverseWherigoWaldmeister:
                    coords = Waldmeister.parse(input)?.toLatLng();
                    break;
                  case keyCoordsSlippyMap:
                    coords = SlippyMap.parse(input)?.toLatLng();
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
