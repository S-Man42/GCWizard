import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/logic/hexstring2file.dart';
import 'package:gc_wizard/tools/miscellaneous/chatgpt/logic/chatgpt.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:prefs/prefs.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({Key? key}) : super(key: key);

  @override
  _ChatGPTState createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  late TextEditingController _promptController;

  String _currentPrompt = '';
  String _currentAPIkey = Prefs.getString(PREFERENCE_CHATGPT_API_KEY);
  double _currentTemperature = 0.0;
  String _currentOutput = '';
  String _currentModel = 'gpt-3.5-turbo-instruct';
  String _currentImageData = '';
  String _currentImageSize = '256x256';

  bool _loadFile = false;

  Widget _outputWidget = Container();

  Map<String, String> _modelIDs = {};

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentImageMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    for (String model in MODELS_CHAT) {
      _modelIDs[model] = model;
    }
    for (String model in MODELS_COMPLETIONS) {
      _modelIDs[model] = model;
    }

    _promptController = TextEditingController(text: _currentPrompt);
  }

  @override
  void dispose() {
    _promptController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDown<String>(
          value: _currentModel,
          items: _modelIDs.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentModel = value;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'chatgpt_prompt'),
          suppressTopSpace: true,
          suppressBottomSpace: true,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GCWIconButton(
                icon: Icons.file_open,
                size: IconButtonSize.SMALL,
                onPressed: () {
                  setState(() {
                    _loadFile = !_loadFile;
                  });
                },
              ),
              GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                onPressed: () {
                  _exportFile(
                    context,
                    Uint8List.fromList(_currentPrompt.codeUnits),
                  );
                },
              ),
            ],
          ),
        ),
        GCWTextField(
          controller: _promptController,
          onChanged: (text) {
            setState(() {
              _currentPrompt = text;
            });
          },
        ),
        if (_loadFile)
          GCWOpenFile(
            onLoaded: (_file) {
              if (_file == null) {
                showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
                _loadFile = !_loadFile;
                return;
              }
              _currentPrompt = String.fromCharCodes(_file.bytes);
              _loadFile = !_loadFile;
              setState(() {});
            },
          ),
        GCWTextDivider(text: i18n(context, 'chatgpt_temperature')),
        GCWDoubleSpinner(
            min: 0,
            max: 1,
            numberDecimalDigits: 6,
            onChanged: (value) {
              setState(() {
                _currentTemperature = value;
              });
            },
            value: _currentTemperature),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'chatgpt_text'),
          rightValue: i18n(context, 'chatgpt_image'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? Column(children: <Widget>[
                GCWDropDown<String>(
                  title: i18n(context, 'chatgpt_size'),
                  value: _currentImageSize,
                  items: IMAGE_SIZE.entries.map((mode) {
                    return GCWDropDownMenuItem(
                      value: mode.key,
                      child: mode.value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentImageSize = value;
                    });
                  },
                ),
                GCWTwoOptionsSwitch(
                  leftValue: i18n(context, 'chatgpt_image_url'),
                  rightValue: i18n(context, 'chatgpt_image'),
                  value: _currentImageMode,
                  onChanged: (value) {
                    setState(() {
                      _currentImageMode = value;
                    });
                  },
                ),
              ])
            : Container(),
        GCWButton(
          text: i18n(context, 'common_start'),
          onPressed: () {
            setState(() {
              _calcOutput();
            });
          },
        ),
        _outputWidget,
      ],
    );
  }

  void _calcOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      _getChatGPTtext();
      setState(() {});
    } else {
      _getChatGPTimage();
    }
  }

  void _exportFile(
    BuildContext context,
    Uint8List data,
  ) async {
    bool value = false;
    String filename = buildFileNameWithDate('chatgpt.dart', null) + '.prompt';
    value = await saveByteDataToFile(context, data, filename);
    if (value) showExportedFileDialog(context);
  }

  void _getChatGPTtext() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<ChatGPTtextOutput>(
              isolatedFunction: ChatGPTgetTextAsync,
              parameter: _buildChatGPTgetJobData,
              onReady: (data) => _showChatGPTgetTextOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildChatGPTgetJobData() async {
    return GCWAsyncExecuterParameters(ChatGPTgetChatJobData(
      chatgpt_api_key: _currentAPIkey,
      chatgpt_model: _currentModel,
      chatgpt_prompt: _currentPrompt,
      chatgpt_temperature: _currentTemperature,
      chatgpt_image_size: _currentImageSize,
      chatgpt_image_url: _currentImageMode == GCWSwitchPosition.left,
    ));
  }

  void _showChatGPTgetTextOutput(ChatGPTtextOutput output) {
    if (output.status == ChatGPTstatus.OK) {
      var outputMap = jsonDecode(output.textData);
      _currentOutput = outputMap['choices'][0]['text'] as String;
      _outputWidget = GCWDefaultOutput(child: _currentOutput);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      if (output.status == ChatGPTstatus.ERROR) {
        _currentOutput = i18n(context, 'chatgpt_error') +
            '\n' +
            output.httpCode +
            '\n' +
            output.httpMessage +
            '\n' +
            output.textData;
      }
    });
  }

  void _getChatGPTimage() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<ChatGPTimageOutput>(
              isolatedFunction: ChatGPTgetImageAsync,
              parameter: _buildChatGPTgetJobData,
              onReady: (data) => _showChatGPTgetImageOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  void _showChatGPTgetImageOutput(ChatGPTimageOutput output) {
    if (output.status == ChatGPTstatus.OK) {
      var outputMap = jsonDecode(output.imageData);
      if (_currentImageMode == GCWSwitchPosition.left) {
        _currentOutput = outputMap['data'][0]['url'] as String;
        _outputWidget = GCWDefaultOutput(child: _currentOutput);
      } else {
        _currentOutput = outputMap['data'][0]['b64_json'] as String;
        _currentImageData = decodeBase64(_currentOutput);
        _currentImageData = asciiToHexString(_currentImageData);
        var fileData = hexstring2file(_currentImageData);
        _outputWidget = Column(
          children: <Widget>[
            GCWExpandableTextDivider(
              expanded: false,
              text: 'BASE64',
              child: GCWDefaultOutput(
                child: _currentOutput,
              )
            ),
            GCWImageView(imageData: GCWImageViewData(GCWFile(bytes: fileData!)))
          ],
        );
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      if (output.status == ChatGPTstatus.ERROR) {
        _currentOutput = i18n(context, 'chatgpt_error') +
            '\n' +
            output.httpCode +
            '\n' +
            output.httpMessage +
            '\n' +
            output.imageData;
      }
    });
  }
}
