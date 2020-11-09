import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/method.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/ingredient.dart';

class Recipe {

  String title;
  Map<String, Ingredient> ingredients;
  String comment;
  int cookingtime;
  int oventemp;
  int gasmark;
  List<Method> methods;
  int serves;
  bool error;

  Recipe(String title) {
    this.title = title;
    this.error = false;
  }

  void setIngredients(String ingredients) {//throws ChefException
    this.ingredients = Map<String, Ingredient>();
    var i=0;

    ingredients.split("\n").forEach((ingredient) {
      //Clearing the 'Ingredients.' header
      if (i > 0) {
print('RECIPE setIngredient '+ingredient);
        Ingredient ing = new Ingredient(ingredient);
print('       => '+ing.getName()+'.'+ing.getAmount().toString());
        if (ing.getName() == 'INVALID') {
print('       => error = true => return');
          error = true;
          return;
        } else {
          error = false;
          this.ingredients.addAll({ing.getName().toLowerCase(): ing});
        }
      }
      i++;
    });
  }

  void setComments(String comment) {
    this.comment = comment;
  }

  void setMethod(String method) {
    this.methods = List<Method>();
    List<String> scanner = method.replaceAll("\n", "").replaceAll(". ",".").split('.');
    for(int i = 1; i < scanner.length - 1; i++){
      var m = new Method(scanner[i], i);
      if (m.type != Type.Invalid)
        this.methods.add(m);
    };
  }

  void setCookingTime(String cookingtime) {
    this.cookingtime = int.parse(cookingtime.split(" ")[2]);
  }

  void setOvenTemp(String oventemp) {
    this.oventemp = int.parse(oventemp.split(" ")[3]);
    if (oventemp.contains("gas mark")) {
      String mark = oventemp.split(" ")[8];
      this.gasmark = int.parse(mark.substring(0, mark.length-1));
    }
  }

  void setServes(String serves) {
    this.serves = int.parse(RegExp(r'(serves )(\d*)(\.)*').firstMatch(serves).group(2));
  }

  int getServes() {
    return serves;
  }

  String getTitle() {
    return title;
  }

  int getIngredientValue(String s) {
    return ingredients[s].getAmount();
  }

  void setIngredientValue(String s, int n) {
    ingredients[s].setAmount(n);
  }

  Method getMethod(int i) {
    return methods[i];
  }

  List<Method> getMethods() {
    return methods;
  }

  Map<String,Ingredient> getIngredients() {
    return ingredients;
  }
}