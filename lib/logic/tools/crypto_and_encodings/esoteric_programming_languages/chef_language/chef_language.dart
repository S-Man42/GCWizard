import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/kitchen.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/recipe.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/primes/primes.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/chef_international.dart';

List<String> _getAuxiliaryRecipe(String name, int value, List<String> ingredientOne, ingredientTwo, String language){
  List<String> output = new List<String>();
  bool combine = true;
  List<BigInt> nList = new List<BigInt>();
  int nOne = 0;
  int nTwo = 0;

  if (isPrime(BigInt.from(value))) {
    combine = false;
    nOne = value ~/ 5 * 2;
    nTwo = value - nOne;
  } else {
    combine = true;
    nList = integerFactorization(value);
    if (nList.length != 2) {
      nOne = value;
      for (int i = 0; i < nList.length - 1; i++){
        if (nOne > sqrt(value))
          nOne = nOne ~/ nList[i].toInt();
        else
          break;
      }
      nTwo = value ~/ nOne;
    } else {
      nOne = nList[0].toInt();
      nTwo = nList[1].toInt();
    }
  }
  output.add(name);
  output.add('');
  output.add(getText(textId.Ingredients, '', language));
  output.add(nOne.toString() + ' ' + ingredientOne[0] + ' ' + ingredientOne[1]);
  output.add(nTwo.toString() + ' ' + ingredientTwo[0] + ' ' + ingredientTwo[1]);
  output.add('');
  output.add(getText(textId.Method, '', language));
  output.add(getText(textId.Put, ingredientOne[1], language));
  if (combine)
    output.add(getText(textId.Combine, ingredientTwo[1], language));
  else
    output.add(getText(textId.Add, ingredientTwo[1], language));
  return output;
}


