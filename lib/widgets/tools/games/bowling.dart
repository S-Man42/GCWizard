import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/bowling.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:prefs/prefs.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class Bowling extends StatefulWidget {
  @override
  BowlingState createState() => BowlingState();
}

class BowlingState extends State<Bowling> {
  List<BowlingRound> _currentBowlingSCore = List<BowlingRound>(10);
  List<int> _currentTotal = List<int>(10);
  int _currentRound = 0;
  int _currentOne = 0;
  int _currentTwo = 0;
  int _currentThree = 0;
  var _codeGenerateController;
  var _sourceCodeGenerated = '';

  @override
  void initState() {
    super.initState();
    _initScore();
    _codeGenerateController = CodeController(
      text: _sourceCodeGenerated,
      theme: Prefs.getString('theme_color') == ThemeType.DARK.toString() ? atomOneDarkTheme : atomOneLightTheme,
    );
  }

  @override
  void dispose() {
    _codeGenerateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            GCWIconButton(
              icon: Icons.arrow_back_ios,
              onPressed: () {
                setState(() {
                  _currentRound--;
                  if (_currentRound < 0) _currentRound = 9;
                  _resetScore();
                });
              },
            ),
            Expanded(
              child: GCWText(
                align: Alignment.center,
                text:i18n(context, 'bowling_round') + ' '+ ( _currentRound + 1).toString() + ' of 10',
              ),
            ),
            GCWIconButton(
              icon: Icons.arrow_forward_ios,
              onPressed: () {
                setState(() {
                  _currentRound++;
                  if (_currentRound > 9) _currentRound = 0;
                  _resetScore();
                });
              },
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: GCWIntegerSpinner(
                  min: 0,
                  max: 10,
                  value: _currentOne,
                  onChanged: (value) {
                    setState(() {
                      _currentOne = value;
                      _currentBowlingSCore[_currentRound] = BowlingRound(one: _currentOne, two: _currentTwo, three: _currentThree);
                      _calcTotal();
                    });
                  },
                )
            ),
            _currentOne != 10
            ? Expanded(
                flex: 1,
                child: GCWIntegerSpinner(
                  min: 0,
                  max: 10,
                  value: _currentTwo,
                  onChanged: (value) {
                    setState(() {
                      _currentTwo = value;
                      _currentBowlingSCore[_currentRound] = BowlingRound(one: _currentOne, two: _currentTwo, three: _currentThree);
                      _calcTotal();
                    });
                  },
                )
              )
            : Container(),
            _currentRound == 10
                ? Expanded(
                flex: 1,
                    child: GCWIntegerSpinner(
                      min: 0,
                      max: 10,
                      value: _currentThree,
                      onChanged: (value) {
                        setState(() {
                          _currentThree = value;
                          _currentBowlingSCore[_currentRound] = BowlingRound(one: _currentOne, two: _currentTwo, three: _currentThree);
                          _calcTotal();
                        });
                      },

                    )
                  )
                : Container()

          ]
        ),
        _buildOutput(),
      ],
    );
  }

  Widget _buildOutput() {
    _codeGenerateController.text = _scoreBoard();
    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: Column(
            children: columnedMultiLineOutput(context, _bowlingScore(), hasHeader: true, copyColumn: 4, flexValues: [2, 1, 1, 1, 2, 3]),
          ),
        ),
        GCWTextDivider(
          text: i18n(context, 'bowling_scoreboard'),
        ),
        GCWOutput(
            child: CodeField(
              controller: _codeGenerateController,
              textStyle: gcwMonotypeTextStyle(),
            )
        )
      ],
    );
  }

  List<List<dynamic>> _bowlingScore(){
    List<List<dynamic>> result = [];
    result.add([i18n(context, 'bowling_round'), i18n(context, 'bowling_1'), i18n(context, 'bowling_2'), i18n(context, 'bowling_3'), i18n(context, 'bowling_total'), i18n(context, 'bowling_wholetotal')]);
    for (int i = 0; i < 10; i++)
      result.add([i + 1, _currentBowlingSCore[i].one, _currentBowlingSCore[i].two, i == 9 ? _currentBowlingSCore[i].three : null, _currentTotal[i], _total(i)]);
    return result;
  }

  void _resetScore(){
    _currentOne = _currentBowlingSCore[_currentRound].one;
    _currentTwo = _currentBowlingSCore[_currentRound].two;
    _currentThree = _currentBowlingSCore[_currentRound].three;
  }

  void _initScore(){
    for (int i = 0; i < 10; i++) {
      _currentBowlingSCore[i] = BowlingRound(one: 0, two: 0, three: 0);
      _currentTotal[i] = 0;
    }
  }

  void _calcTotal(){
    int round = 0;
    for (int i = 0; i < 9; i++){
      if (_currentBowlingSCore[i].one == 10) {
        round = _currentBowlingSCore[i].one + _currentBowlingSCore[i + 1].one;
        if (_currentBowlingSCore[i + 1].one == 10) {
          if (i + 1 == 10)
            round = round + _currentBowlingSCore[i + 1].two;
          else
            round = round + _currentBowlingSCore[i + 2].one;
        }
        else
          round = round + _currentBowlingSCore[i + 1].two;
        _currentTotal[i] = round;
      }
      else if (_currentBowlingSCore[i].one + _currentBowlingSCore[i].two == 10) {
        _currentTotal[i] = _currentBowlingSCore[i].one + _currentBowlingSCore[i].two + _currentBowlingSCore[i + 1].one;
      }
      else {
        _currentTotal[i] = _currentBowlingSCore[i].one + _currentBowlingSCore[i].two;
      }
    }
    _currentTotal[9] = _currentBowlingSCore[9].one + _currentBowlingSCore[9].two + _currentBowlingSCore[9].three;
  }

  int _total(int round){
    int result = 0;
    for (int i = 0; i <= round; i++)
      result = result + _currentTotal[i];
    return result;
  }

  String _scoreBoard(){
    String line1 = '|';
    String line2 = '|';
    for (int i = 0; i < 10; i++){
      if ( _currentBowlingSCore[i].one == 10){
        line1 = line1 + ' |X|';
      } else {
        line1 = line1 + _currentBowlingSCore[i].one.toString() + '|';
        if (_currentBowlingSCore[i].one + _currentBowlingSCore[i].two == 10)
          line1 = line1 + '/|';
        else
          line1 = line1 + _currentBowlingSCore[i].two.toString() + '|';
      }

      line2 = line2 + _currentTotal[i].toString().padLeft(3, ' ') + '|';
    }
    return line1 + '\n' + line2;
  }

}
