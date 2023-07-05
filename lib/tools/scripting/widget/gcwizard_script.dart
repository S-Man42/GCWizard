import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_code_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

import 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

class GCWizardScript extends StatefulWidget {
  const GCWizardScript({Key? key}) : super(key: key);

  @override
  GCWizardScriptState createState() => GCWizardScriptState();
}

class GCWizardScriptState extends State<GCWizardScript> {
  late TextEditingController _programController;
  late TextEditingController _inputController;

  String _currentProgram = '';
  String _currentInput = '';
  String _currentScriptOutput = '';

  GCWizardScriptOutput _currentOutput = GCWizardScriptOutput.empty();

  Uint8List _outGraphicData = Uint8List.fromList([]);
  bool _loadFile = false;

  bool _loadCoords = false;
  var _currentCoords = defaultBaseCoordinate;

  @override
  void initState() {
    super.initState();
    _programController = TextEditingController(text: _currentProgram);
    _inputController = TextEditingController(text: _currentInput);

    _programController = CodeController(
        text: _currentProgram,
        language: getLanguage(CodeHighlightingLanguage.BASIC),
        stringMap: _buildHiglightMap(),
        //patternMap: _buildHiglightMap()
    );
  }

  @override
  void dispose() {
    _programController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            if (_loadFile)
              GCWOpenFile(
                onLoaded: (_file) {
                  if (_file == null) {
                    showToast(i18n(context, 'common_loadfile_exception_notloaded'));
                    return;
                  }

                  _currentProgram = String.fromCharCodes(_file.bytes);
                  _programController.text = _currentProgram;
                  setState(() {});

                  _loadFile = !_loadFile;
                },
              ),
            if (_loadCoords)
              GCWCoords(
                title: i18n(context, 'gcwizard_script_coords'),
                coordsFormat: _currentCoords.format,
                onChanged: (ret) {
                  setState(() {
                    _currentCoords = ret;
                  });
                },
              ),
            GCWCodeTextField(
              style: gcwMonotypeTextStyle(),
              lineNumbers: true,
              lineNumberStyle: const GCWCodeTextFieldLineNumberStyle(width: 48),
              controller: _programController,
              // hintText: i18n(context, 'gcwizard_script_hint_program'),
              language: CodeHighlightingLanguage.BASIC,
              readOnly: false,
              onChanged: (text) {
                setState(() {
                  _currentProgram = text;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GCWButton(
              text: i18n(context, 'gcwizard_script_interpret'),
              onPressed: () {
                _currentInput = '';
                _currentOutput.continueState = null;
                _interpretGCWScriptAsync();
                setState(() {
                  if (_currentOutput.Graphic.GCWizardScriptScreenMode == GCWizardSCript_SCREENMODE.GRAPHIC ||
                      _currentOutput.Graphic.GCWizardScriptScreenMode == GCWizardSCript_SCREENMODE.TEXTGRAPHIC) {
                    _createImage(_currentOutput.Graphic).then((value) {
                      setState(() {
                        _outGraphicData = value;
                      });
                    });
                  }
                });
              },
            ),
            GCWButton(
              text: i18n(context, 'gcwizard_script_load'),
              onPressed: () {
                setState(() {
                  _loadFile = !_loadFile;
                });
              },
            ),
            GCWButton(
              text: i18n(context, 'gcwizard_script_save'),
              onPressed: () {
                _exportFile(context, Uint8List.fromList(_currentProgram.codeUnits), GCWizardScriptFileType.PROGRAM);
              },
            ),
            GCWButton(
              text: i18n(context, 'gcwizard_script_clear'),
              onPressed: () {
                setState(() {
                  _currentOutput = GCWizardScriptOutput.empty();
                  _currentScriptOutput = '';
                });
              },
            ),
            GCWButton(
              text: i18n(context, 'gcwizard_script_coords'),
              onPressed: () {
                setState(() {
                  _loadCoords = !_loadCoords;
                });
              },
            ),
          ],
        ),
        _buildOutput(context),

      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_currentOutput.Graphic.GCWizardScriptScreenMode == GCWizardSCript_SCREENMODE.GRAPHIC ||
            _currentOutput.Graphic.GCWizardScriptScreenMode == GCWizardSCript_SCREENMODE.TEXTGRAPHIC)
          GCWDefaultOutput(
            child: GCWImageView(
              imageData: GCWImageViewData(GCWFile(bytes: _outGraphicData)),
              suppressOpenInTool: const {
                GCWImageViewOpenInTools.METADATA,
                GCWImageViewOpenInTools.HIDDENDATA,
                GCWImageViewOpenInTools.HEXVIEW
              },
            ),
          ),
        if (_currentOutput.Graphic.GCWizardScriptScreenMode == GCWizardSCript_SCREENMODE.TEXT ||
            _currentOutput.Graphic.GCWizardScriptScreenMode == GCWizardSCript_SCREENMODE.TEXTGRAPHIC)
          GCWDefaultOutput(
            trailing: GCWIconButton(
              icon: Icons.save,
              size: IconButtonSize.SMALL,
              onPressed: () {
                _exportFile(context, Uint8List.fromList(_currentScriptOutput.codeUnits), GCWizardScriptFileType.OUTPUT);
              },
            ),
            child: GCWOutputText(
              style: gcwMonotypeTextStyle(),
              text: _currentScriptOutput,
              isMonotype: true,
            ),
          ),
        if (_currentOutput.Points.isNotEmpty)
          GCWDefaultOutput(
            trailing: Row(
              children: <Widget>[
                GCWIconButton(
                  icon: Icons.my_location,
                  size: IconButtonSize.SMALL,
                  onPressed: () {
                    _openInMap(_currentOutput.Points);
                  },
                ),
                GCWIconButton(
                  icon: Icons.save,
                  size: IconButtonSize.SMALL,
                  onPressed: () {
                    _exportCoordinates(context, _currentOutput.Points);
                  },
                ),
              ],
            ),
            child: GCWOutputText(
              style: gcwMonotypeTextStyle(),
              text: _buildWayPointList(_currentOutput.Points),
              isMonotype: true,
            ),
          ),
      ],
    );
  }

  String _buildOutputText(GCWizardScriptOutput output) {
    if (output.ErrorMessage.isNotEmpty) {
      return output.STDOUT +
          '\n' +
          i18n(context, output.ErrorMessage) +
          '\n' +
          i18n(context, 'gcwizard_script_error_position') +
          ' ' +
          output.ErrorPosition.toString() +
          '\n' +
          '=> ' +
          _printFaultyProgram(_currentProgram, output.ErrorPosition) +
          '\n' +
          '\n' +
          output.VariableDump;
    } else {
      return output.STDOUT;
    }
  }

  Future<GCWAsyncExecuterParameters?> _buildInterpreterJobData() async {
    return GCWAsyncExecuterParameters(InterpreterJobData(
        jobDataScript: _currentProgram,
        jobDataInput: _currentInput,
        jobDataCoords: _currentCoords.toLatLng()!,
        continueState: _currentOutput.continueState
    ));
  }

  void _showInterpreterOutputGWC(GCWizardScriptOutput output) {
    _currentOutput = output;
    var showInput = false;
    if (output.continueState != null) {

      if (output.BreakType == GCWizardScriptBreakType.INPUT) {
        _currentScriptOutput = _currentOutput.STDOUT;
        showInput = true;
      }
      else if (output.BreakType == GCWizardScriptBreakType.PRINT) {
        _currentScriptOutput = _currentOutput.STDOUT;
        _interpretGCWScriptAsync();
      }
    } else {
      _currentScriptOutput = _buildOutputText(_currentOutput);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (showInput) {
          _showDialogBox(context, output.continueState?.quotestr ?? '');
        }
      });
    });
  }

  void _interpretGCWScriptAsync() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<GCWizardScriptOutput>(
              isolatedFunction: interpretGCWScriptAsync,
              parameter: _buildInterpreterJobData,
              onReady: (data) => _showInterpreterOutputGWC(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  String _printFaultyProgram(String program, int position) {
    String result = '';
    if (position > 0) {
      result = (position < program.length) ? program[position - 1] : program[program.length - 1];
    }
    for (int i = position; (i < program.length && i < position + 6); i++) {
      result = result + program[i];
    }
    return result.replaceAll('\n', '↩') + '\n' + '   ^';
  }

  void _showDialogBox(BuildContext context, String text) {
    showGCWDialog(
        context,
        text,
        SizedBox(
          width: 300,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GCWTextField(
                autofocus: true,
                filled: true,
                onChanged: (text) {
                  _currentInput = text;
                },
              ),
            ],
          ),
        ),
        [
          GCWDialogButton(
            text: i18n(context, 'common_ok'),
            onPressed: () {
               if (_currentOutput.continueState != null) {
                 _currentOutput.continueState!.addInput(_currentInput);
                 _interpretGCWScriptAsync();
               }
            },
          )
        ],
        cancelButton: false);
  }

  void _exportFile(BuildContext context, Uint8List data, GCWizardScriptFileType fileType) async {
    bool value = false;
    String filename = '';

    switch (fileType) {
      case GCWizardScriptFileType.IMAGE:
        filename = buildFileNameWithDate('img_', FileType.PNG);
        break;
      case GCWizardScriptFileType.PROGRAM:
        filename = buildFileNameWithDate('prg_', null) + '.script';
        break;
      case GCWizardScriptFileType.OUTPUT:
        filename = buildFileNameWithDate('out_', null) + '.out';
        break;
      case GCWizardScriptFileType.WAYPOINT:
        filename = buildFileNameWithDate('out_', null) + '.wpt';
        break;
    }
    value = await saveByteDataToFile(context, data, filename);
    if (value) showExportedFileDialog(context);
  }

  Future<bool> _exportCoordinates(BuildContext context, List<GCWMapPoint> points) async {
    if (points.isNotEmpty) {
      showCoordinatesExportDialog(context, points, []);
    }
    return false;
  }

  void _openInMap(List<GCWMapPoint> points,) {
    Navigator.push(
        context,
        MaterialPageRoute<GCWTool>(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(points),
                  isEditable: false, // false: open in Map
                  // true:  open in FreeMap
                ),
                id: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  String _buildWayPointList(List<GCWMapPoint> points) {
    List<String> result = [];
    for (GCWMapPoint point in points) {
      result.add(
          point.point.latitude.toStringAsFixed(6).padLeft(10) + point.point.longitude.toStringAsFixed(6).padLeft(12));
    }
    return result.join('\n');
  }

  Future<Uint8List> _createImage(GraphicState graphic) async {
    double width = graphic.GCWizardSCriptScreenWidth.toDouble();
    double height = graphic.GCWizardSCriptScreenHeight.toDouble();
    double pointsize = 1.0;
    List<String> graphicCommand = [];

    final canvasRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = pointsize.toDouble();

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
    for (String command in graphic.graphics) {
      graphicCommand = command.split(' ');
      switch (graphicCommand[0]) {
        case 'TEXT': // TEXT(T,X,Y,S)
          final textStyle = ui.TextStyle(
            color: paint.color,
            fontSize: double.parse(graphicCommand[4]),
          );
          final paragraphStyle = ui.ParagraphStyle(
            textDirection: ui.TextDirection.ltr,
          );
          final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
            ..pushStyle(textStyle)
            ..addText(graphicCommand[1].replaceAll('⟳', ' '));
          const constraints = ui.ParagraphConstraints(width: 300);
          final paragraph = paragraphBuilder.build();
          paragraph.layout(constraints);
          canvas.drawParagraph(paragraph, Offset(double.parse(graphicCommand[2]), double.parse(graphicCommand[3])));
          break;
        case 'BOX':
          canvas.drawRect(
              Rect.fromLTRB(double.parse(graphicCommand[1]), double.parse(graphicCommand[2]),
                  double.parse(graphicCommand[3]), double.parse(graphicCommand[4])),
              paint);
          break;
        case 'OVAL':
          canvas.drawOval(
              Rect.fromLTRB(double.parse(graphicCommand[1]), double.parse(graphicCommand[2]),
                  double.parse(graphicCommand[3]), double.parse(graphicCommand[4])),
              paint);
          break;
        case 'CIRCLE':
          canvas.drawCircle(Offset(double.parse(graphicCommand[1]), double.parse(graphicCommand[2])),
              double.parse(graphicCommand[3]), paint);
          break;
        case 'LINE':
          canvas.drawLine(Offset(double.parse(graphicCommand[1]), double.parse(graphicCommand[2])),
              Offset(double.parse(graphicCommand[3]), double.parse(graphicCommand[4])), paint);
          break;
        case 'POINT':
          canvas.drawLine(Offset(double.parse(graphicCommand[1]), double.parse(graphicCommand[2])),
              Offset(double.parse(graphicCommand[1]), double.parse(graphicCommand[2])), paint);
          break;
        case 'COLOR':
          paint.color = Color.fromARGB(
            255,
            int.parse(graphicCommand[1]),
            int.parse(graphicCommand[2]),
            int.parse(graphicCommand[3]),
          );
          break;
        case 'ARC':
          canvas.drawArc(
              Rect.fromLTRB(
                  double.parse(graphicCommand[1]) - double.parse(graphicCommand[3]),
                  double.parse(graphicCommand[2]) - double.parse(graphicCommand[3]),
                  double.parse(graphicCommand[1]) + double.parse(graphicCommand[3]),
                  double.parse(graphicCommand[2]) + double.parse(graphicCommand[3])),
              double.parse(graphicCommand[4]),
              double.parse(graphicCommand[5]),
              false,
              paint);
          break;
        case 'PIE':
          canvas.drawArc(
              Rect.fromLTRB(
                  double.parse(graphicCommand[1]) - double.parse(graphicCommand[3]),
                  double.parse(graphicCommand[2]) - double.parse(graphicCommand[3]),
                  double.parse(graphicCommand[1]) + double.parse(graphicCommand[3]),
                  double.parse(graphicCommand[2]) + double.parse(graphicCommand[3])),
              double.parse(graphicCommand[4]),
              double.parse(graphicCommand[5]),
              true,
              paint);
          break;
        case 'FILL':
          if (graphicCommand[1] == '0') {
            paint.style = PaintingStyle.stroke;
          } else {
            paint.style = PaintingStyle.fill;
          }
          break;
        case 'STROKE':
          paint.strokeWidth = double.parse(graphicCommand[1]);
          break;
      }
    }

    final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return trimNullBytes(data!.buffer.asUint8List());
  }

  Map<String, TextStyle> _buildHiglightMap() {
    var highlightMap = <String, TextStyle>{};

    scriptFunctions().forEach((entry) {
      highlightMap.addAll({ entry.toLowerCase() : const TextStyle(color: Colors.purple)});
      highlightMap.addAll({ entry.toUpperCase() : const TextStyle(color: Colors.purple)});
    });
    scriptCommands().forEach((entry) {
      highlightMap.addAll({ entry.toLowerCase() : const TextStyle(color: Colors.blue)});
      highlightMap.addAll({ entry.toUpperCase() : const TextStyle(color: Colors.blue)});
    });
    scriptControls().forEach((entry) {
      highlightMap.addAll({ entry.toLowerCase() : const TextStyle(color: Colors.red)});
      highlightMap.addAll({ entry.toUpperCase() : const TextStyle(color: Colors.red)});
    });
    for (var entry in scriptParanthes) {
      highlightMap.addAll({entry : const TextStyle(color: Colors.orange)});
    }
    return highlightMap;
  }
}
