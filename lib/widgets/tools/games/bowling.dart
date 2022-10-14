import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/bowling.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
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

  var _cellWidth;
  var _maxCellHeight;
  BorderSide _border = BorderSide(width: 1.0, color: Colors.black87);

  @override
  void initState() {
    super.initState();
    _initScore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cellWidth = (MediaQuery.of(context).size.width - 20) / 21;
    _maxCellHeight = maxScreenHeight(context) / 11;

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

            _currentOne != 10 ||  _currentRound == 9
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

            _currentRound == 9 && _currentOne == 10
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
          child: Column(
            children: _buildScoreBoard(),
          )
        ),
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

  _buildScoreBoard() {
    var score = <Widget>[];
    var scoreRow1 = <Widget>[];
    var scoreRow2 = <Widget>[];

    for (int i = 0; i < 10; i++){
      scoreRow1.add(_buildCellRow1(i, 1));
      scoreRow1.add(_buildCellRow1(i, 2));
    }
    scoreRow1.add(_buildCellRow1(9, 3));
    score.add(Row(children: scoreRow1,));

    for (int i = 0; i < 10; i++){
      i != 9 ? scoreRow2.add(_buildCellRow2(i)) : scoreRow2.add(_buildCellRow2_10());
    }
    score.add(Row(children: scoreRow2,));

    return score;
  }

  String _buildDataRow1(int round, int count){
    switch (count) {
      case 1:
        if ( _currentBowlingSCore[round].one == 10)
          return 'X';
        else
          return  _currentBowlingSCore[round].one.toString();
        break;
      case 2:
        if ( _currentBowlingSCore[round].one == 10)
          if (round != 9)
            return ' ';
          else
            return _currentBowlingSCore[round].two.toString();
        else if ( _currentBowlingSCore[round].one +  _currentBowlingSCore[round].two == 10)
          return '/';
        else
          return  _currentBowlingSCore[round].two.toString();
        break;
      case 3:
        return  _currentBowlingSCore[round].three.toString();
        break;
    }
  }

  Widget _buildCellRow1(int round, int count){
    return Container(
      height: defaultFontSize() * 1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: _border,
            left: _border,
            right: _border,
            bottom: count != 1 ? _border : BorderSide.none),
      ),
      child: Column(
        children: [
          Expanded(
              child: AutoSizeText(
                _buildDataRow1(round, count),
                style: gcwTextStyle().copyWith(color: Colors.black),
                minFontSize: AUTO_FONT_SIZE_MIN,
                maxLines: 1,
              )),
        ],
      ),
      width: _cellWidth,
    );
  }

  Widget _buildCellRow2(int round){
    return Container(
      height: defaultFontSize() * 1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide.none,
            left: _border,
            right: _border,
            bottom: _border),
      ),
      child: Column(
        children: [
          Expanded(
              child: AutoSizeText(
                _currentTotal[round].toString(),
                style: gcwTextStyle().copyWith(color: Colors.black),
                minFontSize: AUTO_FONT_SIZE_MIN,
                maxLines: 1,
              )),
        ],
      ),
      width: _cellWidth * 2,
    );
  }

  Widget _buildCellRow2_10() {
    return Container(
      height: defaultFontSize() * 1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide.none,
            left: _border,
            right: _border,
            bottom: _border),
      ),
      child: Column(
        children: [
          Expanded(
              child: AutoSizeText(
                _currentTotal[9].toString(),
                style: gcwTextStyle().copyWith(color: Colors.black),
                minFontSize: AUTO_FONT_SIZE_MIN,
                maxLines: 1,
              )),
        ],
      ),
      width: _cellWidth * 3,
    );
  }
}
