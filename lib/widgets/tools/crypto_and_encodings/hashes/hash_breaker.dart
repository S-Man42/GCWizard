import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_variablecoordinate_textinputformatter.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hash_breaker.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:async';
import 'dart:isolate';


class HashBreaker extends StatefulWidget {
  final Function hashFunction;

  const HashBreaker({Key key, this.hashFunction}) : super(key: key);

  @override
  _HashBreakerState createState() => _HashBreakerState();
}

class _HashBreakerState extends State<HashBreaker> {
  final Map<String, Function> _HASHFUNCTIONS = {
    'hashes_md5' : md5Digest,
    'hashes_sha1' : sha1Digest,
    'hashes_sha224' : sha224Digest,
    'hashes_sha256' : sha256Digest,
    'hashes_sha384' : sha384Digest,
    'hashes_sha512' : sha512Digest,
    'hashes_sha512.224' : sha512_224Digest,
    'hashes_sha512.256' : sha512_256Digest,
    'hashes_sha3.224' : sha3_224Digest,
    'hashes_sha3.256' : sha3_256Digest,
    'hashes_sha3.384' : sha3_384Digest,
    'hashes_sha3.512' : sha3_512Digest,
    'hashes_keccak224' : keccak_224Digest,
    'hashes_keccak256' : keccak_256Digest,
    'hashes_keccak288' : keccak_288Digest,
    'hashes_keccak384' : keccak_384Digest,
    'hashes_keccak512' : keccak_512Digest,
    'hashes_ripemd128' : ripemd_128Digest,
    'hashes_ripemd160' : ripemd_160Digest,
    'hashes_ripemd256' : ripemd_256Digest,
    'hashes_ripemd320' : ripemd_320Digest,
    'hashes_md2' : md2Digest,
    'hashes_md4' : md4Digest,
    'hashes_tiger192' : tiger_192Digest,
    'hashes_whirlpool512' : whirlpool_512Digest,
    'hashes_blake2b160' : blake2b_160Digest,
    'hashes_blake2b224' : blake2b_224Digest,
    'hashes_blake2b256' : blake2b_256Digest,
    'hashes_blake2b384' : blake2b_384Digest,
    'hashes_blake2b512' : blake2b_512Digest,
  };

  var _fromController;
  var _toController;
  var _inputController;
  var _maskController;

  var _currentInput = '';
  var _currentMask = '';
  var _currentFromInput = '';
  var _currentToInput = '';

  var _currentEditedKey = '';
  var _currentEditedValue = '';
  var _currentEditId;
  var _editKeyController;
  var _editValueController;

  var _currentIdCount = 0;

  var _currentOutput = '';
  var _currentHashFunction = md5Digest;
  var _currentSubstitutions = <int, Map<String, String>>{};
  var _isStarted = false;
  var _progress = 0.0;
  SendPort sendPort;

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _maskController = TextEditingController(text: _currentMask);
    _fromController = TextEditingController(text: _currentFromInput);
    _toController = TextEditingController(text: _currentToInput);

    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _maskController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _editKeyController.dispose();
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context, 'hashes_hashbreaker_hashtobreak'),
          controller: _inputController,
          onChanged: (value) {
            _currentInput = value;
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'hashes_hashbreaker_searchconfiguration'),
        ),
        GCWDropDownButton(
          value: _currentHashFunction,
          onChanged: (newValue) {
            setState(() {
              _currentHashFunction = newValue;
            });
          },
          items: _HASHFUNCTIONS.entries.map((hashFunction) {
            return GCWDropDownMenuItem(
              value: hashFunction.value,
              child: i18n(context, hashFunction.key + '_title'),
            );
          }).toList(),
        ),
        GCWTextField(
          hintText: i18n(context, 'hashes_hashbreaker_searchconfiguration_searchmask'),
          controller: _maskController,
          onChanged: (value) {
            _currentMask = value;
          },
        ),
        _buildVariablesInput(),
        _buildSubstitutionList(context),
        _buildButtonProgressBar(),
        GCWDefaultOutput(
          child: _currentOutput
        )
      ],
    );
  }

  _buildButtonProgressBar() {
    //ChangeNotifierProvider<TimeState>();
   return _isStarted ?
     LinearPercentIndicator(
        width : 300.0,
        linearStrokeCap: LinearStrokeCap.butt,
        lineHeight: 30.0,
        percent: _progress,

        center: (Text(
          (_progress * 100).toStringAsFixed(1) + "%",
    //style : new TextStyle( fontSize: 16.0, color: Colors.white, fontStyle: FontStyle.italic),
    )))
        :
     GCWSubmitFlatButton(
       onPressed: _calculateOutput2
         //Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new HomeTest()));

    );
  }

  _startProgressTimer() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (!_isStarted)
        timer.cancel();
      //print(DateTime.now().toString() + ' timer tick '+ _isStarted.toString());
      if (sendPort != null)
        sendPort.send("");
      //print("progess " + Progress.toString());
    });
  }
