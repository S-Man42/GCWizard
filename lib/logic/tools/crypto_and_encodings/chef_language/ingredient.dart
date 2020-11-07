import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chefException.dart';

enum State {
  Dry, Liquid
}

class Ingredient {

  String _name;
  int _amount;
  State _state;

  Ingredient(String ingredient)  { //throws ChefException
    var tokens = ingredient.split(" ");
    int i = 0;
    _state = State.Dry;
    if (RegExp(r"^\d*$").hasMatch(tokens[i])) {
      _amount = int.parse(tokens[i]);
      i++;
      if (RegExp(r"heaped|level").hasMatch(tokens[i])) {
        _state = State.Dry;
        i++;
      }
      if (RegExp(r"^g|kg|pinch(es)?").hasMatch(tokens[i])) {
        _state = State.Dry;
        i++;
      }
      else if (RegExp(r"^ml|l|dash(es)?").hasMatch(tokens[i])) {
        _state = State.Liquid;
        i++;
      }
      else if (RegExp(r"^cup(s)?|teaspoon(s)?|tablespoon(s)?").hasMatch(tokens[i])) {
        i++;
      }
    }
    _name = "";
    while (i < tokens.length) {
      _name += tokens[i] + (i == tokens.length-1 ? "" : " ");
      i++;
    }
    if (_name == "") {
      throw  ChefException.Contructor1(ChefException.INGREDIENT, tokens, "ingredient name missing");
    }
  }

  Ingredient.Contructor1(int n, State s, String name) {
    this._amount = n;
    this._state = s;
    this._name = name;
  }

  int getAmount() {
    return _amount;
  }

  void setAmount(int n) {
    _amount = n;
  }

  State getstate() {
    return _state;
  }

  void liquefy() {
    _state = State.Liquid;
  }

  void dry() {
    _state = State.Dry;
  }

  String getName() {
    return _name;
  }

  void setState(State s) {
    _state = s;
  }
}