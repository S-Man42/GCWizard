// package interpreter;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/ingredient.dart';
/*
import interpreter.Ingredient.State;
*/
class Component {

  State _state;
  int value;

  Component(int n, State s) {
    value = n;
    _state = s;
  }

  Component.Contructor1(Ingredient ingredient) {
    value = ingredient.getAmount();
    _state = ingredient.getstate();
  }

  int getValue() {
    return value;
  }

  void setValue(int n) {
    value = n;
  }

  State getState() {
    return _state;
  }

  void setState(State s) {
    _state = s;
  }

  //@Override
  Component clone() {
    return Component(value, _state);
  }

  void liquefy() {
    _state = State.Liquid;
  }
}