String generateChef(String language, title, String remark, String time, String temperature, String outputToGenerate, bool auxiliary){
  var output = StringBuffer();
  List<String> outputElements = new List<String>();
  List<String> methodList = new List<String>();
  List<String> ingredientList = new List<String>();
  Map <String, List<String>> auxiliaryRecipes = new Map <String, List<String>>();
  Map<int, String> amount = new Map<int, String>();
  Map<String, String> ingredientListed = new Map<String, String>();
  int value = 0;
  int i = 0;
  List<String> itemList = new List<String>();
  List<String> itemListLiquid= new List<String>();
  List<String> itemListDry = new List<String>();
  List<List<String>> itemListAuxiliary = new List<List<String>>();
  List<String> itemListMeasuresLiquid= new List<String>();
  List<String> itemListMeasuresDry = new List<String>();
  List<String> itemListMeasure = new List<String>();

  String item = '';  
  String measure = '';
  String auxiliaryName = '';
  
  List<String> ingredientOne = new List<String>();
  List<String> ingredientTwo = new List<String>();
  
  RegExp expr = new RegExp(r'(([\D]+)|([\d]+))+?');

  Random random = new Random();

  if (language == 'ENG') {
    itemListDry.addAll(itemListDryENG);
    itemListLiquid.addAll(itemListLiquidENG);
    itemListAuxiliary.addAll(itemListAuxiliaryENG);
    itemListMeasure.addAll(measuresENG);
    itemListMeasuresLiquid.addAll(liquidMeasuresENG);
    itemListMeasuresDry.addAll(dryMeasuresENG);
  } else {
    itemListDry.addAll(itemListDryDEU);
    itemListLiquid.addAll(itemListLiquidDEU);
    itemListAuxiliary.addAll(itemListAuxiliaryDEU);
    itemListMeasure.addAll(measuresDEU);
    itemListMeasuresLiquid.addAll(liquidMeasuresDEU);
    itemListMeasuresDry.addAll(dryMeasuresDEU);
  }

  if (auxiliary) { // build auxilay recipes
    if (language == 'ENG'){
      amount[32] = 'ambergris';
      ingredientList.add(32.toString() + ' ml ambergris');
    } else {
      amount[32] = 'Ambra';
      ingredientList.add(32.toString() + ' ml Ambra');
    }

    expr.allMatches(outputToGenerate).forEach((match) {
      if (match.group(1) != null) {
        outputElements.add(match.group(1));
      }
    });

    for (i = 0; i < outputElements.length / 2; i++) {
      var temp = outputElements[i];
      if (int.tryParse(temp) == null)
        temp = temp.split('').reversed.join('');
      if (int.tryParse(outputElements[outputElements.length - 1 - i]) == null)
        outputElements[i] = outputElements[outputElements.length - 1 - i].split('').reversed.join('');
      else
        outputElements[i] = outputElements[outputElements.length - 1 - i];
      outputElements[outputElements.length - 1 - i] = temp;
    }

    i = 0;
    outputElements.forEach((element) {
      if (int.tryParse(element) != null) { // element is a number
        value = int.parse(element);

        if (value < 10) { // => digit 0-9 => store charcode 48 - 57 => liquid
          value = element.codeUnitAt(0);
          if (amount[value] == null) { // a new digit
            item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length));
            measure = itemListMeasuresLiquid.elementAt(random.nextInt(itemListMeasuresLiquid.length));
            while (ingredientListed[item] != null) {
              item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length));
            }
            ingredientListed[item] = item;
            ingredientList.add(value.toString() + ' ' + measure + ' ' +  item);
            amount[value] = item;
            methodList.add(getText(textId.Put, amount[value], language));
          } else { // digit was already processed
            methodList.add(getText(textId.Put, amount[value], language));
          }

        } else if (value < 100) { // => number 10-99 => store charcode 10 - 99 => dry, unspecific
          if (amount[value] == null) { // a new number
            item = itemListDry.elementAt(random.nextInt(itemListDry.length));
            measure = itemListMeasuresDry.elementAt(random.nextInt(itemListMeasuresDry.length));
            while (ingredientListed[item] != null) {
              item = itemListDry.elementAt(random.nextInt(itemListDry.length));
            }
            ingredientListed[item] = item;
            ingredientList.add(value.toString() + ' ' + measure + ' ' + item);
            amount[value] = item;
            methodList.add(getText(textId.Put, amount[value], language));
          } else { // number was already processed
            methodList.add(getText(textId.Put, amount[value], language));
          }

        } else { // => auxiliary recipe to provide number: pour, clean, serve with, pour

            auxiliaryName = itemListAuxiliary[0][random.nextInt(4)] + itemListAuxiliary[1][random.nextInt(4)] + itemListAuxiliary[2][random.nextInt(4)] + itemListAuxiliary[3][random.nextInt(4)];
            while (auxiliaryRecipes[auxiliaryName] != null) {
              auxiliaryName = itemListAuxiliary[0][random.nextInt(4)] + itemListAuxiliary[1][random.nextInt(4)] + itemListAuxiliary[2][random.nextInt(4)] + itemListAuxiliary[3][random.nextInt(4)];
            }
            ingredientOne = [itemListMeasuresDry.elementAt(random.nextInt(itemListMeasuresDry.length)), itemListDry.elementAt(random.nextInt(itemListDry.length))];
            ingredientTwo = [itemListMeasuresDry.elementAt(random.nextInt(itemListMeasuresDry.length)), itemListDry.elementAt(random.nextInt(itemListDry.length))];
            while (ingredientTwo.elementAt(1) == ingredientOne.elementAt(1)) {
              ingredientTwo = [itemListMeasuresDry.elementAt(random.nextInt(itemListMeasuresDry.length)), itemListDry.elementAt(random.nextInt(itemListDry.length))];
            }
            auxiliaryRecipes[auxiliaryName] = _getAuxiliaryRecipe(auxiliaryName, value, ingredientOne, ingredientTwo, language);
            if (i > 0) {
              methodList.add(getText(textId.Pour, '', language));
              methodList.add(getText(textId.Clean, '', language));
            }
            methodList.add(getText(textId.Serve_with, auxiliaryName, language));
        }
      } else { // element is a string of non-digits  => Liquid
        List<String> Elements = element.split('');
        Elements.forEach((element) {
          value = element.codeUnitAt(0);
          if (amount[value] == null) { // a new character
            item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length)); // get liquid item [measure,name]
            measure = itemListMeasuresLiquid.elementAt(random.nextInt(itemListMeasuresLiquid.length));

            while (ingredientListed[item] != null) { // ingredient already in use
              item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length));
            }
            ingredientListed[item] = item;
            ingredientList.add(value.toString() + ' ' + measure + ' ' +  item);
            amount[value] = item;
            methodList.add(getText(textId.Put, amount[value], language));
          } else { // character was already processed
            methodList.add(getText(textId.Put, amount[value], language));
          }
        });
      }
      i++;
    }); // outputElements.forEach((element)
  } else { // build "normal" linear recipe
    itemList.addAll(itemListDry);
    itemList.addAll(itemListLiquid);
    itemListMeasure.addAll(itemListMeasuresDry);
    itemListMeasure.addAll(itemListMeasuresLiquid);

    outputElements = outputToGenerate.split('');
    for (int i = 0; i < outputElements.length / 2; i++) {
      var temp = outputElements[i];
      outputElements[i] = outputElements[outputElements.length - 1 - i];
      outputElements[outputElements.length - 1 - i] = temp;
    }
    outputElements.forEach((element) {
      value = element.codeUnitAt(0);
      if (amount[value] == null) {
        item = itemList.elementAt(random.nextInt(itemList.length));
        measure = itemListMeasure.elementAt(random.nextInt(itemListMeasure.length));
        while (ingredientListed[item] != null) {
          item = itemList.elementAt(random.nextInt(itemList.length));
        }
        ingredientListed[item] = item;
        ingredientList.add(value.toString() + ' ' + measure + ' ' +  item);
        amount[value] = item;
        methodList.add(getText(textId.Put, amount[value], language));
      } else {
        methodList.add(getText(textId.Put, amount[value], language));
      }
    });
  }

  output.writeln(title + '.');
  output.writeln('');
  if (remark != '') output.writeln(remark + '\n');
  output.writeln(getText(textId.Ingredients, '', language) );
  output.writeln(ingredientList.join('\n'));
  output.writeln('');
  if (int.tryParse(time) != null) {
    output.writeln(getText(textId.Cooking_time, time, language) + '\n');
  }
  if (int.tryParse(temperature) != null) {
    output.writeln(getText(textId.Pre_heat_oven, temperature, language) + '\n');
  }
  output.writeln(getText(textId.Method, '', language));
  output.writeln(methodList.join('\n'));
  if (!auxiliary)
    output.writeln(getText(textId.Liquefy_contents, '', language));
  output.writeln(getText(textId.Pour, '', language));
  output.writeln('');
  output.writeln(getText(textId.Serves, '', language));

  auxiliaryRecipes.forEach((key, value) {
    output.writeln('\n');
    for (int i = 0; i < value.length; i++){
      output.writeln(value[i]);
    }
  });
  if (auxiliaryRecipes.length > 0) {
  }
  return output.toString().replaceAll('  ', ' ');
}


