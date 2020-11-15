import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/container.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/component.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/ingredient.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/method.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/recipe.dart';

class Kitchen {

  List<Container> mixingbowls;
  List<Container> bakingdishes;
  Map<String, Recipe>	recipes;
  Recipe recipe;
  bool valid;
  List<String> error;
  List<String> meal;

  Kitchen(Map<String, Recipe> recipes, Recipe mainrecipe, List<Container> mbowls, List<Container> bdishes, String language) {
    this.valid = true;
    this.meal = new List<String>();
    this.error = new List<String>();
    this.recipes = recipes;
    //start with at least 1 mixing bowl.
    int maxbowl = 0, maxdish = -1;
    this.recipe = mainrecipe;
    if (this.recipe.getMethods() != null) {
      this.recipe.getMethods().forEach((m) {
        if (m.bakingdish != null && m.bakingdish > maxdish)
          maxdish = m.bakingdish;
        if (m.mixingbowl != null && m.mixingbowl > maxbowl)
          maxbowl = m.mixingbowl;
      });

      this.mixingbowls = new List<Container>(
          mbowls == null ? maxbowl + 1 : max(maxbowl + 1, mbowls.length));
      for (int i = 0; i < this.mixingbowls.length; i++)
        this.mixingbowls[i] = new Container(null);
      if (mbowls != null) {
        for (int i = 0; i < mbowls.length; i++) {
          this.mixingbowls[i] = new Container(mbowls[i]);
        }
      }

      this.bakingdishes = new List<Container>(
          bdishes == null ? maxdish + 1 : max(maxdish + 1, bdishes.length));
      for (int i = 0; i < this.bakingdishes.length; i++)
        this.bakingdishes[i] = new Container(null);
      if (bdishes != null) {
        for (int i = 0; i < bdishes.length; i++) {
          this.bakingdishes[i] = new Container(bdishes[i]);
        }
      }
    } else {
      valid = false;
      error.add('chef_error_structure_recipe');
      error.add('chef_error_structure_recipe_methods');
      error.add('chef_error_syntax_method');
      error.add('');
    }
  }

