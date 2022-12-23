import 'dart:core';
import 'dart:math';

import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_block.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_blocker_builder.dart';
import 'package:tuple/tuple.dart';

enum Direction { East, South, West, North }

enum CodelChoice { Left, Right }

class PietNavigator {
  var _direction = Direction.East;
  Direction get direction => _direction;

  var _codelChooser = CodelChoice.Left;
  CodelChoice get codelChooser => _codelChooser;

  List<List<int>> _data;

  final int white = knownColors[18];
  final int black = knownColors[19];

  int _width;
  int _height;

  PietNavigator(List<List<int>> data) {
    _data = data;
    _width = _data[0].length;
    _height = _data.length;
  }

  Point _currentPoint = Point<int>(0, 0);
  Point get currentPoint => _currentPoint;

  Tuple2<bool, Point<int>> tryNavigate(PietBlock block) {
    Point<int> result;
    int failureCount = 0;

    bool moveStraight = block.color == white || !block.knownColor;

    while (failureCount < 8) {
      Point exitPoint = Point<int>(0, 0);

      if (moveStraight)
        exitPoint = currentPoint;
      else if (direction == Direction.East && codelChooser == CodelChoice.Left)
        exitPoint = block.eastLeft;
      else if (direction == Direction.East && codelChooser == CodelChoice.Right)
        exitPoint = block.eastRight;
      else if (direction == Direction.South && codelChooser == CodelChoice.Left)
        exitPoint = block.southLeft;
      else if (direction == Direction.South && codelChooser == CodelChoice.Right)
        exitPoint = block.southRight;
      else if (direction == Direction.West && codelChooser == CodelChoice.Left)
        exitPoint = block.westLeft;
      else if (direction == Direction.West && codelChooser == CodelChoice.Right)
        exitPoint = block.westRight;
      else if (direction == Direction.North && codelChooser == CodelChoice.Left)
        exitPoint = block.northLeft;
      else if (direction == Direction.North && codelChooser == CodelChoice.Right)
        exitPoint = block.northRight;
      else
        return throw Exception('common_programming_error_invalid_opcode');

      if (moveStraight) {
        var prevStep = exitPoint;
        while (_stillInBlock(exitPoint, block)) {
          prevStep = exitPoint;
          switch (direction) {
            case Direction.East:
              exitPoint = Point<int>(exitPoint.x + 1, exitPoint.y);
              break;
            case Direction.South:
              exitPoint = Point<int>(exitPoint.x, exitPoint.y + 1);
              break;
            case Direction.West:
              exitPoint = Point<int>(exitPoint.x - 1, exitPoint.y);
              break;
            case Direction.North:
              exitPoint = Point<int>(exitPoint.x, exitPoint.y - 1);
              break;
            default:
              return throw Exception('common_programming_error_invalid_opcode');
          }
        }
        // we've crossed the boundary, one step back to be on the edge
        exitPoint = prevStep;
      }

      Point nextStep;
      if (direction == Direction.East)
        nextStep = Point<int>(exitPoint.x + 1, exitPoint.y);
      else if (direction == Direction.South)
        nextStep = Point<int>(exitPoint.x, exitPoint.y + 1);
      else if (direction == Direction.West)
        nextStep = Point<int>(exitPoint.x - 1, exitPoint.y);
      else if (direction == Direction.North)
        nextStep = Point<int>(exitPoint.x, exitPoint.y - 1);
      else
        return throw Exception('common_programming_error_invalid_opcode');

      bool isOutOfBounds = nextStep.x < 0 || nextStep.y < 0 || nextStep.x >= _width || nextStep.y >= _height;

      // you're blocked if the target is a black codel or you're out of bounds
      bool isBlocked = isOutOfBounds || _data[nextStep.y][nextStep.x] == black;

      if (!isBlocked) {
        _currentPoint = nextStep;
        result = nextStep;
        return Tuple2<bool, Point<int>>(true, result);
      }

      _currentPoint = exitPoint;

      if (failureCount % 2 == 0)
        toggleCodelChooser(1);
      else
        rotateDirectionPointer(1);

      failureCount++;
    }

    result = Point<int>(0, 0);
    return Tuple2<bool, Point<int>>(false, result);
  }

  bool _stillInBlock(Point exitPoint, PietBlock block) {
    return exitPoint.x >= 0 &&
        exitPoint.y >= 0 &&
        exitPoint.x < _width &&
        exitPoint.y < _height &&
        block.containsPixel(Point<int>(exitPoint.x, exitPoint.y));
  }

  /// <summary>
  /// Rotates abs(turns) times. In turns is positive rotates clockwise otherwise counter clockwise
  /// </summary>
  /// <param name="turns">I</param>
  void rotateDirectionPointer(int turns) {
    _direction = Direction.values[(direction.index + turns) % 4];
  }

  void toggleCodelChooser(int times) {
    _codelChooser = CodelChoice.values[(codelChooser.index + times.abs()) % 2];
  }
}
