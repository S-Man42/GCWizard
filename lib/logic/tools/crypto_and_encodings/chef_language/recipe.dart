import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/method.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/ingredient.dart';
import 'package:intl/intl.dart';

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
  List<String> errorList;

  Recipe(String title) {
    this.title = title;
    this.comment = '';
    this.serves = 0;
    this.error = false;
    this.errorList = new List<String>();
  }

  void setIngredients(String Input) {
    var f = new NumberFormat('###');
print('RECIPE setIngredients [' + Input+']');
    this.ingredients = Map<String, Ingredient>();
    var i=0;
    List<String> ingredientsInput = Input.split('\n');
    ingredientsInput.forEach((ingredientLine) {
print('line ' + i.toString()+' ' + ingredientLine);
      //Clearing the 'Ingredients.' header
      if (i > 0) {
        Ingredient ing = new Ingredient(ingredientLine);
print('       => '+ing.getName()+'.'+ing.getAmount().toString());
        if (ing.getName() == 'INVALID') {
print('       => error = true => return');
          error = true;
          this.errorList.add('chef_error_syntax');
          this.errorList.add('chef_error_syntax_ingredient');
          this.errorList.add('chef_error_syntax_ingredient_name');
          this.errorList.add(f.format(i).toString() + ' : ' + ingredientLine);
          this.errorList.add('');
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
print('RECIPE setComments '+comment);
    this.comment = comment;
  }

  void setMethod(String method, language) {
    var f = new NumberFormat('###');
print('RECIPE setMethods '+method);
    this.methods = List<Method>();
    List<String> scanner = method.replaceAll("\n", "").replaceAll(". ",".").split('.');
    for(int i = 1; i < scanner.length - 1; i++){
      var m = new Method(scanner[i], i, language);
      if (m.type != Type.Invalid)
        this.methods.add(m);
      else {
        this.error = true;
        this.errorList.add('chef_error_syntax');
        this.errorList.add('chef_error_syntax_method');
        this.errorList.add(f.format(i).toString() + ' : ' + scanner[i]);
        this.errorList.add('');
      }
    };
  }

  void setCookingTime(String cookingtime) {
print(cookingtime.split(' '));
    RegExp expr = new RegExp(r'^(cooking time: |kochzeit: )(\d*)( minute(s)?| minute(n)?| hour(s)?| stunde(n)?)\.$');
    if (expr.hasMatch(cookingtime)) {
      this.serves = int.parse(expr.firstMatch(cookingtime).group(2));
    } else {
      this.error = true;
      errorList.add('chef_error_syntax');
      errorList.add('chef_error_syntax_cooking_time');
      errorList.add(cookingtime);
      errorList.add('');
    }
  }

  void setOvenTemp(String oventemp) {
print(oventemp.split(' '));
    RegExp expr = new RegExp(r'^(pre-heat oven to |vorheizen des ofens auf )(\d*)( (grad|degrees) celsius)?( gas (mark|skala) (\d*))?\.$');
    if (expr.hasMatch(oventemp)) {
      this.serves = int.parse(expr.firstMatch(oventemp).group(2));
      if (expr.firstMatch(oventemp).group(7)!= null) {
        this.gasmark = int.parse(expr.firstMatch(oventemp).group(7));
      }
    } else {
      this.error = true;
      errorList.add('chef_error_syntax');
      errorList.add('chef_error_syntax_oven_temperature');
      errorList.add(oventemp);
      errorList.add('');
    }
  }

  void setServes(String serves) {
    if (RegExp(r'(serves |portionen )(\d*)(\.)$').hasMatch(serves)) {
      this.serves = int.parse(RegExp(r'(serves |portionen )(\d*)(\.)$').firstMatch(serves).group(2));
    } else {
      this.error = true;
      errorList.add('chef_error_syntax');
      errorList.add('chef_error_syntax_serves');
      errorList.add('chef_error_syntax_serves_without_number');
      errorList.add(serves);
      errorList.add('');
    }
print('RECIPE setServes '+this.serves.toString());
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