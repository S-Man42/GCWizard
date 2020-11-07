
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef/method.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef/recipe.dart';

class Kitchen {

  List<Container> mixingbowls;
  List<Container> bakingdishes;
  Map<String, Recipe>	recipes;
  Recipe recipe;

  Kitchen(Map<String, Recipe> recipes, Recipe mainrecipe) {
    this(recipes, mainrecipe, null, null);
  }

  public Kitchen(Map<String, Recipe> recipes, Recipe mainrecipe,
  Container[] mbowls, Container[] bdishes) {
  this.recipes = recipes;
  //start with at least 1 mixing bowl.
  int maxbowl = 0, maxdish = -1;
  recipe = mainrecipe;
  for (Method m : recipe.getMethods()) {
  if (m.bakingdish != null && m.bakingdish > maxdish)
  maxdish = m.bakingdish;
  if (m.mixingbowl != null && m.mixingbowl > maxbowl)
  maxbowl = m.mixingbowl;
  }
  mixingbowls = new Container[mbowls == null ? maxbowl + 1 : Math.max(maxbowl + 1, mbowls.length)];
  bakingdishes = new Container[bdishes == null ? maxdish + 1 : Math.max(maxdish + 1, bdishes.length)];
  for (int i = 0; i < mixingbowls.length; i++)
  mixingbowls[i] = new Container();
  for (int i = 0; i < bakingdishes.length; i++)
  bakingdishes[i] = new Container();
  if (mbowls != null) {
  for (int i = 0; i < mbowls.length; i++) {
  mixingbowls[i] = new Container(mbowls[i]);
  }
  }
  if (bdishes != null) {
  for (int i = 0; i < bdishes.length; i++) {
  bakingdishes[i] = new Container(bdishes[i]);
  }
  }
  }

