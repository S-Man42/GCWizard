import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/kitchen.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/recipe.dart';

final itemListENG = [
  ['g','flour'], ['g', 'white sugar'], ['pinch', 'salt'], ['pinches', 'baking soda'], ['g', 'butter'],
  ['', 'vanilla bean'], ['tablespoon', 'brown sugar'], ['pinch', 'pepper'], ['', 'eggs'], ['g', 'haricot beans'],
  ['g', 'red salmon'], ['ml', 'milk'], ['ml', 'water'], ['ml', 'oil'], ['ml', 'water'],
  ['dashes', 'liquid vanilla'], ['dashes', 'lemon juice'], ['teaspoon', 'powdered-sugar'], ['', 'almonds'], ['', 'onions'],
  ['', 'garlic cloves'], ['', 'cinnamon'], ['', 'egg yolk'], ['', 'egg white'], ['pinches', 'kummel'],
  ['pinches', 'aniseed'], ['ml', 'amaretto'], ['tablespoon', 'espresso'], ['', 'cream'], ['', 'sour cream'],
  ['', 'cream cheese'], ['cups', 'cheese'], ['ml', 'white wine'], ['ml', 'red wine'], ['gr', 'pumpkin'],
  ['g', 'cucumber'], ['g', 'potatoes'], ['gr', 'sweet potatoes'], ['g', 'apple pieces '], ['', 'shrimps'],
  ['g', 'guacamole'], ['g', 'wholemeal flour'], ['g', 'tofu'], ['teaspoon', 'chili'], ['teaspoon', 'curry'],
  ['dashes', 'tabasco'], ['g', 'mustard'], ['tablespoon', 'jam'], ['g', 'mixed fruits'], ['dashes', 'calvados'],
	['g', 'zucchini'], ['g', 'lard'], ['table spoon', 'corn starch'], ['slices', 'bread'], ['g', 'bacon'],
	['g', 'dark chocolate'],['g', 'milk chocolate'], ['ml', 'double cream'], ['g', 'cocoa powder'], ['ml', 'beaten eggs'],
	['g', 'peas'], ['g', 'carrots'], ['g', 'raisins'],['teaspoon', 'mexican spices'],['', 'banana']
];

final itemListDEU = [
	['g', 'Mehl'], ['g', 'weißer Zucker'], ['Prise', 'Salz'], ['Prise(n)', 'Backsoda'], ['g', 'Butter'] ,
	['', 'Vanilleschote'], ['Esslöffel', 'brauner Zucker'], ['Prise(m)', 'Pfeffer'], ['', 'Eier'], ['g', 'Bohnen'],
	['g', 'roter Lachs'], ['ml', 'Milch'], ['ml', 'Wasser'], ['ml', 'Öl'], ['ml', 'Wasser'] ,
	['Tropfen', 'flüssige Vanille'], ['Spritzer', 'Zitronensaft'], ['Teelöffel', 'Puderzucker'], ['', 'Mandeln'], ['', 'Zwiebeln' ],
	['', 'Knoblauchzehen'], ['', 'Zimt'], ['', 'Eigelb'], ['', 'Eiweiß'], ['Prise(n)', 'Kümmel'],
	['Prisen', 'Anis'], ['ml', 'Amaretto'], ['Esslöffel', 'Espresso'], ['', 'Sahne'], ['', 'saure Sahne'],
	['', 'Frischkäse'], ['Tassen', 'Käse'], ['ml', 'Weißwein'], ['ml', 'Rotwein'], ['gr', 'Kürbis' ],
	['g', 'Gurke'], ['g', 'Kartoffeln'], ['gr', 'Süßkartoffeln'], ['g', 'Apfelstücke'], ['', 'Garnelen'] ,
	['g', 'Guacamole'], ['g', 'Vollkornmehl'], ['g', 'Tofu'], ['Teelöffel', 'Chili'], ['Teeelöffel', 'Curry'] ,
	['Spritzer', 'Tabasco'], ['g', 'Senf'], ['Esslöffel', 'Marmelade'], ['g', 'gemischte Früchte'], ['Spritzer', 'Calvados'] ,
	['g', 'Zucchini'], ['g', 'schmalz'], ['Esslöffel', 'Maisstärke'], ['Scheiben', 'Brot'], ['g', 'Speck' ],
	['g', 'dunkle Schokolade'], ['g', 'Milchschokolade'], ['ml', 'Schmand'], ['g', 'Kakaopulver'], ['ml', ' geschlagene Eier'],
	['g', 'Erbsen'], ['g', 'Karotten'], ['g', 'Rosinen'], ['Teelöffel', 'mexikanische Gewürze'], ['', 'Banane']
];



