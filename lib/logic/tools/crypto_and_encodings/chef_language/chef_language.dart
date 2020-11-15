import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/kitchen.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/recipe.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/primes/primes.dart';

final List<List<String>> itemListLiquidENG = [
	['ml', 'milk'], ['ml', 'water'], ['ml', 'oil'], ['dashes', 'liquid vanilla'], ['ml', 'amaretto'],
	['tablespoon', 'espresso'], ['', 'cream'], ['', 'sour cream'], ['ml', 'white wine'], ['ml', 'red wine'],
	['dashes', 'tabasco'], ['ml', 'wodka'], ['ml', 'calvados'], ['ml', 'whisky'], ['dashes', 'grand darnier'],
	['ml', 'grenadine'], ['ml', 'ouzo'], ['ml', 'gin'], ['ml', 'rum'], ['ml', 'tonic'], ['ml', 'raki'],
	['', 'egg yolk'], ['', 'egg white'],
];

final List<List<String>> itemListDryENG = [
  ['g','flour'], ['g', 'white sugar'], ['pinch', 'salt'], ['pinches', 'baking soda'], ['g', 'butter'],
  ['', 'vanilla bean'], ['tablespoon', 'brown sugar'], ['pinch', 'pepper'], ['', 'eggs'], ['g', 'haricot beans'],
  ['g', 'red salmon'], ['dashes', 'lemon juice'], ['teaspoon', 'powdered-sugar'], ['', 'almonds'], ['', 'onions'],
  ['', 'garlic cloves'], ['', 'cinnamon'], ['pinches', 'kummel'],   ['pinches', 'aniseed'], ['', 'cream cheese'],
	['cups', 'cheese'], ['gr', 'pumpkin'], ['g', 'cucumber'], ['g', 'potatoes'], ['gr', 'sweet potatoes'],
	['g', 'apple pieces '], ['', 'shrimps'], ['g', 'guacamole'], ['g', 'wholemeal flour'], ['g', 'tofu'],
	['teaspoon', 'chili'], ['teaspoon', 'curry'], ['g', 'mustard'], ['tablespoon', 'jam'], ['g', 'mixed fruits'],
	['g', 'zucchini'], ['g', 'lard'], ['table spoon', 'corn starch'], ['slices', 'bread'], ['g', 'bacon'],
	['g', 'dark chocolate'],['g', 'milk chocolate'], ['ml', 'double cream'], ['g', 'cocoa powder'], ['ml', 'beaten eggs'],
	['g', 'peas'], ['g', 'carrots'], ['g', 'raisins'], ['teaspoon', 'mexican spices'],['', 'banana']
];

final List<List<String>> itemListDryDEU = [
	['g', 'Mehl'], ['g', 'weißer Zucker'], ['Prise', 'Salz'], ['Prise(n)', 'Backsoda'], ['g', 'Butter'], 	['', 'Vanilleschote'],
	['Esslöffel', 'brauner Zucker'], ['Prise(n)', 'Pfeffer'], ['', 'Eier'], ['g', 'Bohnen'], 	['g', 'roter Lachs'],
	['Teelöffel', 'Puderzucker'], ['', 'Mandeln'], ['', 'Zwiebeln' ], 	['', 'Knoblauchzehen'], ['', 'Zimt'],
	['Prise(n)', 'Kümmel'], ['Prisen', 'Anis'], ['', 'Frischkäse'], ['Tassen', 'Käse'], ['gr', 'Kürbis' ],
	['g', 'Gurke'], ['g', 'Kartoffeln'], ['gr', 'Süßkartoffeln'], ['g', 'Apfelstücke'], ['', 'Garnelen'] ,
	['g', 'Guacamole'], ['g', 'Vollkornmehl'], ['g', 'Tofu'], ['Teelöffel', 'Chili'], ['Teeelöffel', 'Curry'] ,
	['g', 'Senf'], ['Esslöffel', 'Marmelade'], ['g', 'gemischte Früchte'], ['g', 'Zucchini'], ['g', 'Schmalz'],
	['Esslöffel', 'Maisstärke'], ['Scheiben', 'Brot'], ['g', 'Speck' ],	['g', 'dunkle Schokolade'], ['g', 'Milchschokolade'],
	['g', 'Kakaopulver'], ['ml', ' geschlagene Eier'], ['g', 'Erbsen'], ['g', 'Karotten'], ['g', 'Rosinen'],
	['Teelöffel', 'mexikanische Gewürze'], ['', 'Banane']
];

final List<List<String>> itemListLiquidDEU = [
	['ml', 'Milch'], ['ml', 'Wasser'], ['ml', 'Öl'], ['Tropfen', 'flüssige Vanille'], ['Spritzer', 'Zitronensaft'],
	['', 'Eigelb'], ['', 'Eiweiß'], ['ml', 'Amaretto'], ['Esslöffel', 'Espresso'], ['ml', 'Sahne'], ['ml', 'saure Sahne'],
	['ml', 'Weißwein'], ['ml', 'Rotwein'], ['Spritzer', 'Tabasco'], ['ml', 'Schmand'], ['ml', 'Bier'], ['ml', 'Korn'],
	['ml', 'Wodka'], ['ml', 'Calvados'], ['ml', 'Whisky'], ['ml', 'Grand Marnier'], ['ml', 'Grenadine'], ['ml', 'Ouzo'],
	['ml', 'Gin'], ['ml', 'Rum'], ['ml', 'Tonic'], ['ml', 'Raki']
];

