import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/logic/ingredient.dart';

class Component {
  State _state;
  int _value;
  String _name;

  Component(int n, State s, String name) {
    _value = n;
    _state = s;
    _name = name;
  }

  Component.Contructor1(Ingredient ingredient) {
    _value = ingredient.getAmount();
    _state = ingredient.getState();
    _name = ingredient.getName();
  }

  int getValue() {
    return _value;
  }

  void setValue(int n) {
    _value = n;
  }

  State getState() {
    return _state;
  }

  void setState(State s) {
    _state = s;
  }

  String getName() {
    return _name;
  }

  void setName(String n) {
    _name = n;
  }

  //@Override
  Component clone() {
    return Component(_value, _state, _name);
  }

  void liquefy() {
    _state = State.Liquid;
  }
}
