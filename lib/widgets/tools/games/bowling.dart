import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/bowling.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Bowling extends StatefulWidget {
  @override
  BowlingState createState() => BowlingState();
}

class BowlingState extends State<Bowling> {
  List<BowlingRound> _currentBowlingScore = List<BowlingRound>(10);
  List<int> _currentTotal = List<int>(10);
  int _currentRound = 0;
  int _currentOne = 0;
  int _currentTwo = 0;
  int _currentThree = 0;

  var _currentPossibleThrows1 = Map.fromIterable(List<int>.generate(10, (i) => i + 1));
  var _currentPossibleThrows2 = Map.fromIterable(List<int>.generate(10, (i) => i + 1));
  var _currentPossibleThrows3 = Map.fromIterable(List<int>.generate(10, (i) => i + 1));

  var _cellWidth;
  BorderSide _border = BorderSide(width: 1.0, color: Colors.black87);

  @override
  void initState() {
    super.initState();
    _initScoreBoard();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cellWidth = (MediaQuery.of(context).size.width - 20) / 21;

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
                  _currentOne = _currentBowlingScore[_currentRound].one;
                  _currentTwo = _currentBowlingScore[_currentRound].two;
                  _currentThree = _currentBowlingScore[_currentRound].three;
                  _currentPossibleThrows2 = Map.fromIterable(List<int>.generate(10, (i) => i + 1));
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
                  _currentOne = _currentBowlingScore[_currentRound].one;
                  _currentTwo = _currentBowlingScore[_currentRound].two;
                  _currentThree = _currentBowlingScore[_currentRound].three;
                  _currentPossibleThrows2 = Map.fromIterable(List<int>.generate(10, (i) => i + 1));
                });
              },
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  child: GCWDropDownButton(
                    value: _currentOne,
                    onChanged: (value) {
                      setState(() {
                        _currentOne = value;
                      });
                      if (_currentOne == 10 && _currentRound != 9) {
                        _currentTwo = 0;
                        _currentThree = 0;
                      } else {
                        _currentTwo = 0;
                        _currentRound != 9 ? _currentPossibleThrows2 = Map.fromIterable(List<int>.generate(10 - _currentOne, (i) => i + 1)) : _currentPossibleThrows2 = Map.fromIterable(List<int>.generate(10, (i) => i + 1));;
                      }
                      _currentBowlingScore[_currentRound] = BowlingRound(one: _currentOne, two: _currentTwo, three: _currentThree);
                      _currentTotal = bowlingCalcTotal(_currentBowlingScore);
                    },
                    items: _currentPossibleThrows1.entries.map((mode) {
                      return GCWDropDownMenuItem(
                        value: mode.key,
                        child: mode.value,
                      );
                    }).toList(),
                  ),
                  margin: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                ),
            ),

            _currentOne != 10 ||  _currentRound == 9
            ? Expanded(
                flex: 1,
              child: Container(
                child: GCWDropDownButton(
                  value: _currentTwo,
                  onChanged: (value) {
                    setState(() {
                      _currentTwo = value;
                    });
                    if (_currentTwo == 10 && _currentRound != 9) {
                      _currentOne = 0;
                      _currentThree = 0;
                    }
                    if (_currentRound == 9 && _currentTwo != 10) {
                          _currentThree = 0;
                          _currentPossibleThrows3 = Map.fromIterable(List<int>.generate(10 - _currentTwo, (i) => i + 1));
                        }
                        _currentBowlingScore[_currentRound] = BowlingRound(one: _currentOne, two: _currentTwo, three: _currentThree);
                    _currentTotal = bowlingCalcTotal(_currentBowlingScore);
                  },
                  items: _currentPossibleThrows2.entries.map((mode) {
                    return GCWDropDownMenuItem(
                      value: mode.key,
                      child: mode.value,
                    );
                  }).toList(),
                ),
                margin: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
              ),
              )
            : Container(),

            _currentRound == 9 && _currentOne == 10
                ? Expanded(
                flex: 1,
                    child: Container(
                      child: GCWDropDownButton(
                        value: _currentThree,
                        onChanged: (value) {
                          setState(() {
                            _currentThree = value;
                          });
                          _currentBowlingScore[_currentRound] = BowlingRound(one: _currentOne, two: _currentTwo, three: _currentThree);
                          _currentTotal = bowlingCalcTotal(_currentBowlingScore);
                        },
                        items: _currentPossibleThrows3.entries.map((mode) {
                          return GCWDropDownMenuItem(
                            value: mode.key,
                            child: mode.value,
                          );
                        }).toList(),
                      ),
                      margin: EdgeInsets.only(left: DEFAULT_MARGIN),
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
            children: columnedMultiLineOutput(context, _buildBowlingScoreTable(), hasHeader: true, copyColumn: 4, flexValues: [2, 1, 1, 1, 2, 3]),
          ),
        ),
        GCWTextDivider(
          text: i18n(context, 'bowling_scoreboard'),
        ),
        GCWOutput(
          child: Column(
            children: _buildBowlingScoreBoard(),
          )
        ),
      ],
    );
  }

  void _initScoreBoard(){
    for (int i = 0; i < 10; i++) {
      _currentBowlingScore[i] = BowlingRound(one: 0, two: 0, three: 0);
      _currentTotal[i] = 0;
    }
  }

  List<List<dynamic>> _buildBowlingScoreTable(){
    List<List<dynamic>> result = [];
    result.add([i18n(context, 'bowling_round'), i18n(context, 'bowling_1'), i18n(context, 'bowling_2'), i18n(context, 'bowling_3'), i18n(context, 'bowling_total'), i18n(context, 'bowling_wholetotal')]);
    for (int i = 0; i < 10; i++)
      result.add([i + 1, _currentBowlingScore[i].one, _currentBowlingScore[i].two, i == 9 ? _currentBowlingScore[i].three : null, _currentTotal[i], bowlingTotalAfterRounds(i, _currentTotal)]);
    return result;
  }

  List<Widget> _buildBowlingScoreBoard() {
    https://www.sportcalculators.com/bowling-score-calculator
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
                bowlingBuildDataRow1(round, count, _currentBowlingScore),
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