enum textId {
	Put_into_the_mixing_bowl,
	Ingredients,
	Cooking_time,
	Pre_heat_oven,
	Method,
	Liquefy_contents,
	Pour_contents,
	Serves
}

String _getText(textId id, String parameter, language) {
	var text ='';
	switch (id) {
		case textId.Put_into_the_mixing_bowl:
			if (language == 'ENG')
				text = 'Put %1 into the mixing bowl.';
			else
				text = 'Gebe %1 in die Rührschüssel.';
			break;
		case textId.Ingredients:
			if (language == 'ENG')
				text = 'Ingredients.';
			else
				text = 'Zutaten.';
			break;
		case textId.Cooking_time:
			if (language == 'ENG')
				text = 'Cooking time: %1 minutes.';
			else
				text = 'Kochzeit: %1 minuten.';
			break;
		case textId.Pre_heat_oven:
			if (language == 'ENG')
				text = 'Pre-heat oven to %1 degrees Celsius.';
			else
				text = 'Vorheizen des Ofens auf %1 Grad Celsius.';
			break;
		case textId.Method:
			if (language == 'ENG')
				text = 'Method.';
			else
				text = 'Zubereitung.';
			break;
		case textId.Liquefy_contents:
			if (language == 'ENG')
				text = 'Liquefy contents of the mixing bowl.';
			else
					text = 'Verflüssige die Inhalte der Rührschüssel.';
			break;
		case textId.Pour_contents:
			if (language == 'ENG')
				text = 'Pour contents of the mixing bowl into the baking dish.';
			else
					text = 'Gieße die Inhalte der Rührschüssel auf die Servierplatte.';
			break;
		case textId.Serves:
			if (language == 'ENG')
				text = 'Serves 1.';
			else
				text = 'Portionen 1.';
			break;
	}

	return text.replaceAll('%1', parameter);
}


