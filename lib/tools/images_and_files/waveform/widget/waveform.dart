import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_soundplayer.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/logic/animated_image_morse_code.dart';
import 'package:gc_wizard/tools/images_and_files/hex_viewer/widget/hex_viewer.dart';
import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';

class WaveForm extends StatefulWidget {
  const WaveForm({Key? key}) : super(key: key);

  @override
  WaveFormState createState() => WaveFormState();
}

class WaveFormState extends State<WaveForm> {
  Uint8List _bytes = Uint8List.fromList([]);
  Uint8List _soundfileImage = Uint8List.fromList([]);
  SoundfileData _soundfileData = SoundfileData(
      PCMformat: 0,
      bits: 0,
      channels: 0,
      sampleRate: 0,
      structure: [],
      duration: 0.0,
      amplitudesData: Uint8List.fromList([]));
  AmplitudeData _amplitudesData = AmplitudeData(maxAmplitude: 0.0, Amplitudes: []);
  MorseCodeOutput? _decodedMorse = MorseCodeOutput('', '');
  List<bool> _soundfileMorsecode = [];

  int _currentPointsize = 1;
  int _currentHScalefactor = 5;
  int _currentVScalefactor = 3;
  int _currentVolume = 8;
  int _currentTolerance = 0;
  int _currentBlocksize = 7;
  final _blocksizes = [1, 2, 4, 8, 16, 32, 64, 128, 256, 384, 441, 512, 1024, 2048];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setData(Uint8List bytes) {
    _bytes = bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWOpenFile(
          supportedFileTypes: const [FileType.WAV],
          onLoaded: (_file) {
            if (_file == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }
           _setData(_file.bytes);
            _soundfileData = getSoundfileData(_bytes);
            _amplitudesData = calculateRMSAmplitudes(
                PCMformat: _soundfileData.PCMformat,
                bits: _soundfileData.bits,
                channels: _soundfileData.channels,
                sampleRate: _soundfileData.sampleRate,
                PCMamplitudesData: _soundfileData.amplitudesData,
                blocksize: _blocksizes[_currentBlocksize],
                vScalefactor: _currentVScalefactor * 1000);
            PCMamplitudes2Image(
                    duration: _soundfileData.duration,
                    RMSperPoint: _amplitudesData.Amplitudes,
                    maxAmplitude: _amplitudesData.maxAmplitude,
                    pointsize: _currentPointsize,
                    volume: _currentVolume,
                    hScalefactor: _currentHScalefactor)
                .then((value) {
              setState(() {
                _soundfileImage = value.MorseImage;
                _soundfileMorsecode = value.MorseCode;
                _decodedMorse = decodeMorseCode(List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                    tolerance: 1 + _currentTolerance / 10);
              });
            });
          },
        ),
        GCWSoundPlayer(
          file: GCWFile(bytes: _bytes),
        ),
        _buildOutput(),
      ],
    );
  }

  Widget _buildOutput() {
    List<Widget> output = _SoundfileStructure(_bytes);
    return Column(children: [
      (_soundfileImage.isNotEmpty)
          ? GCWExpandableTextDivider(
              text: i18n(context, 'waveform_output_amplitudes_graph'),
              child: Column(
                children: <Widget>[
                  GCWImageView(
                    imageData: GCWImageViewData(GCWFile(bytes: _soundfileImage)),
                    suppressOpenInTool: const {GCWImageViewOpenInTools.METADATA},
                  ),
                  GCWExpandableTextDivider(
                    text: i18n(context, 'waveform_settings'),
                    suppressTopSpace: false,
                    child: Column(
                      children: <Widget>[
                        GCWDropDownSpinner(
                          title: i18n(context, 'waveform_settings_waveform_blocksize'),
                          index: _currentBlocksize,
                          items: _blocksizes.map((item) => Text(item.toString(), style: gcwTextStyle())).toList(),
                          onChanged: (value) {
                            setState(() {
                              _currentBlocksize = value;
                              _amplitudesData = calculateRMSAmplitudes(
                                  PCMformat: _soundfileData.PCMformat,
                                  bits: _soundfileData.bits,
                                  channels: _soundfileData.channels,
                                  sampleRate: _soundfileData.sampleRate,
                                  PCMamplitudesData: _soundfileData.amplitudesData,
                                  blocksize: _blocksizes[_currentBlocksize],
                                  vScalefactor: _currentVScalefactor * 1000);
                              PCMamplitudes2Image(
                                      duration: _soundfileData.duration,
                                      RMSperPoint: _amplitudesData.Amplitudes,
                                      maxAmplitude: _amplitudesData.maxAmplitude,
                                      pointsize: _currentPointsize,
                                      volume: _currentVolume,
                                      hScalefactor: _currentHScalefactor)
                                  .then((value) {
                                setState(() {
                                  _soundfileMorsecode = value.MorseCode;
                                  _decodedMorse = decodeMorseCode(
                                      List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                                      tolerance: 1 + _currentTolerance / 10);
                                });
                              });
                            });
                          },
                        ),
                        GCWIntegerSpinner(
                          title: i18n(context, 'waveform_settings_waveform_v_scalefactor'),
                          min: 1,
                          max: 20,
                          value: _currentVScalefactor,
                          onChanged: (value) {
                            setState(() {
                              _currentVScalefactor = value;
                              _amplitudesData = calculateRMSAmplitudes(
                                  PCMformat: _soundfileData.PCMformat,
                                  bits: _soundfileData.bits,
                                  channels: _soundfileData.channels,
                                  sampleRate: _soundfileData.sampleRate,
                                  PCMamplitudesData: _soundfileData.amplitudesData,
                                  blocksize: _blocksizes[_currentBlocksize],
                                  vScalefactor: _currentVScalefactor * 1000);
                              PCMamplitudes2Image(
                                      duration: _soundfileData.duration,
                                      RMSperPoint: _amplitudesData.Amplitudes,
                                      maxAmplitude: _amplitudesData.maxAmplitude,
                                      pointsize: _currentPointsize,
                                      volume: _currentVolume,
                                      hScalefactor: _currentHScalefactor)
                                  .then((value) {
                                setState(() {
                                  _soundfileImage = value.MorseImage;
                                  _soundfileMorsecode = value.MorseCode;
                                  _decodedMorse = decodeMorseCode(
                                      List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                                      tolerance: 1 + _currentTolerance / 10);
                                });
                              });
                            });
                          },
                        ),
                        GCWIntegerSpinner(
                          title: i18n(context, 'waveform_settings_image_pointsize'),
                          min: 1,
                          max: 10,
                          value: _currentPointsize,
                          onChanged: (value) {
                            setState(() {
                              _currentPointsize = value;
                              PCMamplitudes2Image(
                                      duration: _soundfileData.duration,
                                      RMSperPoint: _amplitudesData.Amplitudes,
                                      maxAmplitude: _amplitudesData.maxAmplitude,
                                      pointsize: _currentPointsize,
                                      volume: _currentVolume,
                                      hScalefactor: _currentHScalefactor)
                                  .then((value) {
                                setState(() {
                                  _soundfileImage = value.MorseImage;
                                  _soundfileMorsecode = value.MorseCode;
                                  _decodedMorse = decodeMorseCode(
                                      List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                                      tolerance: 1 + _currentTolerance / 10);
                                });
                              });
                            });
                          },
                        ),
                        GCWIntegerSpinner(
                          title: i18n(context, 'waveform_settings_image_h_scalefactor'),
                          min: 1,
                          max: 20,
                          value: _currentHScalefactor,
                          onChanged: (value) {
                            setState(() {
                              _currentHScalefactor = value;
                              PCMamplitudes2Image(
                                      duration: _soundfileData.duration,
                                      RMSperPoint: _amplitudesData.Amplitudes,
                                      maxAmplitude: _amplitudesData.maxAmplitude,
                                      pointsize: _currentPointsize,
                                      volume: _currentVolume,
                                      hScalefactor: _currentHScalefactor)
                                  .then((value) {
                                setState(() {
                                  _soundfileImage = value.MorseImage;
                                  _soundfileMorsecode = value.MorseCode;
                                  _decodedMorse = decodeMorseCode(
                                      List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                                      tolerance: 1 + _currentTolerance / 10);
                                });
                              });
                            });
                          },
                        ),
                        GCWIntegerSpinner(
                          title: i18n(context, 'waveform_settings_morse_volume'),
                          min: 1,
                          max: 10,
                          value: _currentVolume,
                          onChanged: (value) {
                            setState(() {
                              _currentVolume = value;
                              PCMamplitudes2Image(
                                      duration: _soundfileData.duration,
                                      RMSperPoint: _amplitudesData.Amplitudes,
                                      maxAmplitude: _amplitudesData.maxAmplitude,
                                      pointsize: _currentPointsize,
                                      volume: _currentVolume,
                                      hScalefactor: _currentHScalefactor)
                                  .then((value) {
                                setState(() {
                                  _soundfileMorsecode = value.MorseCode;
                                  _decodedMorse = decodeMorseCode(
                                      List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                                      tolerance: 1 + _currentTolerance / 10);
                                });
                              });
                            });
                          },
                        ),
                        GCWIntegerSpinner(
                            title: i18n(context, 'waveform_settings_morse_tolerance'),
                            value: _currentTolerance,
                            min: -10,
                            max: 10,
                            onChanged: (value) {
                              setState(() {
                                _currentTolerance = value;
                                _decodedMorse = decodeMorseCode(
                                    List.filled(_soundfileMorsecode.length, 1), _soundfileMorsecode,
                                    tolerance: 1 + _currentTolerance / 10);
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ))
          : Container(),
      GCWExpandableTextDivider(
        text: i18n(context, 'waveform_output_morsecode'),
        suppressTopSpace: false,
        child: Column(
          children: <Widget>[
            GCWOutputText(text: _decodedMorse!.morseCode),
            GCWOutputText(
              text: _decodedMorse!.text,
            ),
          ],
        ),
      ),
      GCWExpandableTextDivider(
        text: i18n(context, 'waveform_output_section_structure'),
        suppressTopSpace: false,
        child: Column(
          children: output,
        ),
      ),
      GCWOutput(
        title: i18n(context, 'waveform_output_hexview'),
        child: i18n(context, 'waveform_output_size') +
            ': ' +
            _bytes.length.toString() +
            '\n\n' +
            i18n(context, 'waveform_hint_openinhexviewer'),
        suppressCopyButton: true,
        trailing: Row(children: <Widget>[
          GCWIconButton(
            iconColor: themeColors().mainFont(),
            size: IconButtonSize.SMALL,
            icon: Icons.input,
            onPressed: () {
              openInHexViewer(context, GCWFile(bytes: _bytes));
            },
          ),
        ]),
      )
    ]);
  }

  List<Widget> _SoundfileStructure(Uint8List bytes) {
    List<Widget> result = [];

    for (var section in _soundfileData.structure) {
      List<List<dynamic>> content = [];
      content = [
        [
          i18n(context, 'waveform_output_meaning'),
          i18n(context, 'waveform_output_bytes'),
          i18n(context, 'waveform_output_value'),
        ]
      ];
      for (var element in section.SectionContent) {
        content.add([i18n(context, 'waveform_output_' + element.Meaning), element.Bytes, element.Value]);
      }
      result.add(GCWExpandableTextDivider(
        text: i18n(context, 'waveform_output_section_' + section.SectionTitle),
        expanded: false,
        child: GCWColumnedMultilineOutput(
          data: content,
          flexValues: const [2, 3, 2],
          suppressCopyButtons: true,
          hasHeader: true,
        ),
      ));
    }

    return result;
  }
}