final List<List<String>> itemListAuxiliaryDEU = [
	['fluffige ', 'leichte ', 'cremige ', 'schwere '],
	['bittere ', 'sauere ', 'süße ', 'scharfe ', 'salzige '],
	['Honig', 'Senf', 'Ketchup', 'Curry'],
	['sauce', 'dressing', 'topping', 'chips']
];

final List<List<String>> itemListAuxiliaryENG = [
	['fluffy ', 'light ', 'creamy ', 'heavy '],
	['bitter ', 'sour ', 'sweet ', 'hot ', 'salty '],
	['honey', 'mustard', 'ketchup', 'curry'],
	['sauce', 'dressing', 'topping', 'chips']
];

enum textId {
	Put_into_the_mixing_bowl,
	Ingredients,
	Cooking_time,
	Pre_heat_oven,
	Method,
	Liquefy_contents,
	Liquefy,
	Pour_contents,
	Serves,
	Serve_with,
	Clean,
	Add,
	Combine
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
		case textId.Add:
			if (language == 'ENG')
				text = 'Add %1 into the mixing bowl.';
			else
				text = 'Füge hinzu %1 in die Rührschüssel.';
			break;
		case textId.Combine:
			if (language == 'ENG')
				text = 'Combine %1 into the mixing bowl.';
			else
				text = 'Kombiniere %1 in die Rührschüssel.';
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
				text = 'Liquefy %1.';
			else
					text = 'Verflüssige %1.';
			break;
		case textId.Liquefy:
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
		case textId.Serve_with:
			if (language == 'ENG')
				text = 'Serve with %1.';
			else
				text = 'Serviere mit %1.';
			break;
			break;
		case textId.Clean:
			if (language == 'ENG')
				text = 'Clean %1 mixing bowl.';
			else
				text = 'Säubere die %1 Rührschüssel.';
			break;
			break;
	}

	return text.replaceAll('%1', parameter);
}


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
			nOne = 1;
			for (int i = 0; i < nList.length -1; i++)
				nOne = nOne * nList[i].toInt();
			nTwo = value ~/ nOne;
		} else {
			nOne = nList[0].toInt();
			nTwo = nList[1].toInt();
		}
	}
	output.add(name);
	output.add('');
	output.add(_getText(textId.Ingredients, '', language));
	output.add(nOne.toString() + ' ' + ingredientOne[0] + ' ' + ingredientOne[1]);
	output.add(nTwo.toString() + ' ' + ingredientTwo[0] + ' ' + ingredientTwo[1]);
	output.add('');
	output.add(_getText(textId.Method, '', language));
	//output.add(_getText(textId.Clean, '', language));
	output.add(_getText(textId.Put_into_the_mixing_bowl, ingredientOne[1], language));
	if (combine)
		output.add(_getText(textId.Combine, ingredientTwo[1], language));
	else
		output.add(_getText(textId.Add, ingredientTwo[1], language));
	return output;
}

