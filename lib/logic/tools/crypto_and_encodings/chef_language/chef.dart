import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/kitchen.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/recipe.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chefException.dart';

final itemList = [// 10 items (0-9)  26 items (a-z)  5 items (.,;!?) > 41 items
  ['g','flour'], ['g', 'white sugar'], ['pinch', 'salt'], ['pinches', 'baking soda'], ['g', 'butter'],
  ['', 'vanilla bean'], ['tablespoon', 'brown sugar'], ['pinch', 'pepper'], ['', 'eggs'], ['g', 'haricot beans'],
  ['g', 'red salmon'], ['ml', 'milk'], ['ml', 'water'], ['ml', 'oil'], ['ml', 'water'],
  ['drips', 'liquid vanilla'], ['dashes', 'lemon juice'], ['teaspoon', 'powdered-sugar'], ['', 'almonds'], ['', 'onions'],
  ['', 'garlic cloves'], ['', 'cinnamon'], ['', 'egg yolk'], ['', 'egg white'], ['pinches', 'kummel'],
  ['pinches', 'aniseed'], ['ml', 'amaretto'], ['tablespoon', 'espresso'], ['', 'cream'], ['', 'sour cream'],
  ['', 'cream cheese'], ['cups', 'cheese'], ['ml', 'white wine'], ['ml', 'red wine'], ['gr', 'pumpkin'],
  ['g', 'cucumber'], ['g', 'potatoes'], ['gr', 'sweet potatoes'], ['g', 'apple pieces '], ['', 'shrimps'],
  ['g', 'guacamole'], ['g', 'wholemeal flour'], ['g', 'tofu'], ['teaspoon', 'chili'], ['teaspoon', 'curry'],
  ['dashes', 'tabasco'], ['g', 'mustard'], ['tablespoon', 'jam'], ['g', 'mixed fruits'], ['dashes', 'calvados'],
];

String generateChef(String title, String remark, String time, String temperature, String outputToGenerate){
  String output ="";
  var ingredients;
  List<String> methodList = new List<String>();
  List<String> ingredientList = new List<String>();
  Map<int, String> amount = new Map<int, String>();
  Map<String, String> ingredientListed = new Map<String, String>();
  int value = 0;
  var item;

  Random random = new Random();

  ingredients = outputToGenerate.split('').reversed;
  ingredients.forEach((element) {
    value = element.codeUnitAt(0);
    if (amount[value] == null) {
      item = itemList.elementAt(random.nextInt(itemList.length));
      while(ingredientListed[item.elementAt(1)] != null) {
        item = itemList.elementAt(random.nextInt(itemList.length));
      }
      ingredientListed[item.elementAt(1)] = item.elementAt(1);
      ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' + item.elementAt(1));
      amount[value] = item.elementAt(1);
      methodList.add('Put ' + amount[value] + ' into the mixing bowl.');
    } else {
      methodList.add('Put ' + amount[value] + ' into the mixing bowl.');
    }
  });

  output = output + title + ' \n';
  output = output + '\n';
  output = output + remark + ' \n';
  output = output + '\n';
  output = output + 'Ingredients.' + ' \n';
  output = output + ingredientList.join('\n') + '\n';
  output = output + '\n';
  if (int.tryParse(time) != null) {
    output = output + 'Cooking time: ' + time + ' minutes.' + '\n';
    output = output + '\n';
  }
  if (int.tryParse(temperature) != null) {
    output = output + 'Pre-heat oven to ' + temperature + ' degrees Celsius.' + '\n';
    output = output + '\n';
  }
  output = output + 'Method.' + ' \n';
  output = output + methodList.join('\n') + '\n';
  output = output + 'Liquefy contents of the mixing bowl.' + '\n';
  output = output + 'Pour contents of the mixing bowl into the baking dish.' + ' \n';
  output = output + '\n';
  output = output + 'Serves 1.' + '\n';
  return output;
}


String interpretChef(String recipe, String input) {
	if (recipe == null || recipe == '')
		return '';

  String output = 'not implemented yet';
  decodeChefLanguage(recipe);

  return output;
}


decodeChefLanguage(String input)  { //throws Exception
	Chef interpreter = Chef(input);
	interpreter.bake();
}


class Chef {

	Map<String, Recipe> recipes;
	Recipe mainrecipe;


	Chef(String input) {
		recipes = new Map<String, Recipe>();
		int progress = 0;
		Recipe r = null;
		String title = '';
		input.split("\n\n")
			.forEach((line) {
				if (line.startsWith("ingredients")) {
					if (progress > 3)
						throw new ChefException(ChefException.STRUCTURAL,
								"Read unexpected " + _progressToExpected(2) + ". Expecting " + _progressToExpected(progress));
					progress = 3;
					r.setIngredients(line);
				} else if (line.startsWith("cooking time")) {
					if (progress > 4)
						throw new ChefException(ChefException.STRUCTURAL,
								"Read unexpected " + _progressToExpected(3) + ". Expecting " + _progressToExpected(progress));
					progress = 4;
					r.setCookingTime(line);
				} else if (line.startsWith("pre-heat oven")) {
					if (progress > 5)
						throw new ChefException(ChefException.STRUCTURAL,
								"Read unexpected " + _progressToExpected(4) + ". Expecting " + _progressToExpected(progress));
					progress = 5;
					r.setOvenTemp(line);
				} else if (line.startsWith("method")) {
					if (progress > 5)
						throw new ChefException(ChefException.STRUCTURAL,
								"Read unexpected " + _progressToExpected(5) + ". Expecting " + _progressToExpected(progress));
					progress = 6;
					r.setMethod(line);
				} else if (line.startsWith("serves")) {
					if (progress != 6)
						throw new ChefException(ChefException.STRUCTURAL,
								"Read unexpected " + _progressToExpected(6) + ". Expecting " + _progressToExpected(progress));
					progress = 0;
					r.setServes(line);
				} else {
					if (progress == 0 || progress >= 6) {
						r = new Recipe(line);
						title = _parseTitle(line);
						if (mainrecipe == null)
							mainrecipe = r;
						progress = 1;
						recipes.addAll({title : r});
					} else if (progress == 1) {
						progress = 2;
						r.setComments(line);
					} else {
						throw new ChefException(ChefException.STRUCTURAL,
								"Read unexpected comments/title. Expecting " + _progressToExpected(progress) + " Hint:" + _structHint(progress));
					}
				}
		});
		recipes.addAll({_parseTitle(title): r});
		if (mainrecipe == null)
			throw new ChefException(
					ChefException.STRUCTURAL, "Recipe empty or title missing!");
	}


	String _parseTitle(String title) {
		if (title.endsWith('.')) {
			title = title.substring(0, title.length - 1);
		}
		return title.toLowerCase();
	}

	String _structHint(int progress) {
		switch (progress) {
			case 2 :	return "did you specify 'Ingredients.' above the ingredient list?";
			case 3 :	return "did you specify 'Methods.' above the methods?";
		}
		return "no hint available";
	}

	String _progressToExpected(int progress) {
		switch (progress) {
			case 0 :	return "title";
			case 1 :	return "comments";
			case 2 :	return "ingredient list";
			case 3 :	return "cooking time";
			case 4 :	return "oven temperature";
			case 5 :	return "methods";
			case 6 :	return "serve amount";
		}
		return null;
	}

	void bake() {
		Kitchen k = new Kitchen(this.recipes, this.mainrecipe, null, null);
		k.cook();
	}
}