/*
  _calculateOutput() async {
    if (_isStarted)
      return;

    var _substitutions = <String, String>{};
    _currentSubstitutions.entries.forEach((entry) {
      _substitutions.putIfAbsent(
          entry.value.keys.first, () => entry.value.values.first);
    });

    var preCheckResult = preCheck(_substitutions);
    if (preCheckResult == null || preCheckResult['status'] == null)
      return i18n(context, 'hashes_hashbreaker_solutionnotfound');

    if (preCheckResult['status'] == 'high_count') {
      showGCWAlertDialog(
        context,
        i18n(context, 'hashes_hashbreaker_alert_range_title'),
        i18n(context, 'hashes_hashbreaker_alert_range_text',
            parameters: [preCheckResult['count']]),
            () {
          setState(() {
            this.setState(() {});
            _calculateOutput1(_substitutions);
          });
        },
      );

      _currentOutput = '';
      return;
    } else
      _calculateOutput1(_substitutions);
  }
*/

  _calculateOutput2() async {
    //Future<Map<String, dynamic>> _currentOutputFuture ;
    //var thread = new Thread(() async {
      print(DateTime.now().toString() + ' BLA start');
      //_isStarted = true;

      var _substitutions = <String, String>{};
      _currentSubstitutions.entries.forEach((entry) {
        _substitutions.putIfAbsent(
            entry.value.keys.first, () => entry.value.values.first);
      });
      var preCheckResult = preCheck(_substitutions);

      _isStarted = true;
      _startProgressTimer();
      var jobData = HashBreakerJobData(input: _currentInput, searchMask: _currentMask, substitutions: _substitutions, hashFunction: _currentHashFunction, sendPort: progressPort.sendPort);
      var isolate = await Isolate.spawn(breakHash, jobData);
      /*outputPort.listen((output) {
        print('RECEIVE: ' + output.toString() + ', ');
        _currentOutput = output['text'];
        _isStarted = false;
        //print('RECEIVE: ' + data + ', ');
      });*/
      progressPort.listen((data) {
        print('RECEIVE: ' + data.toString() + ', ');

        //print('RECEIVE: ' + data + ', ');
          if (data is SendPort) {
            sendPort = data;
          } else if (data is double) {
            _progress = data;
            setState(() {});
          } else if (data is Map<String, dynamic>) {
            _currentOutput = data['text'];
            _isStarted = false;
          }

      });
/*
      var _currentOutputFuture = breakHash(

      _currentOutputFuture.then((output) {
        //_isStarted = false;
        print(DateTime.now().toString() + ' finished');

        if (output == null || output['state'] == null || output['state'] == 'not_found'){
          return i18n(context, 'hashes_hashbreaker_solutionnotfound');
        }

        print(DateTime.now().toString() + ' BLA3');
        _currentOutput = output['text'];
        //this.setState(() {});

      });
      */

    //});
    //thread.start();

    print(DateTime.now().toString() + ' BLA1');
  }
