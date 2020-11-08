/*
// package interpreter;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/recipe.dart';

//@SuppressWarnings("serial")
class ChefException implements  Exception {
  static int STRUCTURAL = 0;
  static int LOCAL = 1;
  static int INGREDIENT = 2;
  static int METHOD = 3;

  ChefException(int type, String text) {
    Exception(_typeToText(type)+text);
  }

  ChefException.Contructor1(int type, List<String> a, String error) {
    Exception("Ingredient wrongly formatted: '"+arrayToString(a,' ')+"' ("+error+")");
  }

  ChefException.Contructor2(int type, int step, String method, String error) {
    Exception("Method error, step "+(step+1).toString()+": "+method+" ("+error+")");
  }

  ChefException.Contructor3(int type, Recipe recipe, int step, String method, String error) {
    Exception("Method error, recipe "+recipe.getTitle()+", step "+(step+1).toString()+": "+method+" ("+error+")");
  }

  static String _typeToText(int type) {
    return type == STRUCTURAL ? "Structural error: " : "Local error: ";
  }

  static String arrayToString(List<Object> a, String separator) {
    String result = "";
    if (a.length > 0) {
      result = a[0].toString();
      for (int i=1; i<a.length; i++) {
        result += separator + a[i].toString();
      }
    }
    return result;
  }
}*/
