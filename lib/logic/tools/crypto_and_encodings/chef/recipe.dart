import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef/ingredient.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef/method.dart';

class Recipe {

  String title;
  Map<String,Ingredient> ingredients;
  String comment;
  int cookingtime;
  int oventemp;
  int gasmark;
  List<Method> methods;
  int serves;

  Recipe(String title)
  {
    this.title = title;
  }

  void set setIngredients(String ingredients) {
    this.ingredients = new Map<String, Ingredient>();
    var scanner = ingredients.split("\n");
    scanner.forEach((element) {
      Ingredient ing = new Ingredient(element);
      this.ingredients[ing.getName().toLowerCase()] = ing;
    });
  }

  void set setComments(String comment){
    this.comment = comment;
  }

  void set setMethod(String method) {
    this.methods = new List<Method>();
    method = method.replaceAll("\n", "").replaceAll("\\. ",".");
    List<String> scanner = method.split('\\.');
    //Clearing the 'Method.' header
    int i = 0;
    scanner.forEach((element) {
      this.methods.add(new Method(element + ".", i));
      i++;
    });
  }

  void set setCookingTime(String cookingtime){
    this.cookingtime = int.parse(cookingtime.split(" ")[2]);
  }

  void set setOvenTemp(String oventemp){
    this.oventemp = int.parse(oventemp.split(" ")[3]);
    if (oventemp == 'gas mark') {
      String mark = oventemp.split(" ")[8];
      this.gasmark = int.parse(mark);
    }
  }

  void set setServes(String serves) {
    this.serves = int.parse(serves.split('serves ')[0]);
  }

  int get getServes{
    return serves;
  }

  String get getTitle {
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

  List<Method> get getMethods {
    return methods;
  }

  Map<String,Ingredient> get getIngredients {
    return ingredients;
  }
}