/*
  _calculateOutput1(Map<String, String> _substitutions) async {
    print(DateTime.now().toString() + ' BLA4');
        ()async {
          setState(() {
            print(DateTime.now().toString() + ' BLA5');
            _isStarted = true; //here you show a indicator
            _startProgressTimer();
          });
          await _calculateOutput2(); //here you wait for function
          setState(() {
            print(DateTime.now().toString() + ' BLA6');
            _isStarted = false; //here you hide the indicator
          });
        };
    print(DateTime.now().toString() + ' BLA7');
  }
*/



  _buildVariablesInput() {
    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'coords_variablecoordinate_variables'),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: GCWTextField(
                  hintText: i18n(context, 'coords_variablecoordinate_variable'),
                  controller: _fromController,
                  onChanged: (text) {
                    _currentFromInput = text;
                  },
                ),
                flex: 1
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'coords_variablecoordinate_possiblevalues'),
                controller: _toController,
                inputFormatters: [CoordsTextVariableCoordinateTextInputFormatter()],
                onChanged: (text) {
                  _currentToInput = text;
                },
              ),
              flex: 2,
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                setState(() {
                  if (_currentFromInput.length > 0) {
                    _currentSubstitutions.putIfAbsent(++_currentIdCount, () => {_currentFromInput: _currentToInput});

                    _fromController.clear();
                    _toController.clear();
                    _currentFromInput = '';
                    _currentToInput = '';
                  }
                });
              },
            )
          ],
        ),
      ],
    );
  }

  _buildSubstitutionList(BuildContext context) {
    var odd = true;
    var rows = _currentSubstitutions.entries.map((substitution) {
      Widget output;

      var row = Container(
          child: Row (
            children: <Widget>[
              Expanded(
                child: Container(
                  child: _currentEditId == substitution.key
                    ? GCWTextField (
                      controller: _editKeyController,
                      onChanged: (text) {
                        setState(() {
                          _currentEditedKey = text;
                        });
                      },
                    )
                    : GCWText (
                      text: substitution.value.keys.first
                    ),
                  margin: EdgeInsets.only(left: 10),
                ),
                flex: 1,
              ),
              Icon(
                Icons.arrow_forward,
                color: themeColors().mainFont(),
              ),
              Expanded(
                  child: Container(
                    child: _currentEditId == substitution.key
                      ? GCWTextField(
                        controller: _editValueController,
                        autofocus: true,
                        onChanged: (text) {
                          setState(() {
                            _currentEditedValue = text;
                          });
                        },
                      )
                      : GCWText (
                        text: substitution.value.values.first
                      ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                  flex: 3
              ),
              _currentEditId == substitution.key
                ? GCWIconButton(
                    iconData: Icons.check,
                    onPressed: () {

                      _currentSubstitutions[_currentEditId] = {_currentEditedKey: _currentEditedValue};

                      setState(() {
                        _currentEditId = null;
                        _editKeyController.clear();
                        _editValueController.clear();
                      });
                    },
                  )
                : GCWIconButton(
                    iconData: Icons.edit,
                    onPressed: () {
                      setState(() {
                        _currentEditId = substitution.key;
                        _editKeyController.text = substitution.value.keys.first;
                        _editValueController.text = substitution.value.values.first;
                        _currentEditedKey = substitution.value.keys.first;
                        _currentEditedValue = substitution.value.values.first;
                      });
                    },
                  ),
              GCWIconButton(
                iconData: Icons.remove,
                onPressed: () {
                  setState(() {
                    _currentSubstitutions.remove(substitution.key);
                  });
                },
              )
            ],
          )
      );

      if (odd) {
        output = Container(
            color: themeColors().outputListOddRows(),
            child: row
        );
      } else {
        output = Container(
            child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    return Container(
      child: Column(
          children: rows
      ),
      padding: EdgeInsets.only(
          top: 10
      ),
    );
  }
}
