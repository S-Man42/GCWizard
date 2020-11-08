import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chefException.dart';
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

  Recipe(String title) {
    this.title = title;
  }

  void setIngredients(String ingredients) {//throws ChefException
    this.ingredients = Map<String, Ingredient>();
    var i=0;

    ingredients.split("\n").forEach((ingredient) {
      //Clearing the 'Ingredients.' header
      if (i > 0) {
        Ingredient ing = new Ingredient(ingredient);
        this.ingredients.addAll({ing.getName().toLowerCase(): ing});
      }
      i++;
    });
  }

  void setComments(String comment) {
    this.comment = comment;
  }

  void setMethod(String method) {//throws ChefException
    this.methods = List<Method>();
    // method = method.replaceAll("\n", "");
    // method = method.replaceAll(". ",".");
    // method = method.replaceAll("\\. ",".");
    // var scanner =  RegExp(r"\\.");
    List<String> scanner = method.replaceAll("\n", "").replaceAll(". ",".").split('.');
print(scanner);
    for(int i = 1; i < scanner.length - 1; i++){
      this.methods.add(new Method(scanner[i], i));
    };
    //var i = 0;
    //scanner.forEach((meth) {
    //Clearing the 'Method.' header
    //scanner.allMatches(method).forEach((meth) {
      //this.methods.add(new Method(method.substring(meth.start, meth.end), i));
      //if ((i > 0) && (i < scanner.length))
      //  this.methods.add(new Method(meth, i));
      //i++;
    //});
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
    this.serves = int.parse(serves.substring(("Serves ").length, serves.length-1));
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