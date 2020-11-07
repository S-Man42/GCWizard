import 'dart:math';

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
  print(ingredients);
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

String interpretChef(String recipe) {
  return "";
}