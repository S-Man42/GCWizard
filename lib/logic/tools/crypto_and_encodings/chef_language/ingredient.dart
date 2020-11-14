
enum State {Dry, Liquid}

class Ingredient {

  String _name;
  int _amount;
  State _state;
  bool _error;
  List<String> _errorList;

  Ingredient(String ingredient)  {
    _errorList = new List<String>();

    var tokens = ingredient.replaceAll('-', ' ').split(' ');
    int i = 0;
    _state = State.Dry;
    if (RegExp(r"^([0-9]+)[ a-z]*").hasMatch(tokens[i])) {
      _amount = int.parse(RegExp(r"^([0-9]+)[ a-zäöüß]*").firstMatch(tokens[i]).group(1));
      i++;
      if (i < tokens.length) {
        if (RegExp(r"^heaped|^level|^gestrichen|^gehäuft").hasMatch(
            tokens[i])) {
          _state = State.Dry;
          i++;
        } else
        if (RegExp(r"^g(r)?$|^kg$|^pinch(es)?|^prise(n)|^scheibe(n)?").hasMatch(tokens[i])) {
          _state = State.Dry;
          i++;
        } else
        if (RegExp(r"^ml$|^l$|^dash(es)?|^spritzer").hasMatch(tokens[i])) {
          _state = State.Liquid;
          i++;
        } else if (RegExp(
            r"^cup(s)?|^teaspoon(s)?|^tablespoon(s)?|^teelöffel|^esslöffel")
            .hasMatch(tokens[i])) {
          i++;
        }
      } else {
        _name = 'INVALID';
      }
    } else { // no amount
      _amount = 0;
      _state = State.Dry;
    }
    _name = '';
    while (i < tokens.length) {
      _name = _name + tokens[i] + (i == tokens.length - 1 ? '' : ' ');
      i++;
    }
    if (_name == "") {
      _name = 'INVALID';
    }
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
    _state = State.Liquid;
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

  bool isValid(){
    return _error;
  }

  List<String> getError(){
    return _errorList;
  }
}