bool isValid(String input){
  bool flag = true;
  if (input == null || input == '')
    return true;
  List<String> numbers = input.split(' ');
  numbers.forEach((element) {
    if (int.tryParse(element) == null) {
      flag = false;
    }
  });
  return flag;
}


List<String> interpretChef(String language, recipe, input) {
  if (recipe == null || recipe == '')
    return new List<String>();

  return decodeChef(language, recipe, input);
}


List<String> decodeChef(String language, recipe, additionalIngredients)  {
  Chef interpreter = Chef(recipe, language);
  if (interpreter.valid) {
    interpreter.bake(language, additionalIngredients);
    if (interpreter.valid)
      return interpreter.meal;
    else // runtime error
      return interpreter.error;
  } else { // invalid recipe
    return interpreter.error;
  }
}


class Chef {

  Map<String, Recipe> recipes;
  Recipe mainrecipe;
  List<String> error;
  bool valid;
  List<String> meal;

  Chef(String readRecipe, language) {
    this.meal = new List<String>();    valid = true;
    error = new List<String>();
    recipes = new Map<String, Recipe>();
    int progress = 0;
    Recipe r = null;
    String title = '';
    String line = '';
    bool mainrecipeFound = false;
    bool progressError = false;
    bool ingredientsFound = false;
    bool methodsFound = false;
    bool servesFound = false;
    bool refrigerateFound = false;

    readRecipe.split("\n\n").forEach((element) {
      line = element.trim();
      if (line.startsWith("ingredients") || line.startsWith("zutaten")) {
        if (progress > 3) {
          valid = false;
          _addError(2, progress);
          return '';
        }
        progress = 3;
        r.setIngredients(line);
        ingredientsFound = true;
        if (r.error) {
          this.error.addAll(r.errorList);
          valid = false;
          return '';
        }
      }
      else if (line.startsWith("cooking time") || line.startsWith("garzeit")) {
        if (progress > 4) {
          valid = false;
          _addError(3, progress);
          return '';
        }
        progress = 4;
        r.setCookingTime(line);
        if (r.error){
          this.error.addAll(r.errorList);
          this.valid = false;
          return '';
        }
      }
      else if (line.startsWith("pre-heat oven") || line.startsWith("pre heat oven") || line.startsWith("ofen auf")) {
        if (progress > 5) {
          valid = false;
          _addError(4, progress);
          return '';
        }
        progress = 5;
        r.setOvenTemp(line);
        if (r.error){
          this.error.addAll(r.errorList);
          this.valid = false;
          return '';
        }
      }
      else if (line.startsWith("method") || line.startsWith("zubereitung")) {
        if (progress > 5){
          valid = false;
          _addError(5, progress);
          return '';
        }
        progress = 6;
        r.setMethod(line, language);
        methodsFound = true;
        if (line.contains('refrigerate') || line.contains('einfrieren'))
          refrigerateFound = true;
        if (r.error){
          this.error.addAll(r.errorList);
          this.valid = false;
          return '';
        }
      }
      else if (line.startsWith("serves") || line.startsWith("portionen")) {
        if (progress != 6) {
          valid = false;
          _addError(6, progress);
          return '';
        }
        progress = 0;
        r.setServes(line);
        servesFound = true;
        if (r.error){
          this.error.addAll(r.errorList);
          this.valid = false;
          return '';
        }
      }
      else {
        if (progress == 0 || progress >= 6) {
          title = _parseTitle(line);
          r = new Recipe(line);
          if (mainrecipe == null) {
            mainrecipe = r;
            mainrecipeFound = true;
          }
          progress = 1;
          recipes.addAll({title : r});
        }
        else if (progress == 1) {
          progress = 2;
          r.setComments(line);
        }
        else {
          valid = false;
          if (!progressError)
            {
              progressError = true;
              if (mainrecipeFound) {
                error.add('chef_error_structure_subrecipe');
              }
              error.addAll(['chef_error_structure_recipe_read_unexpected_comments_title',
                _progressToExpected(progress),
                'chef_hint_recipe_hint',
                _structHint(progress),
                '']);
            }
          return '';
        }
      }
    });
    if (mainrecipe == null) {
      valid = false;
      error.addAll(['chef_error_structure_recipe',
                    'chef_error_structure_recipe_empty_missing_title',
                    '']);
      return;
    }
    if (!ingredientsFound) {
      valid = false;
      error.addAll(['chef_error_structure_recipe',
        'chef_error_structure_recipe_empty_ingredients',
        '']);
      return;
    }
    if (!methodsFound) {
      valid = false;
      error.addAll(['chef_error_structure_recipe',
        'chef_error_structure_recipe_empty_methods',
        '']);
      return;
    }
    if (!servesFound && !refrigerateFound) {
      valid = false;
      error.addAll(['chef_error_structure_recipe',
        'chef_error_structure_recipe_empty_serves',
        '']);
      return;
    }
  } // chef

