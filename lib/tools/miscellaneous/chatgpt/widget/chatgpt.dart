import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:prefs/prefs.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({Key? key}) : super(key: key);

  @override
  _ChatGPTState createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  late TextEditingController _promptController;
  late TextEditingController _temperatureController;

  String _currentPrompt = '';
  String _currentTemperature = '';
  String _currentOutput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    _promptController = TextEditingController(text: _currentPrompt);
    _temperatureController = TextEditingController(text: _currentTemperature);
  }

  @override
  void dispose() {
    _promptController.dispose();
    _temperatureController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          title: i18n(context, 'chatgpt_prompt'),
          controller: _promptController,
          onChanged: (text) {
            setState(() {
              _currentPrompt = text;
            });
          },
        ),
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
        GCWDefaultOutput(child: _currentOutput)
      ],
    );
  }

  Future<void> _calcOutput() async {
    OpenAI.apiKey = Prefs.getString(PREFERENCE_CHATGPT_API_KEY);
    // Start using!
    final completion = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: _currentPrompt,
    );

    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = completion.choices[0].text;
    } else {
      // Generate an image from a prompt.
      final image = await OpenAI.instance.image.create(
        prompt: _currentPrompt,
        n: 1,
      );
      // Printing the output to the console.
      print(image.data.first.url);
    }


    // create a moderation
    //final moderation = await OpenAI.instance.moderation.create(
    //  input: "I will cut your head off",
    //;

    // Printing moderation
    //print(moderation.results.first.categories.violence);
  }
}
