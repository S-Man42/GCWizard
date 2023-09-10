import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_output/gcw_coords_output.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
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
            child: GCWTextField(
                hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
                controller: _ControllerW1,
                onChanged: (ret) {
                  setState(() {
                    _currentW1 = ret;
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWTextField(
                hintText: i18n(context, 'coords_formatconverter_w3w_w2'),
                controller: _ControllerW2,
                onChanged: (ret) {
                  setState(() {
                    _currentW2 = ret;
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWTextField(
                hintText: i18n(context, 'coords_formatconverter_w3w_w3'),
                controller: _ControllerW3,
                onChanged: (ret) {
                  setState(() {
                    _currentW3 = ret;
                  });
                }),
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

  Widget _buildOutput() {
    if (_currentOutputFormat.type == CoordinateFormatKey.ALL) {
      return _currentAllOutput;
    } else {
      if (_currentMode == GCWSwitchPosition.right) {
        return GCWCoordsOutput(
            outputs: _currentOutputs,
            points: _currentOutputs.map((element) {
              return GCWMapPoint(point: element.toLatLng()!, coordinateFormat: _currentOutputFormat);
            }).toList());
      } else {
        return GCWOutputText(
          text: _currentCoordsW3W,
        );
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
            child: GCWAsyncExecuter<LatLng>(
              isolatedFunction: convertLatLonFromW3Wasync,
              parameter: _buildJobDataLatLonFromW3W,
              onReady: (data) => _showLatLon(data),
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


  void _showLatLon(LatLng output) {
    _currentCoordsLatLng = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {_calculateOutput(context);});
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
            child: GCWAsyncExecuter<String>(
              isolatedFunction: convertW3WFromLatLngAsync,
              parameter: _buildJobDataW3WFromLatLng,
              onReady: (data) => _showW3W(data),
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

  void _showW3W(String output) {
    _currentCoordsW3W = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {_calculateOutput(context);});
    });
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