  String _parseTitle(String title) {
    if (title.endsWith('.')) {
      title = title.substring(0, title.length - 1);
    }
    return title.toLowerCase();
  }

  void _addError(int progressToExpected, int progress) {
    error.add('chef_error_structure_recipe');
    if (progressToExpected >= 0) {
      error.addAll(['chef_error_structure_recipe_read_unexpected',
                     _progressToExpected(progressToExpected),
                     'chef_error_structure_recipe_expecting',
                     _progressToExpected(progress)]);
    } else {
      error.addAll(['chef_error_structure_recipe_read_unexpected_comments_title',
                     _progressToExpected(progress),
                     'chef_hint_recipe_hint',
                     _structHint(progress)]);
    }
    error.add('');
  }

  String _structHint(int progress) {
    switch (progress) {
      case 2 : return 'chef_hint_recipe_ingredients';
      case 3 : return 'chef_hint_recipe_methods';
      case 4 : return 'chef_hint_recipe_oven_temperature';
    }
    return "chef_hint_no_hint_available";
  }

  String _progressToExpected(int progress) {
    switch (progress) {
      case 0 :  return 'chef_error_structure_recipe_title';
      case 1 :  return 'chef_error_structure_recipe_comments';
      case 2 :  return 'chef_error_structure_recipe_ingredient_list';
      case 3 :  return 'chef_error_structure_recipe_cooking_time';
      case 4 :  return 'chef_error_structure_recipe_oven_temperature';
      case 5 :  return 'chef_error_structure_recipe_methods';
      case 6 :  return 'chef_error_structure_recipe_serve_amount';
    }
    return null;
  }

  void bake(String language, additionalIngredients) {
    Kitchen k = new Kitchen(this.recipes, this.mainrecipe, null, null, language);
    if (k.valid) {
      k.cook(additionalIngredients, language, 1);
    }
    this.valid = k.valid;
    this.meal = k.meal;
    this.error = k.error;
  }
}
