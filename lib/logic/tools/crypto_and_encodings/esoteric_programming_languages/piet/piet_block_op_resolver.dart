import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/base_operations.dart';
import 'package:tuple/tuple.dart';

enum HueColour {
  Red,
  Yellow,
  Green,
  Cyan,
  Blue,
  Magenta
}

enum Darkness {
  Light,
  Normal,
  Dark
}

class PietBlockOpResolver {
  /// <summary>
  /// Calculates the operation signified by the transition from block1 to block2
  /// </summary>
  /// <param name="block1">The egress block</param>
  /// <param name="block2">The ingress block</param>
  /// <returns>An operation</returns>
  PietOps Resolve(PietBlock block1, PietBlock block2) {
    var ret1 = _TryResolveColour(block1.Colour);
    var ret2 = _TryResolveColour(block2.Colour);
    var colour1 = ret1.item2;
    var colour2 = ret2.item2;
    if (ret1.item1 && ret2.item1) {
      int lightShift = colour2.item2.index - colour1.item2.index;
      if (lightShift < 0)
        lightShift += 3;

      int colourShift = colour2.item1.index - colour1.item1.index;
      if (colourShift < 0)
        colourShift += 6;

      var comparePoint      =  Point<int>(colourShift, lightShift);
      if (comparePoint      == Point<int>(0, 0)) return PietOps.Noop;
      else if (comparePoint == Point<int>(0, 1)) return PietOps.Push;
      else if (comparePoint == Point<int>(0, 2)) return PietOps.Pop;
      else if (comparePoint == Point<int>(1, 0)) return PietOps.Add;
      else if (comparePoint == Point<int>(1, 1)) return PietOps.Subtract;
      else if (comparePoint == Point<int>(1, 2)) return PietOps.Multiply;
      else if (comparePoint == Point<int>(2, 0)) return PietOps.Divide;
      else if (comparePoint == Point<int>(2, 1)) return PietOps.Mod;
      else if (comparePoint == Point<int>(2, 2)) return PietOps.Not;
      else if (comparePoint == Point<int>(3, 0)) return PietOps.Greater;
      else if (comparePoint == Point<int>(3, 1)) return PietOps.Pointer;
      else if (comparePoint == Point<int>(3, 2)) return PietOps.Switch;
      else if (comparePoint == Point<int>(4, 0)) return PietOps.Duplicate;
      else if (comparePoint == Point<int>(4, 1)) return PietOps.Roll;
      else if (comparePoint == Point<int>(4, 2)) return PietOps.InputNumber;
      else if (comparePoint == Point<int>(5, 0)) return PietOps.InputChar;
      else if (comparePoint == Point<int>(5, 1)) return PietOps.OutputNumber;
      else if (comparePoint == Point<int>(5, 2)) return PietOps.OutputChar;
      else throw new Exception('common_programming_error_invalid_opcode');
    }

    return PietOps.Noop;
  }

  Tuple2<bool, Tuple2<HueColour, Darkness>> _TryResolveColour(int colour) {
    switch (colour) {
    // red
      case 0xFFC0C0:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Light));
      case 0xFF0000:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Normal));
      case 0xC00000:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Dark));
    // yellow
      case 0xFFFFC0:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Yellow, Darkness.Light));
      case 0xFFFF00:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Yellow, Darkness.Normal));
      case 0xC0C000:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Yellow, Darkness.Dark));
    // green
      case 0xC0FFC0:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Green, Darkness.Light));
      case 0x00FF00:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Green, Darkness.Normal));
      case 0x00C000:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Green, Darkness.Dark));
    //cyan
      case 0xC0FFFF:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Cyan, Darkness.Light));
      case 0x00FFFF:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Cyan, Darkness.Normal));
      case 0x00C0C0:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Cyan, Darkness.Dark));
    //blue
      case 0xC0C0FF:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Blue, Darkness.Light));
      case 0x0000FF:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Blue, Darkness.Normal));
      case 0x0000C0:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Blue, Darkness.Dark));
    //magenta
      case 0xFFC0FF:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Magenta, Darkness.Light));
      case 0xFF00FF:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Magenta, Darkness.Normal));
      case 0xC000C0:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(true, Tuple2<HueColour, Darkness>(HueColour.Magenta, Darkness.Dark));
      default:
        return Tuple2<bool, Tuple2<HueColour, Darkness>>(false, Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Light)); // default
    }
  }
}

