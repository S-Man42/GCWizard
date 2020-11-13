
enum State {Dry, Liquid}

class Ingredient {

  String _name;
  int _amount;
  State _state;

  Ingredient(String ingredient)  {
    var tokens = ingredient.replaceAll('-', ' ').split(" ");
    // token[0] = amount
    // token[1] = measurement or name
print('analyse INGREDIENT ['+tokens.join('.')+']');
    int i = 0;
    _state = State.Dry;
    if (RegExp(r"^[0-9]+").hasMatch(tokens[i])) {
      _amount = int.parse(tokens[i]);
      i++;
      if (RegExp(r"^heaped|^level|^gestrichen|^gehäuft").hasMatch(tokens[i])) {
        _state = State.Dry;
        i++;
      } else if (RegExp(r"^g$|^kg$|^pinch(es)?|^prise(n)?").hasMatch(tokens[i])) {
        _state = State.Dry;
        i++;
      } else if (RegExp(r"^ml$|^l$|^dash(es)?|^spritzer").hasMatch(tokens[i])) {
        _state = State.Liquid;
        i++;
      } else if (RegExp(r"^cup(s)?|^teaspoon(s)?|^tablespoon(s)?|^teelöffel|^esslöffel").hasMatch(tokens[i])) {
        i++;
      }
    } else {
      _amount = 0;
      _state = State.Dry;
    }
    _name = "";
    while (i < tokens.length) {
      _name = _name + tokens[i] + (i == tokens.length-1 ? "" : " ");
      i++;
    }
    if (_name == "") {
      _name = 'INVALID';
      //throw  ChefException.Contructor1(ChefException.INGREDIENT, tokens, "ingredient name missing");
    }
print('ingredient found '+_name+'.'+_amount.toString());
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

  State getState() {
    return _state;
  }

  void setState(State s) {
    _state = s;
  }

  void liquefy() {
print(_name + '.'+_state.toString());
    _state = State.Liquid;
print(_name + '.'+_state.toString());
  }

  void dry() {
    _state = State.Dry;
  }

  String getName() {
    return _name;
  }

  void setName(String n){
    _name = n;
  }

}