String generateChef(String language, title, String remark, String time, String temperature, String outputToGenerate){
	var output = StringBuffer();
  List<String> outputElements;
  List<String> methodList = new List<String>();
  List<String> ingredientList = new List<String>();
  Map<int, String> amount = new Map<int, String>();
  Map<String, String> ingredientListed = new Map<String, String>();
  int value = 0;
	var itemList;
	var item;

  Random random = new Random();

  if (language == 'ENG') itemList = itemListENG; else itemList = itemListDEU;
	outputElements = outputToGenerate.split('');
	for(int i = 0; i < outputElements.length/2; i++ ) {
		var temp = outputElements[i];
		outputElements[i] = outputElements[outputElements.length-1-i];
		outputElements[outputElements.length-1-i] = temp;
	}
	outputElements.forEach((element) {
    value = element.codeUnitAt(0);
    if (amount[value] == null) {
      item = itemList.elementAt(random.nextInt(itemList.length));
      while(ingredientListed[item.elementAt(1)] != null) {
        item = itemList.elementAt(random.nextInt(itemList.length));
      }
      ingredientListed[item.elementAt(1)] = item.elementAt(1);
      ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' + item.elementAt(1));
      amount[value] = item.elementAt(1);
      methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
    } else {
      methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
    }
  });
	output.write(title + '.\n');
	output.write('\n');
	if (remark != '') output.write(remark + '\n\n');
	output.write(_getText(textId.Ingredients, '', language)  + '\n');
	output.write(ingredientList.join('\n') + '\n');
	output.write('\n');
	if (int.tryParse(time) != null) {
		output.write(_getText(textId.Cooking_time, time, language) + '\n\n');
	}
	if (int.tryParse(temperature) != null) {
		output.write(_getText(textId.Pre_heat_oven, temperature, language) + '\n\n');
	}
	output.write(_getText(textId.Method, '', language) + '\n');
	output.write(methodList.join('\n') + '\n');
	output.write(_getText(textId.Liquefy_contents, '', language) + '\n');
	output.write(_getText(textId.Pour_contents, '', language) + '\n');
	output.write('\n');
	output.write(_getText(textId.Serves, '', language) + '\n');
	return output.toString();
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
		else
			return interpreter.error;
	} else {
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
		this.meal = new List<String>();		valid = true;
		error = new List<String>();
		recipes = new Map<String, Recipe>();
		int progress = 0;
		Recipe r = null;
		String title = '';
		String line = '';
		readRecipe.split("\n\n")
			.forEach((element) {
				line = element.trim();
				if (line.startsWith("ingredients") || line.startsWith("zutaten")) {
					if (progress > 3) {
						valid = false;
						_addError(2, progress);
						return '';
					}
					progress = 3;
					r.setIngredients(line);
					if (r.error) {
						this.error.addAll(r.errorList);
						valid = false;
						return '';
					}
				} else if (line.startsWith("cooking time") || line.startsWith("kochzeit")) {
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
				} else if (line.startsWith("pre-heat oven") || line.startsWith("vorheizen des ofens")) {
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
				} else if (line.startsWith("method") || line.startsWith("zubereitung")) {
					if (progress > 5){
						valid = false;
						_addError(5, progress);
						return '';
					}
					progress = 6;
					r.setMethod(line, language);
					if (r.error){
						this.valid = false;
						return '';
					}
				} else if (line.startsWith("serves") || line.startsWith("portionen")) {
					if (progress != 6) {
						valid = false;
						_addError(6, progress);
						return '';
					}
					progress = 0;
					r.setServes(line);
					if (r.error){
						this.error.addAll(r.errorList);
						this.valid = false;
						return '';
					}
				} else {
					if (progress == 0 || progress >= 6) {
						title = _parseTitle(line);
						r = new Recipe(line);
						if (mainrecipe == null) {
							mainrecipe = r;
						}
						progress = 1;
						recipes.addAll({title : r});
					} else if (progress == 1) {
						progress = 2;
						r.setComments(line);
					} else {
						valid = false;
						error.add('chef_error_structure_recipe');
						error.add('chef_error_structure_recipe_read_unexpected_comments_title');
						error.add(_progressToExpected(progress));
						error.add('chef_hint_recipe_hint');
						error.add(_structHint(progress));
						error.add('');
						return '';
					}
				}
		});
		if (mainrecipe == null) {
			valid = false;
			error.add('chef_error_structure_recipe');
			error.add('chef_error_structure_recipe_empty_missing_title');
			error.add('');
			return;
		}
	}

	String _parseTitle(String title) {
		if (title.endsWith('.')) {
			title = title.substring(0, title.length - 1);
		}
		return title.toLowerCase();
	}

	void _addError(int progressToExpected, int progress) {
		error.add('chef_error_structure_recipe');
		if (progressToExpected >= 0) {
			error.add('chef_error_structure_recipe_read_unexpected');
			error.add(_progressToExpected(progressToExpected));
			error.add('chef_error_structure_recipe_expecting');
			error.add(_progressToExpected(progress));
		} else {
			error.add('chef_error_structure_recipe_read_unexpected_comments_title');
			error.add(_progressToExpected(progress));
			error.add('chef_hint_recipe_hint');
			error.add(_structHint(progress));
		}
		error.add('');
	}

	String _structHint(int progress) {
		switch (progress) {
			case 2 :	return 'chef_hint_recipe_ingredients';
			case 3 :	return 'chef_hint_recipe_methods';
		}
		return "chef_hint_no_hint_available";
	}

	String _progressToExpected(int progress) {
		switch (progress) {
			case 0 :	return 'chef_error_structure_recipe_title';
			case 1 :	return 'chef_error_structure_recipe_comments';
			case 2 :	return 'chef_error_structure_recipe_ingredient_list';
			case 3 :	return 'chef_error_structure_recipe_cooking_time';
			case 4 :	return 'chef_error_structure_recipe_oven_temperature';
			case 5 :	return 'chef_error_structure_recipe_methods';
			case 6 :	return 'chef_error_structure_recipe_serve_amount';
		}
		return null;
	}

	void bake(String language, additionalIngredients) {
		Kitchen k = new Kitchen(this.recipes, this.mainrecipe, null, null, language);
		if (k.valid) {
			k.cook(additionalIngredients, language);
		}
    this.valid = k.valid;
    this.meal = k.meal;
    this.error = k.error;
	}
}
