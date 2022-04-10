import 'dart:core';
import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block.dart';
import 'package:tuple/tuple.dart';


enum DirectionEnum {
  East,
  South,
  West,
  North
}

enum CodelChoiceEnum {
  Left,
  Right
}

class PietNavigator {
  var _Direction = DirectionEnum.East;
  DirectionEnum get Direction => _Direction;

  var _CodelChooser = CodelChoiceEnum.Left;
  CodelChoiceEnum get CodelChooser => _CodelChooser;

  List<List<int>> _data;

  final int White = 0xFFFFFF;
  final int Black = 0x000000;

  int _width;
  int _height;

  PietNavigator(List<List<int>> data, {int maxSteps = 500000}) {
    _data = data;
    _width = _data[0].length;
    _height = _data.length;
    _maxSteps = maxSteps;
  }

  int _maxSteps;
  var _StepCount = 0;
  int get StepCount => _StepCount;

  Point _CurrentPoint =  Point<int>(0, 0);
  Point get CurrentPoint => _CurrentPoint;

  Tuple2<bool, Point<int>>  TryNavigate(PietBlock block) {// out result
    Point<int> result;
    if (StepCount > _maxSteps) {
      // todo: aborting purely on step count seems crude - detect cycles rather
      result = Point<int>(0, 0);
      // todo: log warning
      return Tuple2<bool, Point<int>>(false, result);
    }
    int failureCount = 0;

    bool moveStraight = block.Colour == White || !block.KnownColour;

    while (failureCount < 8) {
      Point exitPoint= Point<int>(0, 0);

      if (moveStraight) exitPoint = CurrentPoint;
      else if (Direction == DirectionEnum.East && CodelChooser == CodelChoiceEnum.Left) exitPoint = block.EastLeft;
      else if (Direction == DirectionEnum.East && CodelChooser == CodelChoiceEnum.Right) exitPoint = block.EastRight;

      else if (Direction == DirectionEnum.South && CodelChooser == CodelChoiceEnum.Left) exitPoint = block.SouthLeft;
      else if (Direction == DirectionEnum.South && CodelChooser == CodelChoiceEnum.Right) exitPoint = block.SouthRight;

      else if (Direction == DirectionEnum.West && CodelChooser == CodelChoiceEnum.Left) exitPoint = block.WestLeft;
      else if (Direction == DirectionEnum.West && CodelChooser == CodelChoiceEnum.Right) exitPoint = block.WestRight;

      else if (Direction == DirectionEnum.North && CodelChooser == CodelChoiceEnum.Left) exitPoint = block.NorthLeft;
      else if (Direction == DirectionEnum.North && CodelChooser == CodelChoiceEnum.Right) exitPoint = block.NorthRight;
      else return throw new Exception('common_programming_error_invalid_opcode');

      if (moveStraight) {
        var prevStep = exitPoint;
        while (StillInBlock(exitPoint, block)) {
          prevStep = exitPoint;
          switch (Direction) {
            case DirectionEnum.East:
              exitPoint = Point<int>(exitPoint.x + 1, exitPoint.y);
              break;
            case DirectionEnum.South:
              exitPoint = Point<int>(exitPoint.x, exitPoint.y + 1);
              break;
            case DirectionEnum.West:
              exitPoint = Point<int>(exitPoint.x - 1, exitPoint.y);
              break;
            case DirectionEnum.North:
              exitPoint = Point<int>(exitPoint.x, exitPoint.y - 1);
              break;
            default:
              return throw new Exception('common_programming_error_invalid_opcode');
          }
        }

        // we've crossed the boundary, one step back to be on the edge
        exitPoint = prevStep;
      }

      Point nextStep;
      if (Direction == DirectionEnum.East) nextStep = Point<int>(exitPoint.x + 1, exitPoint.y);
      else if (Direction == DirectionEnum.South) nextStep = Point<int>(exitPoint.x, exitPoint.y + 1);
      else if (Direction == DirectionEnum.West) nextStep = Point<int>(exitPoint.x - 1, exitPoint.y);
      else if (Direction == DirectionEnum.North) nextStep = Point<int>(exitPoint.x, exitPoint.y - 1);
      else  return throw new Exception('common_programming_error_invalid_opcode');;

      bool isOutOfBounds = nextStep.x < 0 ||
          nextStep.y < 0 ||
          nextStep.x >= _width ||
          nextStep.y >= _height;

      // you're blocked if the target is a black codel or you're out of bounds
      bool isBlocked = isOutOfBounds || _data[nextStep.y][nextStep.x] == Black;

      if (!isBlocked) {
        _CurrentPoint = nextStep;
        result = nextStep;
        _StepCount++;
        return Tuple2<bool, Point<int>>(true, result);
      }

      _CurrentPoint = exitPoint;

      if (failureCount % 2 == 0)
        ToggleCodelChooser(1);
      else
        RotateDirectionPointer(1);

      failureCount++;
    }

    result = Point<int>(0,0);
    return Tuple2<bool, Point<int>>(false, result);
  }

  bool StillInBlock(Point exitPoint, PietBlock block) {
    return exitPoint.x >= 0 &&
        exitPoint.y >= 0 &&
        exitPoint.x < _width &&
        exitPoint.y < _height &&
        block.ContainsPixel(Point<int>(exitPoint.x, exitPoint.y));
  }

  /// <summary>
  /// Rotates abs(turns) times. In turns is positive rotates clockwise otherwise counter clockwise
  /// </summary>
  /// <param name="turns">I</param>
  RotateDirectionPointer(int turns) {
    _Direction = DirectionEnum.values.elementAt((Direction.index + turns) % 4);
  }

  ToggleCodelChooser(int times) {
    _CodelChooser = CodelChoiceEnum.values.elementAt((CodelChooser.index + times.abs()) % 2);
  }

}

