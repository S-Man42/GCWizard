import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chefException.dart';

/*
import java.util.regex.Matcher;
import java.util.regex.Pattern;
*/
enum Type {Take, Put, Fold, Add, Remove, Combine, Divide, AddDry, Liquefy, LiquefyBowl, Stir, StirInto,
  Mix, Clean, Pour, Verb, VerbUntil, SetAside, Serve, Refrigerate, Remember, Invalid}

class Method {

  String ingredient;
  int mixingbowl;
  int bakingdish;
  String auxrecipe;
  int time; 		//'Refrigerate for number of hours' / 'Stir for number of minutes'
  String verb;
  Type type;
  int n;

  Method(String line, int n) {
    line = line.trim();
    this.n = n;
    List<RegExp> matchers = [
      RegExp(r"^take ([a-zA-Z ]+) from refrigerator"),
      RegExp(r"^(put|fold) ([a-zA-Z ]+) into( the)?( (\\d+)(nd|rd|th|st))? mixing bowl"),
      RegExp(r"^add dry ingredients( to( (\\d+)(nd|rd|th|st))? mixing bowl)?"),
      RegExp(r"^(add|remove|combine|divide) ([a-zA-Z ]+)( (to|into|from)( (\\d+)(nd|rd|th|st))? mixing bowl)?"),
      RegExp(r"^liquefy contents of the( (\\d+)(nd|rd|th|st))? mixing bowl"),
      RegExp(r"^liquefy ([a-zA-Z ]+)"),
      RegExp(r"^stir( the( (\\d+)(nd|rd|th|st))? mixing bowl)? for (\\d+) minutes"),
      RegExp(r"^stir ([a-zA-Z ]+) into the( (\\d+)(nd|rd|th|st))? mixing bowl"),
      RegExp(r"^mix( the( (\\d+)(nd|rd|th|st))? mixing bowl)? well"),
      RegExp(r"^clean( (\\d+)(nd|rd|th|st))? mixing bowl"),
      RegExp(r"^pour contents of the( (\\d+)(nd|rd|th|st))? mixing bowl into the( (\\d+)(nd|rd|th|st))? baking dish"),
      RegExp(r"^set aside"),
      RegExp(r"^refrigerate( for (\\d+) hours)?"),
      RegExp(r"^serve with ([a-zA-Z ]+)"),
      RegExp(r"^suggestion: (.*)"),
      RegExp(r"^([a-zA-Z]+?)( the ([a-zA-Z ]+))? until ([a-zA-Z]+)"),
      RegExp(r"^([a-zA-Z]+) the ([a-zA-Z ]+)")
    ];
    if (matchers[0].hasMatch(line)) {// take
      ingredient = matchers[0].firstMatch(line).group(1);
      type = Type.Take;
    }
    else if (matchers[1].hasMatch(line)) {// put | fold
      type = matchers[1].firstMatch(line).group(1)==("put") ? Type.Put : Type.Fold;
      ingredient = matchers[1].firstMatch(line).group(2);
      mixingbowl = (matchers[1].firstMatch(line).group(5) == null ? 1 : int.parse(matchers[1].firstMatch(line).group(5))) - 1;
    }
    else if (matchers[2].hasMatch(line)) {// add dry ingredients
      type = Type.AddDry;
      mixingbowl = (matchers[2].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[2].firstMatch(line).group(3))) - 1;
    }
    else if (matchers[3].hasMatch(line)) {// add | remove | combine | divide
      switch (matchers[3].firstMatch(line).group(1)) {
        case 'add':  type = Type.Add; break;
        case 'remove':  type = Type.Remove; break;
        case 'combine':  type = Type.Combine; break;
        case 'divide':  type = Type.Divide; break;
      }
      //type = matchers[3].firstMatch(line).group(1)==("add") ? Type.Add : (matchers[3].firstMatch(line).group(1)==("Remove") ? Type.Remove : (matchers[3].firstMatch(line).group(1)==("Combine") ? Type.Combine : Type.Divide));
      ingredient = matchers[3].firstMatch(line).group(2);
      mixingbowl = (matchers[3].firstMatch(line).group(6) == null ? 1 : int.parse(matchers[3].firstMatch(line).group(6))) - 1;
print(line + ' => '+ingredient);
    }
    else if (matchers[4].hasMatch(line)) {//liquefy contents
      type = Type.LiquefyBowl;
      mixingbowl = (matchers[4].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[4].firstMatch(line).group(2))) - 1;
    }
    else if (matchers[5].hasMatch(line)) {//liquefy
      type = Type.Liquefy;
      ingredient = matchers[5].firstMatch(line).group(1);
    }
    else if (matchers[6].hasMatch(line)) {// stir the
      type = Type.Stir;
      mixingbowl = (matchers[6].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[6].firstMatch(line).group(3))) - 1;
      time = int.parse(matchers[6].firstMatch(line).group(5));
    }
    //Stir ingredient into the [nth] mixing bowl.
    else if (matchers[7].hasMatch(line)) {// stir into
      type = Type.StirInto;
      ingredient = matchers[7].firstMatch(line).group(1);
      mixingbowl = (matchers[7].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[7].firstMatch(line).group(3))) - 1;
    }
    else if (matchers[8].hasMatch(line)) {// mix
      type = Type.Mix;
      mixingbowl = (matchers[8].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[8].firstMatch(line).group(3))) - 1;
    }
    else if (matchers[9].hasMatch(line)) {// clean
      type = Type.Clean;
      mixingbowl = (matchers[9].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[9].firstMatch(line).group(2))) - 1;
    }
    else if (matchers[10].hasMatch(line)) {// pour
      type = Type.Pour;
      mixingbowl = (matchers[10].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(2))) - 1;
      bakingdish = (matchers[10].firstMatch(line).group(5) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(5))) - 1;
    }
    else if (matchers[11].hasMatch(line)) {// set aside
      type = Type.SetAside;
    }
    else if (matchers[12].hasMatch(line)) {// refridgerate
      type = Type.Refrigerate;
      time = matchers[12].firstMatch(line).group(2) == null ? 0 : int.parse(matchers[12].firstMatch(line).group(2));
    }
    else if (matchers[13].hasMatch(line)) {// serve with
      type = Type.Serve;
      auxrecipe = matchers[13].firstMatch(line).group(1);
    }
    else if (matchers[14].hasMatch(line)) {// suggestion
      type = Type.Remember;
    }
    else if (matchers[15].hasMatch(line)) {// xxx th xxx until
      type = Type.VerbUntil;
      verb = matchers[15].firstMatch(line).group(4);
      ingredient = matchers[15].firstMatch(line).group(3);
      print('method type.verbuntil '+verb+' '+ingredient);
    }
    else if (matchers[16].hasMatch(line)) {// xxx the xxx
      type = Type.Verb;
      verb = matchers[16].firstMatch(line).group(1);
      ingredient = matchers[16].firstMatch(line).group(2);
print('method type.verb '+verb+' '+ingredient);
    }
    else {
      type = Type.Invalid;
      ingredient = line;
      //throw ChefException.Contructor2(ChefException.METHOD, n, line, "Unsupported method found!");
    }
  }
}