  Container cook(String additionalIngredients, String language)  {
    int ingredientIndex = 0;
    List<String> input = additionalIngredients.split(' ');

    Map<String,Ingredient> ingredients = recipe.getIngredients();
    List<Method> methods = recipe.getMethods();
    var loops = List<_LoopData>();
    Component c;
    int i = 0;
    bool deepfrozen = false;
    methodloop: while (i < methods.length && !deepfrozen) {
      Method m = methods[i];
      switch (m.type) {
        case Type.Invalid:
          valid = false;
          error.add('chef_error_syntax_method');
          error.add(m.ingredient);
          error.add('chef_error_syntax_method_unsupported');
          return null;
          break;
        case Type.Take :
        case Type.Put :
        case Type.Fold :
        case Type.Add :
        case Type.Remove :
        case Type.Combine :
        case Type.Divide :
        case Type.Liquefy :
        case Type.StirInto :
        case Type.Verb :
          if (ingredients[m.ingredient] == null){
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString());
            error.add('chef_error_runtime_ingredient_not_found');
            error.add(m.ingredient);
            error.add('');
            return null;
          }
      }
      switch (m.type) {
        case Type.Take :
          if ((input.join('') != '') && (ingredientIndex <= input.length - 1)) {
            ingredients[m.ingredient].setAmount(int.parse(input[ingredientIndex]));
            ingredientIndex++;
          } else {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_missing_input');
            error.add('');
            return null;
          }
          break;
        case Type.Put :
          mixingbowls[m.mixingbowl].push( Component.Contructor1(ingredients[m.ingredient]));
          break;
        case Type.Fold :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_folded_from_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          c = mixingbowls[m.mixingbowl].pop();
          ingredients[m.ingredient].setAmount(c.getValue());
          ingredients[m.ingredient].setState(c.getState());
          break;
        case Type.Add :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_add_to_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          c = mixingbowls[m.mixingbowl].peek();
          c.setValue(c.getValue() + ingredients[m.ingredient].getAmount());
          break;
        case Type.Remove : // ingredient.amount from mixingbowl
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_remove_from_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          c = mixingbowls[m.mixingbowl].peek(); // returns top of m.mixingbowl
          c.setValue(c.getValue() - ingredients[m.ingredient].getAmount());
          break;
        case Type.Combine :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_combine_with_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          c = mixingbowls[m.mixingbowl].peek();
          c.setValue(c.getValue() * ingredients[m.ingredient].getAmount());
          break;
        case Type.Divide :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_divide_from_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          c = mixingbowls[m.mixingbowl].peek();
          c.setValue((c.getValue() ~/ ingredients[m.ingredient].getAmount()).round());
          break;
        case Type.AddDry :
          int sum = 0;
          ingredients.forEach((key, value) {
            if (value.getState() == State.Dry)
              sum += value.getAmount();
          });
          mixingbowls[m.mixingbowl].push(new Component(sum, State.Dry, ''));
          break;
        case Type.Liquefy :
          ingredients[m.ingredient].liquefy();
          break;
        case Type.LiquefyBowl :
          mixingbowls[m.mixingbowl].liquefy();
          break;
        case Type.Stir :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_stir_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          mixingbowls[m.mixingbowl].stir(m.time);
          break;
        case Type.StirInto :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_stir_in_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          mixingbowls[m.mixingbowl].stir(ingredients[m.ingredient].getAmount());
          break;
        case Type.Mix :
          if (mixingbowls[m.mixingbowl].size() == 0) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_mix_empty_mixing_bowl');
            error.add('chef_error_runtime_method_step');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.mixingbowl + 1).toString());
            error.add('');
            return null;
          }
          mixingbowls[m.mixingbowl].shuffle();
          break;
        case Type.Clean :
          mixingbowls[m.mixingbowl].clean();
          break;
        case Type.Pour :
          bakingdishes[m.bakingdish].combine(mixingbowls[m.mixingbowl]);
          break;
        case Type.Verb :
          int end = i+1;
          for (; end < methods.length; end++)
            if (_sameVerb(m.verb, methods[end].verb) && methods[end].type == Type.VerbUntil)
              break;
          if (end == methods.length) {
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_method_loop');
            error.add(m.n.toString() + ' : ' + m.type.toString());
            error.add('');
            return null;
          }
          if (ingredients[m.ingredient].getAmount() <= 0) {
            i = end + 1;
            continue methodloop;
          }
          else
            loops.insertAll(0,{_LoopData(i, end, m.verb)});
          break;
        case Type.VerbUntil :
          if (!_sameVerb(loops[0].verb, m.verb)){
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_method_loop_end');
            error.add(m.n.toString() + ' : ' + m.type.toString());
            error.add('');
            return null;
          }
          if (ingredients[m.ingredient] != null)
            ingredients[m.ingredient].setAmount(ingredients[m.ingredient].getAmount() - 1);
          i = loops[0].from;
          loops.removeAt(0);
          continue methodloop;
        case Type.SetAside :
          if (loops.length == 0){
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_method_loop_aside');
            error.add(m.n.toString() + ' : ' + m.type.toString());
            error.add('');
            return null;
          }
          else {
            i = loops[0].to + 1;
            loops.removeAt(0);
            continue methodloop;
          }
          break;
        case Type.Serve :
          if (recipes[m.auxrecipe.toLowerCase()] == null){
            valid = false;
            error.add('chef_error_runtime');
            error.add('chef_error_runtime_method_aux_recipe');
            error.add(m.n.toString() + ' : ' + m.type.toString() + ' => ' + m.auxrecipe);
            error.add('');
            return null;
          }
          Kitchen k = new Kitchen(recipes, recipes[m.auxrecipe.toLowerCase()], mixingbowls, bakingdishes, language);
          Container con = k.cook(additionalIngredients, language);
          mixingbowls[0].combine(con);
          break;
        case Type.Refrigerate :
          if (m.time > 0)
            _serve(m.time);
          deepfrozen = true;
          break;
        case Type.Remember :
          break;
        default :{
          valid = false;
          error.add('chef_error_runtime');
          error.add('chef_error_syntax_method_unsupported');
          error.add(m.n.toString() + ' : ' + m.type.toString());
          error.add('');
          return null;
        }
      }
      i++;
    } // end of MethodLoop - all is done
    if (recipe.getServes() > 0 && !deepfrozen) {
      _serve(recipe.getServes());
    }
    if (mixingbowls.length > 0) {
      return mixingbowls[0];
    } // end of auxiliary recipe
    return null;  // end of mainrecipe
  } // cook

  bool _sameVerb(String imp, String verb) {
    if (verb == null || imp == null)
      return false;
    verb = verb.toLowerCase();
    imp = imp.toLowerCase();
    int L = imp.length;
    return verb==imp || //A = A
        verb == ('ge' + imp.substring(0, L - 1) + 't') || // suche  ~ gesucht   füttere ~ gefüttert
        verb==(imp + "n") || //shake ~ shaken
        verb==(imp + "d") || //prepare ~ prepared
        verb==(imp + "ed") || //monitor ~ monitored
        verb==(imp + (imp[L - 1]) + "ed") || //stir ~ stirred
        (imp[L - 1] == 'y' && verb == (imp.substring(0, L - 1) + "ied")); //carry ~ carried
  }

  void _serve(int n) {
    for (int i = 0; i < n && i < bakingdishes.length; i++) {
      meal.add(bakingdishes[i].serve());
    }
  }
}



class _LoopData {

  int from, to;
  String verb;

  _LoopData( int from, int to, String verb) {
    this.from = from;
    this.to = to;
    this.verb = verb;
  }
}
