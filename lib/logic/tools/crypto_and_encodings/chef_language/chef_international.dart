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

final List<RegExp> matchersENG = [
  RegExp(r'^take ([a-zA-Z ]+) from refrigerator$'),
  RegExp(r'^(put|fold) ([a-zA-Z ]+) into( the)?( (\d+)(nd|rd|th|st))? mixing bowl$'),
  RegExp(r'^add dry ingredients( to( (\d+)(nd|rd|th|st))? mixing bowl)?$'),
  RegExp(r'^(add|remove|combine|divide) ([a-zA-Z ]+?)( (to|into|from)( (\d+)(nd|rd|th|st))? mixing bowl)?$'),
  RegExp(r'^liquefy contents of the( (\d+)(nd|rd|th|st))? mixing bowl$'),
  RegExp(r'^liquefy ([a-zA-Z ]+)$'),
  RegExp(r'^stir( the( (\d+)(nd|rd|th|st))? mixing bowl)? for (\d+) minutes$'),
  RegExp(r'^stir ([a-zA-Z ]+) into the( (\d+)(nd|rd|th|st))? mixing bowl$'),
  RegExp(r'^mix( the( (\d+)(nd|rd|th|st))? mixing bowl)? well$'),
  RegExp(r'^clean( (\d+)(nd|rd|th|st))? mixing bowl$'),
  RegExp(r'^pour contents of the( (\d+)(nd|rd|th|st))? mixing bowl into the( (\d+)(nd|rd|th|st))? baking dish$'),
  RegExp(r'^set aside$'),
  RegExp(r'^refrigerate( for (\d+) hour(s)?)?$'),
  RegExp(r'^serve with ([a-zA-Z ]+)$'),
  RegExp(r'^suggestion: (.*)$'),
  RegExp(r'^([a-zA-Z]+?)( the ([a-zA-Z ]+))? until ([a-zA-Z]+)$'),
  RegExp(r'^([a-zA-Z]+) the ([a-zA-Z ]+)$')
];

final List<RegExp> matchersDEU = [
  RegExp(r'^nehme ([a-zäöüß ]+) aus dem kühlschrank$'),
  RegExp(r'^(gebe|unterhebe) ([a-zäöüß ]+) in( die)?( (\d+)(te))? rührschüssel$'),
  RegExp(r'^füge hinzu feste zutaten( zur( (\d+)(ten))? rührschüssel)?$'),
  RegExp(r'^(füge hinzu|entferne|kombiniere|teile) ([a-zäöüß ]+?) (zu|mit( der)?|aus( der)?|in( die)?)( (\d+)(te(n)?))? rührschüssel$'),
  RegExp(r'^verflüssige die inhalte der( (\d+)(ten))? rührschüssel$'),
  RegExp(r'^verflüssige ([a-zäöüß ]+)$'),
  RegExp(r'^rühre( die( (\d+)(te))? rührschüssel)? für (\d+) minuten$'),
  RegExp(r'^rühre ([a-zäöüß ]+) in die( (\d+)(te))? rührschüssel$'),
  RegExp(r'^mische( die( (\d+)(te))? rührschüssel)? well$'),
  RegExp(r'^säubere die( (\d+)(te))? rührschüssel$'),
  RegExp(r'^gieße die inhalte der( (\d+)(ten))? rührschüssel auf die( (\d+)(te))? servierplatte$'),
  RegExp(r'^stelle beiseite'),
  RegExp(r'^gefriere( für (\d+) stunde(n)?)?$'),
  RegExp(r'^serviere mit ([a-zäöüß ]+)$'),
  RegExp(r'^vorschlag: (.*)$'),
  RegExp(r'^([a-zäöüß]+?)( (das|den|die) ([a-zäöüß ]+))? bis ([a-zäöüß]+)$'),
  RegExp(r'^([a-zäöüß]+) (das|den|die) ([a-zäöüß ]+)$')
];

final RegExp MeasureType = RegExp(r'^heaped$|^level$|^gestrichen$|^gehäuft$');
final RegExp MeasureDry = RegExp(r'^g(r)?$|^kg$|^pinch(es)?$|^prise(n)$|^scheibe(n)?$');
final RegExp MeasureLiquid = RegExp(r'^ml$|^l$|^dash(es)?$|^drop(s)?$|^spritzer$|^tropfen$');
final RegExp MeasureElse = RegExp(r'^cup(s)?$|^teaspoon(s)?$|^tablespoon(s)?$|^teelöffel$|^esslöffel$');

final List<String> liquidMeasuresDEU = ['ml', 'l', 'Spritzer', 'Tropfen'];

final List<String> liquidMeasuresENG = ['ml', 'l', 'dashes', 'drops'];

final List<String> dryMeasuresDEU = ['g', 'kg', 'Prisen', 'Scheiben'];

final List<String> dryMeasuresENG = ['g', 'kg', 'pinches', 'slices'];

final List<String> measuresDEU = ['Teelöffel', 'Esslöffel', 'Tasse'];

