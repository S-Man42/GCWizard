import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_metadata.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_text_formatter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/format_converter_w3w/logic/format_converter_w3w.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';

import 'package:latlong2/latlong.dart';
import 'package:prefs/prefs.dart';

class FormatConverterW3W extends StatefulWidget {
  const FormatConverterW3W({Key? key}) : super(key: key);

  @override
  FormatConverterW3WState createState() => FormatConverterW3WState();
}

class FormatConverterW3WState extends State<FormatConverterW3W> {
  LatLng _currentCoordsLatLng = LatLng(0.0, 0.0);
  String _currentCoordsW3W = '';
  W3WResults _currentW3wToCoordinates = W3WRESULTS_EMPTY;

  var _currentCoords = defaultBaseCoordinate;
  List<BaseCoordinate> _currentOutputs = [];

  var _currentMode = GCWSwitchPosition.right;
  var _currentOutputFormat = defaultCoordinateFormat;
  Widget _currentAllOutput = const GCWDefaultOutput();

  late TextEditingController _ControllerW1;
  late TextEditingController _ControllerW2;
  late TextEditingController _ControllerW3;

  CoordinateFormatKey _currentLanguage = defaultWhat3WordsType;

  var _currentW1 = '';
  var _currentW2 = '';
  var _currentW3 = '';

  final String _APIKey = Prefs.getString('coord_default_w3w_apikey');

  @override
  void initState() {
    super.initState();
    _ControllerW1 = TextEditingController(text: _currentW1.toString());
    _ControllerW2 = TextEditingController(text: _currentW2.toString());
    _ControllerW3 = TextEditingController(text: _currentW3.toString());
  }

