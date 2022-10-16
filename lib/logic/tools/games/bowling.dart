class BowlingRound {
  final int one;
  final int two;
  final int three;

  BowlingRound({this.one = 0, this.two = 0, this.three = 0});
}

Map<int, Map<int, int>> BOWLING_THROWS = {
  10 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
    8: 8,
    9: 9,
    10: 10,
  },
  9 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
    8: 8,
    9: 9,
  },
  8 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
    8: 8,
  },
  7 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
  },
  6 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
  },
  5 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
  },
  4 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
  },
  3 : {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
  },
  2 : {
    0: 0,
    1: 1,
    2: 2,
  },
  1 : {
    0: 0,
    1: 1,
  },
};

List<int> bowlingCalcTotal(List<BowlingRound> bowlingScore){
  int round = 0;
  List<int> total = [];
  
  for (int i = 0; i < 9; i++){
    if (bowlingScore[i].one == 10) {
      round = bowlingScore[i].one + bowlingScore[i + 1].one;
      if (bowlingScore[i + 1].one == 10) {
        if (i + 1 == 10) {
          round = round + bowlingScore[i + 1].two;
        } else {
          if (i + 2 == 10)
            round = round + bowlingScore[i + 1].two;
          else
            round = round + bowlingScore[i + 2].one;
        }
      }
      else
        round = round + bowlingScore[i + 1].two;
      total[i] = round;
    }

    else if (bowlingScore[i].one + bowlingScore[i].two == 10) {
      total[i] = bowlingScore[i].one + bowlingScore[i].two + bowlingScore[i + 1].one;
    }

    else {
      total[i] = bowlingScore[i].one + bowlingScore[i].two;
    }
  }
  total[9] = bowlingScore[9].one + bowlingScore[9].two + bowlingScore[9].three;
  return total;
}

int bowlingTotalAfterRounds(int round, List<int> total){
  int result = 0;
  for (int i = 0; i <= round; i++)
    result = result + total[i];
  return result;
}

String bowlingBuildDataRow1(int round, int count, List<BowlingRound> bowlingScore){
  String result = '';
  switch (count) {
    case 1:
      result = bowlingScore[round].one == 10 ? 'X' : bowlingScore[round].one.toString();
      break;
    case 2:
      if ( bowlingScore[round].one == 10)
        if (round != 9)
          result = ' ';
        else
          result = bowlingScore[round].two == 10 ? 'X' : bowlingScore[round].two.toString();
      else if ( bowlingScore[round].one +  bowlingScore[round].two == 10)
        result = '/';
      else
        result = bowlingScore[round].two.toString();
      break;
    case 3:
      result = bowlingScore[round].three == 10 ? 'X' : bowlingScore[round].three.toString();
      break;
  }
  return result;
}


