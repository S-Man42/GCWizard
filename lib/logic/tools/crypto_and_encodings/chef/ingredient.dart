enum State {Dry, Liquid}

class Ingredient {

  String name;
  int amount;
  State state;

  defineIngredient(int n, State s, String name) {
    this.amount = n;
    this.state = s;
    this.name = name;
  }

  Ingredient(String ingredient) {
    List<String> tokens = ingredient.split(" ");
    RegExp expr = new RegExp('^\\d*\$');
    int i = 0;
    state = State.Dry;
    if (expr.hasMatch(tokens[i])) {
      amount = int.parse(tokens[i]);
      i++;
      if ((tokens[i] == 'level') || (tokens[i] == 'heaped')) {
        state = State.Dry;
        i++;
      }
      expr = RegExp('^g|kg|pinch(es)?');
      if (expr.hasMatch(tokens[i])) {
        state = State.Dry;
        i++;
      } else {
        expr = RegExp('^ml|l|dash(es)?');
        if (expr.hasMatch(tokens[i])) {
          state = State.Liquid;
          i++;
      } else {
          expr = RegExp('^cup(s)?|teaspoon(s)?|tablespoon(s)?');
          if (expr.hasMatch(tokens[i])) {
            i++;
          }
        }
      }
    }
    name = "";
    while (i < tokens.length) {
      name += tokens[i] + (i == tokens.length-1 ? "" : " ");
      i++;
    }
    if (name == "") {
    //throw new ChefException(ChefException.INGREDIENT, tokens, "ingredient name missing");
    }
  }


  int getAmount() {
    return amount;
  }

  void setAmount(int n) {
    amount = n;
  }

  State getstate() {
    return state;
  }

  void liquefy() {
    this.state = State.Liquid;
  }

  void set setState(State s) {
    this.state = s;
  }

  void dry() {
    this.setState = State.Dry;
  }

  String getName() {
    return name;
  }

}