  public Container cook() throws ChefException {
  HashMap<String,Ingredient> ingredients = recipe.getIngredients();
  ArrayList<Method> methods = recipe.getMethods();
  LinkedList<LoopData> loops = new LinkedList<LoopData>();
  Scanner input = new Scanner(System.in);
  Component c;
  int i = 0;
  boolean deepfrozen = false;
  methodloop: while (i < methods.size() && !deepfrozen) {
  Method m = methods.get(i);
  switch (m.type) {
  case Take :
  case Put :
  case Fold :
  case Add :
  case Remove :
  case Combine :
  case Divide :
  case Liquefy :
  case StirInto :
  case Verb :
  if (ingredients.get(m.ingredient) == null)
  throw new ChefException(ChefException.METHOD, recipe, m.n, m.type.toString(), "Ingredient not found: "+m.ingredient);
  }
  switch (m.type) {
  case Take :
  ingredients.get(m.ingredient).setAmount(input.nextInt());
  break;
  case Put :
  mixingbowls[m.mixingbowl].push(new Component(ingredients.get(m.ingredient)));
  break;
  case Fold :
  if (mixingbowls[m.mixingbowl].size() == 0)
  throw new ChefException(ChefException.METHOD, recipe, m.n, m.type.toString(), "Folded from empty mixing bowl: "+(m.mixingbowl + 1));
  c = mixingbowls[m.mixingbowl].pop();
  ingredients.get(m.ingredient).setAmount(c.getValue());
  ingredients.get(m.ingredient).setState(c.getState());
  break;
  case Add :
  c = mixingbowls[m.mixingbowl].peek();
  c.setValue(c.getValue() + ingredients.get(m.ingredient).getAmount());
  break;
  case Remove :
  c = mixingbowls[m.mixingbowl].peek();
  c.setValue(c.getValue() - ingredients.get(m.ingredient).getAmount());
  break;
  case Combine :
  c = mixingbowls[m.mixingbowl].peek();
  c.setValue(c.getValue() * ingredients.get(m.ingredient).getAmount());
  break;
  case Divide :
  c = mixingbowls[m.mixingbowl].peek();
  c.setValue(c.getValue() / ingredients.get(m.ingredient).getAmount());
  break;
  case AddDry :
  int sum = 0;
  for(Entry<String, Ingredient> s : ingredients.entrySet())
  if (s.getValue().getstate() == State.Dry)
  sum += s.getValue().getAmount();
  mixingbowls[m.mixingbowl].push(new Component(sum, State.Dry));
  break;
  case Liquefy :
  ingredients.get(m.ingredient).liquefy();
  break;
  case LiquefyBowl :
  mixingbowls[m.mixingbowl].liquefy();
  break;
  case Stir :
  mixingbowls[m.mixingbowl].stir(m.time);
  break;
  case StirInto :
  mixingbowls[m.mixingbowl].stir(ingredients.get(m.ingredient).getAmount());
  break;
  case Mix :
  mixingbowls[m.mixingbowl].shuffle();
  break;
  case Clean :
  mixingbowls[m.mixingbowl].clean();
  break;
  case Pour :
  bakingdishes[m.bakingdish].combine(mixingbowls[m.mixingbowl]);
  break;
  case Verb :
  int end = i+1;
  for (; end < methods.size(); end++)
  if (sameVerb(m.verb, methods.get(end).verb) && methods.get(end).type == Type.VerbUntil)
  break;
  if (end == methods.size())
  throw new ChefException(ChefException.METHOD, m.n, m.type.toString(), "Loop end statement not found.");
  if (ingredients.get(m.ingredient).getAmount() <= 0) {
  i = end + 1;
  continue methodloop;
  }
  else
  loops.addFirst(new LoopData(i, end, m.verb));
  break;
  case VerbUntil :
  if (!sameVerb(loops.peek().verb, m.verb))
  throw new ChefException(ChefException.METHOD, m.n, m.type.toString(), "Wrong loop end statement found.");
  if (ingredients.get(m.ingredient) != null)
  ingredients.get(m.ingredient).setAmount(ingredients.get(m.ingredient).getAmount() - 1);
  i = loops.pollFirst().from;
  continue methodloop;
  case SetAside :
  if (loops.size() == 0)
  throw new ChefException(ChefException.METHOD, m.n, m.type.toString(), "Cannot set aside when not inside loop.");
  else {
  i = loops.pollFirst().to + 1;
  continue methodloop;
  }
  case Serve :
  if (recipes.get(m.auxrecipe.toLowerCase()) == null)
  throw new ChefException(ChefException.METHOD, m.n, m.type.toString(), "Unavailable recipe: "+m.auxrecipe);
  Kitchen k = new Kitchen(recipes, recipes.get(m.auxrecipe.toLowerCase()), mixingbowls, bakingdishes);
  Container con = k.cook();
  mixingbowls[0].combine(con);
  break;
  case Refrigerate :
  if (m.time > 0)
  serve(m.time);
  deepfrozen = true;
  break;
  case Remember :
  break;
  default :
  throw new ChefException(ChefException.METHOD, m.n, m.type.toString(), "Unsupported method found!");
  }
  i++;
  }
  if (recipe.getServes() > 0 && !deepfrozen)
  serve(recipe.getServes());
  if (mixingbowls.length > 0)
  return mixingbowls[0];
  return null;
}

private boolean sameVerb(String imp, String verb) {
  if (verb == null || imp == null)
    return false;
  verb = verb.toLowerCase();
  imp = imp.toLowerCase();
  int L = imp.length();
  return verb.equals(imp) || //A = A
      verb.equals(imp+"n") || //shake ~ shaken
      verb.equals(imp+"d") || //prepare ~ prepared
      verb.equals(imp+"ed") || //monitor ~ monitored
      verb.equals(imp+(imp.charAt(L-1))+"ed") || //stir ~ stirred
      (imp.charAt(L-1) == 'y' && verb.equals(imp.substring(0, L-1)+"ied")); //carry ~ carried
}

private class LoopData {

  int from, to;
  String verb;

  public LoopData(int from, int to, String verb) {
    this.from = from;
    this.to = to;
    this.verb = verb;
  }

}

String serve(int n) {
  String output = '';
  for (int i = 0; i < n && i < bakingdishes.length; i++) {
    output = output + bakingdishes[i].serve();
  }
  return output;
}

}