final List<String> measuresENG = ['teaspoons', 'tablespoons', 'cups'];

final List<String> itemListLiquidENG = [
  'milk', 'water', 'oil', 'liquid vanilla', 'lemon juice', 'lime juice', 'orange juice', 'egg white', 'soda', 'bitter lemon',
  'amaretto', 'espresso', 'cream', 'aquavit', 'white wine', 'red wine', 'tabasco', 'sour cream', 'beer', 'sake',
  'vodka', 'calvados', 'whisky', 'grand marnier',  'grenadine', 'gin', 'rum', 'tonic', 'raki', 'beaten eggs',
  'ouzo', 'fruit brandy', 'cider', 'tequila', 'cointreau', 'agave nectar', 'white vermouth', 'red vermouth', 'angustora', 'blue curacao',
  'white rum', 'tomato juice', 'limoncello', 'honey syrup', 'syrup', 'ginger beer', 'brandy', 'grappa', 'port', 'sherry'
];

final List<String> itemListLiquidDEU = [
  'Milch', 'Wasser', 'Öl', 'flüssige Vanille', 'Zitronensaft',  'Orangensaft', 'Limettensaft', 'Eiweiß', 'Soda', 'Bitter Lemon',
  'Amaretto', 'Espresso', 'Sahne',   'Aquavit',  'Weißwein', 'Rotwein', 'Tabasco', 'Schmand', 'Bier', 'Sake',
  'Wodka' 'Calvados', 'Whisky',  'Grand Marnier', 'Grenadine', 'Gin', 'Rum', 'Tonic', 'Raki',  'geschlagene Eier',
  'Ouzo', 'Obstler', 'Cidre', 'Tequila', 'Cointreau', 'Agavensaft', 'weißer Wermut', 'roter Wermut', 'Angustora', 'Blue Curacao'
  'weißer Rum', 'Tomatensaft', 'Limoncello', 'Honigsirup', 'Zuckersirup', 'Ginger Ale', 'Weinbrand', 'Grappa', 'Portwein', 'Sherry',
];

final List<String> itemListDryENG = [
  'g','flour', 'white sugar', 'salt', 'baking soda', 'butter',
  'vanilla bean', 'brown sugar', 'pepper', 'haricot beans',
  'red salmon', 'lemon juice', 'powdered sugar', 'almonds', 'onions',
  'garlic cloves', 'cinnamon', 'pinches', 'kummel', 'aniseed', 'cream cheese',
  'cheese', 'pumpkin', 'cucumber', 'potatoes', 'sweet potatoes','eggs',
  'apple pieces ', 'shrimps', 'guacamole', 'wholemeal flour', 'tofu',
  'chili', 'curry', 'mustard', 'jam', 'mixed fruits','egg yolk',
  'zucchini', 'lard', 'corn starch', 'bread', 'bacon',
  'dark chocolate','milk chocolate', 'double cream', 'cocoa powder',
  'peas', 'carrots', 'raisins', 'mexican spices','banana chips'
];

final List<String> itemListDryDEU = [
  'Mehl', 'weißer Zucker', 'Salz', 'Backsoda', 'Butter', 	'Vanilleschote',
  'brauner Zucker', 'Pfeffer', 'Bohnen', 	'roter Lachs', 'Eigelb',
  'Puderzucker', 'Mandeln', 'Zwiebeln' , 	'gehackter Knoblauch', 'Zimt',
  'Kümmel', 'Anis', 'Frischkäse', 'Käse', 'Kürbis' ,
  'Gurke', 'Kartoffeln', 'Süßkartoffeln', 'Apfelstücke', 'Garnelen',
  'Guacamole', 'Vollkornmehl', 'Tofu', 'Chili', 'Curry',
  'Senf', 'Marmelade', 'gemischte Früchte', 'Zucchini', 'Schmalz', 'Eier',
  'Maisstärke', 'Scheiben', 'Brot', 'Speck',	'dunkle Schokolade', 'Milchschokolade',
  'Kakaopulver', 'Erbsen', 'Karotten', 'Rosinen',	'mexikanische Gewürze', 'Bananenchips'
];

final List<List<String>> itemListAuxiliaryDEU = [
  ['fluffige ', 'leichte ', 'cremige ', 'schwere '],
  ['bittere ', 'sauere ', 'süße ', 'scharfe ', 'salzige '],
  ['Honig', 'Senf', 'Ketchup', 'Curry'],
  ['soße', 'dressings', 'toppings', 'chips']
];

final List<List<String>> itemListAuxiliaryENG = [
  ['fluffy ', 'light ', 'creamy ', 'heavy '],
  ['bitter ', 'sour ', 'sweet ', 'hot ', 'salty '],
  ['honey', 'mustard', 'ketchup', 'curry'],
  ['sauce', 'dressing', 'topping', 'chips']
];

String getText(textId id, String parameter, language) {
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
        text = 'Combine %1 into mixing bowl.';
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
    case textId.Liquefy:
      if (language == 'ENG')
        text = 'Liquefy %1.';
      else
        text = 'Verflüssige %1.';
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
