import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/burrows_wheeler.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';

class BurrowsWheeler extends StatefulWidget {
  @override
  BurrowsWheelerState createState() => BurrowsWheelerState();
}

class BurrowsWheelerState extends State<BurrowsWheeler> {
  var plainController;
  var chiffreController;
  var indexNumberController;
  var indexCharacterController;

  var currentMode = GCWSwitchPosition.left;

  String currentInputPlain = '';
  String currentInputChiffre = '';
  String IndexSymbol = '#';
  bool encodeIndex = false;
  int IndexPosition = 1;
  int currentInputLen = 0;

  @override
  void initState() {
    super.initState();
    plainController = TextEditingController(text: currentInputPlain);
    chiffreController = TextEditingController(text: currentInputChiffre);
    indexCharacterController = TextEditingController(text: IndexSymbol);
  }

  @override
  void dispose() {
    plainController.dispose();
    chiffreController.dispose();
    indexCharacterController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: currentMode,
          onChanged: (value) {
            setState(() {
              currentMode = value;
            });
          },
        ),
        GCWOnOffSwitch(
          notitle: false,
          title: i18n(context, 'burrowswheeler_index_encode'),
          value: encodeIndex,
          onChanged: (value) {
            setState(() {
              encodeIndex = value;
            });
          },
        ),
        currentMode == GCWSwitchPosition.left // encrypt
        ? Column(
          children: <Widget>[
            GCWTextField(
              controller: plainController,
              hintText: i18n(context, 'burrowswheeler_inputplain'),
              onChanged: (text) {
                setState(() {
                  currentInputPlain = text;
                  if (currentInputPlain == '' || currentInputPlain == null)
                    currentInputLen = 0;
                  else
                  currentInputLen = currentInputPlain.length;
                });
              },
            ),
            encodeIndex == false
                ? Container()
                : GCWTextField(
                controller: indexCharacterController,
                hintText: i18n(context, 'burrowswheeler_index_symbol'),
                onChanged: (text) {
                  setState(() {
                    IndexSymbol = text;
                  });
                }
            ),

          ]
        )
        : Column( // decrypt
          children: <Widget>[
            GCWTextField(
              controller: chiffreController,
              hintText: i18n(context, 'burrowswheeler_inputchiffre'),
              onChanged: (text) {
                setState(() {
                  currentInputChiffre = text;
                  if (currentInputChiffre == '' || currentInputChiffre == null)
                    currentInputLen = 0;
                  else
                    currentInputLen = currentInputChiffre.length;
                });
              },
            ),
            encodeIndex == false
                ? GCWIntegerSpinner(
                    controller: indexNumberController,
                    min: 1,
                    max: currentInputLen * 2 + 1,
                    value: IndexPosition,
                    onChanged: (value) {
                      setState(() {
                       IndexPosition = value;
                      });
                    },
                  )
                : GCWTextField(
                    controller: indexCharacterController,
                    hintText: i18n(context, 'burrowswheeler_index_symbol'),
                    onChanged: (text) {
                      setState(() {
                        IndexSymbol = text;
                      });
                    }
                  ),
          ],
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    BWTOutput currentOutput;
    String title = '';

    if (currentMode == GCWSwitchPosition.left) { // encrypt
      if (encodeIndex) {
        if (IndexSymbol == '' || IndexSymbol == null)
          currentOutput = BWTOutput(i18n(context, 'burrowswheeler_error_no_index'), '');
        else if (currentInputPlain.contains(IndexSymbol))
          currentOutput = BWTOutput(i18n(context, 'burrowswheeler_error_char_index'), '');
        else
          currentOutput = encryptBurrowsWheeler(currentInputPlain, IndexSymbol);
      } else {
          currentOutput = encryptBurrowsWheeler(currentInputPlain, '0');
      }
    } else { // decrypt
      if (encodeIndex) {
        if (IndexSymbol == '' || IndexSymbol == null)
          currentOutput = BWTOutput(i18n(context, 'burrowswheeler_error_no_index'), '');
        else
          currentOutput = decryptBurrowsWheeler(currentInputChiffre, IndexSymbol);
      } else {
        currentOutput =decryptBurrowsWheeler(currentInputChiffre, IndexPosition.toString());
      }
    }

    if (currentMode == GCWSwitchPosition.left)
      title = i18n(context, 'burrowswheeler_compress_output');
    else
      title = i18n(context, 'burrowswheeler_decompress_output');

    return GCWMultipleOutput(
      children: [
        currentOutput.text,
        GCWOutput(
            title: i18n(context, 'burrowswheeler_index'),
            child: GCWOutputText(
              text: currentOutput.index,
            )
        ),
      ],
    );
  }
}