String generateChef(String language, title, String remark, String time, String temperature, String outputToGenerate, bool auxiliary){
	var output = StringBuffer();
  List<String> outputElements;
  List<String> methodList = new List<String>();
  List<String> ingredientList = new List<String>();
  Map <String, List<String>> auxiliaryRecipes = new Map <String, List<String>>();
  Map<int, String> amount = new Map<int, String>();
  Map<String, String> ingredientListed = new Map<String, String>();
  int value = 0;
  int i = 0;
	List<List<String>> itemList = new List<List<String>>();
	List<List<String>> itemListLiquid= new List<List<String>>();
	List<List<String>> itemListDry = new List<List<String>>();
	List<List<String>> itemListAuxiliary = new List<List<String>>();
	var item;
	String auxiliaryName = '';
	List<String> ingredientOne = new List<String>();
	List<String> ingredientTwo = new List<String>();


  Random random = new Random();

  if (language == 'ENG') {
  	itemListDry.addAll(itemListDryENG);
		itemListLiquid.addAll(itemListLiquidENG);
		itemListAuxiliary.addAll(itemListAuxiliaryENG);
	} else {
		itemListDry.addAll(itemListDryDEU);
		itemListLiquid.addAll(itemListLiquidDEU);
		itemListAuxiliary.addAll(itemListAuxiliaryDEU);
  }

  if (auxiliary) { // build auxilay recipes
		if (language == 'ENG'){
			amount[32] = 'ambergris';
			ingredientList.add(32.toString() + ' ml ambergris');
		} else {
			amount[32] = 'ambra';
			ingredientList.add(32.toString() + ' ml ambra');
		}

		outputElements = outputToGenerate.split(' ');
		for (i = 0; i < outputElements.length / 2; i++) {
			var temp = outputElements[i];
			outputElements[i] = outputElements[outputElements.length - 1 - i];
			outputElements[outputElements.length - 1 - i] = temp;
		}
		i = 0;
	  outputElements.forEach((element) {
	  	if (int.tryParse(element) != null) { // element is a number
	  		value = int.parse(element);
	  		if (value < 10) { // => 48 - 57
					value = element.codeUnitAt(0);
					if (amount[value] == null) {
						item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length));
						while (ingredientListed[item.elementAt(1)] != null) {
							item = itemListLiquid.elementAt(random.nextInt(itemList.length));
						}
						ingredientListed[item.elementAt(1)] = item.elementAt(1);
						ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' +	item.elementAt(1));
						amount[value] = item.elementAt(1);
						methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
					} else {
						methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
					}
				} else if (value < 100) { // => number
					if (amount[value] == null) {
						item = itemListDry.elementAt(random.nextInt(itemListDry.length));
						while (ingredientListed[item.elementAt(1)] != null) {
							item = itemListDry.elementAt(random.nextInt(itemList.length));
						}
						ingredientListed[item.elementAt(1)] = item.elementAt(1);
						ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' +
								item.elementAt(1));
						amount[value] = item.elementAt(1);
						methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
					} else {
						methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
					}
				} else { // => auxiliary recipe to provide number: pour, clean, serve with, pour
						auxiliaryName = itemListAuxiliary[0][random.nextInt(4)] + itemListAuxiliary[1][random.nextInt(4)] + itemListAuxiliary[2][random.nextInt(4)] + itemListAuxiliary[3][random.nextInt(4)];
						while (auxiliaryRecipes[auxiliaryName] != null) {
	  				  auxiliaryName = itemListAuxiliary[0][random.nextInt(4)] + itemListAuxiliary[1][random.nextInt(4)] + itemListAuxiliary[2][random.nextInt(4)] + itemListAuxiliary[3][random.nextInt(4)];
						}
						ingredientOne = itemListDry.elementAt(random.nextInt(itemListDry.length));
						ingredientTwo = itemListDry.elementAt(random.nextInt(itemListDry.length));
						while (ingredientTwo.join('') == ingredientOne.join('')) {
							ingredientTwo = itemListDry.elementAt(random.nextInt(itemListDry.length));
						}
						auxiliaryRecipes[auxiliaryName] = _getAuxiliaryRecipe(auxiliaryName, value, ingredientOne, ingredientTwo, language);
						//methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[0], language));
						if (i > 0) {
							methodList.add(_getText(textId.Pour_contents, '', language));
							methodList.add(_getText(textId.Clean, '', language));
						}
						methodList.add(_getText(textId.Serve_with, auxiliaryName, language));
						//methodList.add(_getText(textId.Pour_contents, '', language));
						//methodList.add(_getText(textId.Clean, '', language));
				}
			} else { // element is a char or a combination of characters and numbers => Liquid
				List<String> Elements = element.split('');
				Elements.forEach((element) {
					value = element.codeUnitAt(0);
					if (amount[value] == null) {
						item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length));
						while (ingredientListed[item.elementAt(1)] != null) {
							item = itemListLiquid.elementAt(random.nextInt(itemListLiquid.length));
						}
						ingredientListed[item.elementAt(1)] = item.elementAt(1);
						ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' +
								item.elementAt(1));
						amount[value] = item.elementAt(1);
						methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
					} else {
						methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
					}
				});
			}
	  	i++;
	  	if (i < outputElements.length) {
				methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[32], language));
			};
		}); // outputElements.forEach((element)
	} else { // build "normal" linear recipe
		itemList.addAll(itemListDry);
		itemList.addAll(itemListLiquid);

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
				while (ingredientListed[item.elementAt(1)] != null) {
					item = itemList.elementAt(random.nextInt(itemList.length));
				}
				ingredientListed[item.elementAt(1)] = item.elementAt(1);
				ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' +
						item.elementAt(1));
				amount[value] = item.elementAt(1);
				methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
			} else {
				methodList.add(_getText(textId.Put_into_the_mixing_bowl, amount[value], language));
			}
		});
	}

	output.writeln(title + '.');
	output.writeln('');
	if (remark != '') output.writeln(remark + '\n');
	output.writeln(_getText(textId.Ingredients, '', language) );
	output.writeln(ingredientList.join('\n'));
	output.writeln('');
	if (int.tryParse(time) != null) {
		output.writeln(_getText(textId.Cooking_time, time, language) + '\n');
	}
	if (int.tryParse(temperature) != null) {
		output.writeln(_getText(textId.Pre_heat_oven, temperature, language) + '\n');
	}
	output.writeln(_getText(textId.Method, '', language));
	output.writeln(methodList.join('\n'));
	if (!auxiliary)
		output.writeln(_getText(textId.Liquefy_contents, '', language));
	output.writeln(_getText(textId.Pour_contents, '', language));
	output.writeln('');
	output.writeln(_getText(textId.Serves, '', language));

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