  @override
  void dispose() {
    _ControllerW1.dispose();
    _ControllerW2.dispose();
    _ControllerW3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (_APIKeymissing())
            ? GCWOutput(
                title: i18n(context, 'coords_formatconverter_w3w_error'),
                child: i18n(context, 'coords_formatconverter_w3w_no_apikey'),
                suppressCopyButton: true)
            : Column(
                children: <Widget>[
                  GCWTwoOptionsSwitch(
                    onChanged: (value) {
                      setState(() {
                        _currentMode = value;
                      });
                    },
                    value: _currentMode,
                  ),
                  (_currentMode == GCWSwitchPosition.right) ? _buildDecode() : _buildEncode(),
                  GCWSubmitButton(
                    onPressed: () {
                      if (_currentMode == GCWSwitchPosition.right) {
                        _calculateLatLonFromW3W();
                      } else {
                        _calculateW3WFromLatLng();
                      }
                      setState(() {
                        _calculateOutput(context);
                      });
                    },
                  ),
                  _buildOutput()
                ],
              ),
      ],
    );
  }

  Widget _buildDecode() {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: DEFAULT_MARGIN),
              child: GCWTextField(
                  hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
                  controller: _ControllerW1,
                  onChanged: (ret) {
                    setState(() {
                      _currentW1 = ret;
                    });
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
              child: GCWTextField(
                  hintText: i18n(context, 'coords_formatconverter_w3w_w2'),
                  controller: _ControllerW2,
                  onChanged: (ret) {
                    setState(() {
                      _currentW2 = ret;
                    });
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWTextField(
                  hintText: i18n(context, 'coords_formatconverter_w3w_w3'),
                  controller: _ControllerW3,
                  onChanged: (ret) {
                    setState(() {
                      _currentW3 = ret;
                    });
                  }),
            ),
          ),
        ],
      ),
      GCWDropDown<CoordinateFormatKey>(
        value: _currentLanguage,
        items: WHAT3WORDS_LANGUAGE.entries.map((mode) {
          return GCWDropDownMenuItem(
            value: mode.key,
            child: i18n(context, mode.value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _currentLanguage = value;
          });
        },
      ),
      GCWTextDivider(
        text: i18n(context, 'coords_output_format'),
      ),
      _GCWCoordsFormatSelectorAll(
        format: _currentOutputFormat,
        onChanged: (CoordinateFormat value) {
          setState(() {
            if (value.type == CoordinateFormatKey.ALL) {
              _currentOutputs = [];
              _currentAllOutput = const GCWDefaultOutput();
            }
            _currentOutputFormat = value;
          });
        },
      ),
    ]);
  }

  Widget _buildEncode() {
    return Column(children: <Widget>[
      GCWCoords(
        title: i18n(context, 'coords_formatconverter_coord'),
        coordsFormat: _currentCoords.format,
        onChanged: (BaseCoordinate ret) {
          setState(() {
            if (ret.toLatLng() != null) {
              _currentCoords = ret;
            }
          });
        },
      ),
      GCWDropDown<CoordinateFormatKey>(
        value: _currentLanguage,
        items: WHAT3WORDS_LANGUAGE.entries.map((mode) {
          return GCWDropDownMenuItem(
            value: mode.key,
            child: i18n(context, mode.value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _currentLanguage = value;
          });
        },
      ),
    ]);
  }

  Future<void> _exportCoordinates(
      BuildContext context, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) async {
    showCoordinatesExportDialog(context, points, polylines);
  }

  void _openInMap(List<GCWMapPoint> points, List<GCWMapPolyline> polylines) {
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute<GCWTool>(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(points),
                  polylines: List<GCWMapPolyline>.from(polylines),
                  isEditable: false, // false: open in Map
                  // true:  open in FreeMap
                ),
                id: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  List<GCWMapPoint> _center() {
    return [
      GCWMapPoint(
          uuid: 'Original Point ' + _currentW1 + '//' + _currentW2 + '//' + _currentW3,
          markerText: _currentW1 + '//' + _currentW2 + '//' + _currentW3,
          point: _currentW3wToCoordinates.coordinates,
          color: Colors.red),
    ];
  }

  List<GCWMapPolyline> _square() {
    List<GCWMapPoint> polyline = [];
    polyline.add(GCWMapPoint(
        uuid: 'Original Point ' + 'NE',
        markerText: 'NE',
        point: _currentW3wToCoordinates.square_ne,
        color: Colors.black));
    polyline.add(GCWMapPoint(
        uuid: 'Original Point ' + 'NW',
        markerText: 'NW',
        point: LatLng(_currentW3wToCoordinates.square_ne.latitude, _currentW3wToCoordinates.square_sw.longitude),
        color: Colors.black));
    polyline.add(GCWMapPoint(
        uuid: 'Original Point ' + 'SW',
        markerText: 'SW',
        point: _currentW3wToCoordinates.square_sw,
        color: Colors.black));
    polyline.add(GCWMapPoint(
        uuid: 'Original Point ' + 'SE',
        markerText: 'SE',
        point: LatLng(_currentW3wToCoordinates.square_sw.latitude, _currentW3wToCoordinates.square_ne.longitude),
        color: Colors.black));
    polyline.add(GCWMapPoint(
        uuid: 'Original Point ' + 'NE',
        markerText: 'NE',
        point: _currentW3wToCoordinates.square_ne,
        color: Colors.black));
    return [
      GCWMapPolyline(uuid: _currentW1 + '//' + _currentW2 + '//' + _currentW3, points: polyline, color: Colors.black)
    ];
  }

  Widget _outputW3WToCoordinates() {
    return GCWDefaultOutput(
      trailing: Row(children: <Widget>[
        GCWIconButton(
          icon: Icons.save,
          size: IconButtonSize.SMALL,
          iconColor: themeColors().mainFont(),
          onPressed: () {
            _exportCoordinates(
              context,
              _center(),
              _square(),
            );
          },
        ),
        GCWIconButton(
          icon: Icons.my_location,
          size: IconButtonSize.SMALL,
          iconColor: themeColors().mainFont(),
          onPressed: () {
            _openInMap(
              _center(),
              _square(),
            );
          },
        ),
      ]),
      child: GCWColumnedMultilineOutput(
        data: [
          [
            i18n(context, 'coords_formatconverter_w3w_square'),
            i18n(context, 'coords_formatconverter_w3w_square_ne'),
            formatCoordOutput(LatLng(_currentW3wToCoordinates.square_ne.latitude, _currentW3wToCoordinates.square_ne.longitude),
                defaultCoordinateFormat, defaultEllipsoid)
          ],
          [
            '',
            i18n(context, 'coords_formatconverter_w3w_square_sw'),
            formatCoordOutput(LatLng(_currentW3wToCoordinates.square_sw.latitude, _currentW3wToCoordinates.square_sw.longitude),
                defaultCoordinateFormat, defaultEllipsoid)
          ],
          [
            i18n(context, 'coords_formatconverter_w3w_location'),
            '',
            formatCoordOutput(LatLng(_currentW3wToCoordinates.coordinates.latitude, _currentW3wToCoordinates.coordinates.longitude),
                defaultCoordinateFormat, defaultEllipsoid)
          ],
          [i18n(context, 'coords_formatconverter_w3w_country'), '', _currentW3wToCoordinates.country],
          [i18n(context, 'coords_formatconverter_w3w_nearest_place'), '', _currentW3wToCoordinates.nearestPlace],
          [i18n(context, 'coords_formatconverter_w3w_locale'), '', _currentW3wToCoordinates.locale],
          [i18n(context, 'coords_formatconverter_w3w_language'), '', _currentW3wToCoordinates.language],
          [i18n(context, 'coords_formatconverter_w3w_map'), '', _currentW3wToCoordinates.map],
        ],
        flexValues: [2,1,3],
      ),
    );
  }

  Widget _outputCoordinatesToW3W() {
    return GCWDefaultOutput(
      trailing: Row(children: <Widget>[
        GCWIconButton(
          icon: Icons.save,
          size: IconButtonSize.SMALL,
          iconColor: themeColors().mainFont(),
          onPressed: () {
            _exportCoordinates(
              context,
              _center(),
              _square(),
            );
          },
        ),
        GCWIconButton(
          icon: Icons.my_location,
          size: IconButtonSize.SMALL,
          iconColor: themeColors().mainFont(),
          onPressed: () {
            _openInMap(
              _center(),
              _square(),
            );
          },
        ),
      ]),
      child: GCWColumnedMultilineOutput(
        data: [
          [i18n(context, 'coords_formatconverter_w3w_words'), '', _currentW3wToCoordinates.words.toUpperCase()],
          [
            i18n(context, 'coords_formatconverter_w3w_square'),
            i18n(context, 'coords_formatconverter_w3w_square_ne'),
            formatCoordOutput(LatLng(_currentW3wToCoordinates.square_ne.latitude, _currentW3wToCoordinates.square_ne.longitude),
                defaultCoordinateFormat, defaultEllipsoid)
          ],
          [
            '',
            i18n(context, 'coords_formatconverter_w3w_square_sw'),
            formatCoordOutput(LatLng(_currentW3wToCoordinates.square_sw.latitude, _currentW3wToCoordinates.square_sw.longitude),
                defaultCoordinateFormat, defaultEllipsoid)
          ],
          [
            i18n(context, 'coords_formatconverter_w3w_location'),
            '',
            formatCoordOutput(LatLng(_currentW3wToCoordinates.coordinates.latitude, _currentW3wToCoordinates.coordinates.longitude),
                defaultCoordinateFormat, defaultEllipsoid)
          ],
          [i18n(context, 'coords_formatconverter_w3w_country'), '', _currentW3wToCoordinates.country],
          [i18n(context, 'coords_formatconverter_w3w_nearest_place'), '', _currentW3wToCoordinates.nearestPlace],
          [i18n(context, 'coords_formatconverter_w3w_locale'), '', _currentW3wToCoordinates.locale],
          [i18n(context, 'coords_formatconverter_w3w_language'), '', _currentW3wToCoordinates.language],
          [i18n(context, 'coords_formatconverter_w3w_map'), '', _currentW3wToCoordinates.map],
        ],
        flexValues: [2,1,3],
      ),
    );
  }

  Widget _buildOutput() {
    if (_currentOutputFormat.type == CoordinateFormatKey.ALL) {
      return _currentAllOutput;
    } else {
       if (_currentMode == GCWSwitchPosition.right) {
         return _outputW3WToCoordinates();
       } else {
         return _outputCoordinatesToW3W();
       }
    }
  }

  void _calculateOutput(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.right) {
      // W3W to LatLng
      if (_currentOutputFormat.type == CoordinateFormatKey.ALL) {
        _currentAllOutput = _calculateAllOutput(context);
      } else {
        _currentOutputs = [buildCoordinate(_currentOutputFormat, _currentCoordsLatLng)];
      }
    }
  }

  Widget _calculateAllOutput(BuildContext context) {
    var ellipsoid = defaultEllipsoid;
    List<List<String>> children = [];
    if (_currentMode == GCWSwitchPosition.right) {
      children = allCoordinateFormatMetadata.map((CoordinateFormatMetadata coordFormat) {
        var format = CoordinateFormat(coordFormat.type);
        var name = i18n(context, coordFormat.name, ifTranslationNotExists: coordFormat.name);
        if (format.subtype != null) {
          var subtypeMetadata = coordinateFormatMetadataByKey(format.subtype!);
          var subtypeName = i18n(context, subtypeMetadata.name);
          if (subtypeName.isNotEmpty) {
            name += '\n' + subtypeName;
          }
        }

        return [name, formatCoordOutput(_currentCoordsLatLng, format, ellipsoid)];
      }).toList();
    } else {
      children = _currentCoords.toLatLng() == null
          ? []
          : allCoordinateFormatMetadata.map((CoordinateFormatMetadata coordFormat) {
              var format = CoordinateFormat(coordFormat.type);
              var name = i18n(context, coordFormat.name, ifTranslationNotExists: coordFormat.name);
              if (format.subtype != null) {
                var subtypeMetadata = coordinateFormatMetadataByKey(format.subtype!);
                var subtypeName = i18n(context, subtypeMetadata.name);
                if (subtypeName.isNotEmpty) {
                  name += '\n' + subtypeName;
                }
              }

              return [name, formatCoordOutput(_currentCoords.toLatLng()!, format, ellipsoid)];
            }).toList();
    }
    return GCWDefaultOutput(child: GCWColumnedMultilineOutput(data: children));
  }

  bool _APIKeymissing() {
    return (_APIKey == '');
  }

  void _calculateLatLonFromW3W() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<W3WResults>(
              isolatedFunction: convertLatLonFromW3Wasync,
              parameter: _buildJobDataLatLonFromW3W,
              onReady: (data) => _showW3WToCoordinatesResults(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildJobDataLatLonFromW3W() async {
    return GCWAsyncExecuterParameters(LatLngFromW3WJobData(_currentW1 + '.' + _currentW2 + '.' + _currentW3, _APIKey));
  }

  void _showW3WToCoordinatesResults(W3WResults output) {
    _currentCoordsLatLng = output.coordinates;
    _currentCoordsW3W = output.words.toUpperCase();
    _currentW3wToCoordinates = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _calculateOutput(context);
      });
    });
  }

  void _calculateW3WFromLatLng() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<W3WResults>(
              isolatedFunction: convertW3WFromLatLngAsync,
              parameter: _buildJobDataW3WFromLatLng,
              onReady: (data) => _showW3WToCoordinatesResults(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildJobDataW3WFromLatLng() async {
    return GCWAsyncExecuterParameters(W3WFromLatLngJobData(_currentCoords.toLatLng()!, _currentLanguage, _APIKey));
  }

}

class _GCWCoordsFormatSelectorAll extends GCWCoordsFormatSelector {
  const _GCWCoordsFormatSelectorAll(
      {Key? key, required void Function(CoordinateFormat) onChanged, required CoordinateFormat format})
      : super(key: key, onChanged: onChanged, format: format);

  @override
  List<GCWDropDownMenuItem<CoordinateFormatKey>> getDropDownItems(BuildContext context) {
    var items = super.getDropDownItems(context);
    items.insert(
        0,
        GCWDropDownMenuItem(
            value: CoordinateFormatKey.ALL, child: i18n(context, 'coords_formatconverter_all_formats')));
    return items;
  }
}
