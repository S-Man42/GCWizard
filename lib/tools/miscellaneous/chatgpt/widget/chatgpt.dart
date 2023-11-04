import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:dart_openai/dart_openai.dart';
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
  late TextEditingController _modelController;
  late TextEditingController _temperatureController;

  String _currentPrompt = '';
  String _currentAPIkey = Prefs.getString(PREFERENCE_CHATGPT_API_KEY);
  double _currentTemperature = 0.0;
  String _currentOutput = '';
  String _currentModel = 'text-davinci-003';
  String _currentImageData = '';

  bool _loadFile = false;
  bool _loadModels = false;

  Widget _outputWidget = Container();

  Map<String, String> _modelIDs = {};

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    OpenAI.apiKey = _currentAPIkey;
    _promptController = TextEditingController(text: _currentPrompt);
    _modelController = TextEditingController(text: _currentModel);
  }

  @override
  void dispose() {
    _promptController.dispose();
    _modelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_loadModels)
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
        if (!_loadModels)
          Row(children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: DEFAULT_MARGIN),
                  child: GCWTextField(
                    //title: i18n(context, 'chatgpt_prompt'),
                    controller: _modelController,
                    onChanged: (text) {
                      setState(() {
                        _currentModel = text;
                      });
                    },
                  )),
              flex: 4,
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: DEFAULT_MARGIN),
                  child: GCWButton(
                    //text: i18n(context, 'common_start'),
                    text: i18n(context, 'chatgpt_button_models'),
                    onPressed: () {
                      setState(() {
                        _getChatGPTmodelList();
                      });
                    },
                  )),
              flex: 3,
            ),
          ]),
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

  Future<void> _calcOutput() async {
    if (_currentMode == GCWSwitchPosition.left) {
      try {
        final completion = await OpenAI.instance.completion.create(
          model: _currentModel,
          prompt: _currentPrompt,
          temperature: _currentTemperature,
          maxTokens: 1000,
        );
        _currentOutput = completion.choices[0].text;
        _outputWidget = GCWDefaultOutput(child: _currentOutput);
      } on RequestFailedException catch (e) {
        _outputWidget = GCWDefaultOutput(child: 'Statuscode ' + e.statusCode.toString() + '\n' + e.message);
      }
    } else {
      // Generate an image from a prompt.
      try {
        final image = await OpenAI.instance.image.create(
          prompt: _currentPrompt,
          size: OpenAIImageSize.size256,
          //responseFormat: OpenAIImageResponseFormat.url,
          responseFormat: OpenAIImageResponseFormat.b64Json,
          n: 1,
        );
        //_currentURL = image.data.first.url!;
        _currentImageData = image.data.first.data!;
        _currentImageData = decodeBase64(_currentImageData);
        _currentImageData = asciiToHexString(_currentImageData);
        var fileData = hexstring2file(_currentImageData);
        //_outputWidget = GCWDefaultOutput(child: _currentImageData);
        //_outputWidget = hexDataOutput(context, <Uint8List>[fileData!]);
        _outputWidget = GCWImageView(imageData: GCWImageViewData(GCWFile(bytes: fileData!)));
      } on RequestFailedException catch (e) {
        _outputWidget = GCWDefaultOutput(child: 'Statuscode ' + e.statusCode.toString() + '\n' + e.message);
      }
    }
    setState(() {});
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


  void _getChatGPTmodelList() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<ChatGPTmodelOutput>(
              isolatedFunction: ChatGPTgetModelListAsync,
              parameter: _buildChatGPTgetModelListJobData,
              onReady: (data) => _showChatGPTgetModelListOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildChatGPTgetModelListJobData() async {
    return GCWAsyncExecuterParameters(ChatGPTgetModelListJobData(
      chatgpt_api_key: _currentAPIkey,
    ));
  }

  void _showChatGPTgetModelListOutput(ChatGPTmodelOutput output) {
    if (output.status == ChatGPTstatus.OK) {
      //showSnackBar(i18n(context, 'wtf_result_ok'), context);
      output.models.forEach((model) {
        _modelIDs[model] = model;
      });
      _loadModels = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      if (output.status == ChatGPTstatus.ERROR) {
        showSnackBar(i18n(context, 'wtf_result_error_2') + '\n' + output.httpCode + '\n' + output.httpMessage, context);
      }
    });
  }
}
