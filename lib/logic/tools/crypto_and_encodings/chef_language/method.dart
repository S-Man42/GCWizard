
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
print('analyse METHOD '+n.toString()+' '+line);
    line = line.trim();
    this.n = n;
    List<RegExp> matchers = [
      RegExp(r"^take ([a-zA-Z ]+) from refrigerator$"),
      RegExp(r"^(put|fold) ([a-zA-Z ]+) into( the)?( (\d+)(nd|rd|th|st))? mixing bowl$"),
      RegExp(r"^add dry ingredients( to( (\d+)(nd|rd|th|st))? mixing bowl)?$"),
      RegExp(r"^(add|remove|combine|divide) ([a-zA-Z ]+?)( (to|into|from)( (\d+)(nd|rd|th|st))? mixing bowl)?$"),
      RegExp(r"^liquefy contents of the( (\d+)(nd|rd|th|st))? mixing bowl$"),
      RegExp(r"^liquefy ([a-zA-Z ]+)$"),
      RegExp(r"^stir( the( (\d+)(nd|rd|th|st))? mixing bowl)? for (\\d+) minutes$"),
      RegExp(r"^stir ([a-zA-Z ]+) into the( (\d+)(nd|rd|th|st))? mixing bowl$"),
      RegExp(r"^mix( the( (\d+)(nd|rd|th|st))? mixing bowl)? well$"),
      RegExp(r"^clean( (\d+)(nd|rd|th|st))? mixing bowl$"),
      RegExp(r"^pour contents of the( (\d+)(nd|rd|th|st))? mixing bowl into the( (\d+)(nd|rd|th|st))? baking dish$"),
      RegExp(r"^set aside$"),
      RegExp(r"^refrigerate( for (\d+) hours)?$"),
      RegExp(r"^serve with ([a-zA-Z ]+)$"),
      RegExp(r"^suggestion: (.*)$"),
      RegExp(r"^([a-zA-Z]+?)( the ([a-zA-Z ]+))? until ([a-zA-Z]+)$"),
      RegExp(r"^([a-zA-Z]+) the ([a-zA-Z ]+)$")
    ];
    if (matchers[0].hasMatch(line)) {// take
        ingredient = matchers[0].firstMatch(line).group(1);
        type = Type.Take;
    } else if (matchers[1].hasMatch(line)) {// put | fold
print('anaylse METHOD '+line);
        type = matchers[1].firstMatch(line).group(1)==("put") ? Type.Put : Type.Fold;
        ingredient = matchers[1].firstMatch(line).group(2);
        mixingbowl = (matchers[1].firstMatch(line).group(5) == null ? 1 : int.parse(matchers[1].firstMatch(line).group(5))) - 1;
print('               => '+matchers[1].firstMatch(line).group(1)+'.'+matchers[1].firstMatch(line).group(2)+'.'+mixingbowl.toString());
    } else if (matchers[2].hasMatch(line)) {// add dry ingredients
        type = Type.AddDry;
        mixingbowl = (matchers[2].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[2].firstMatch(line).group(3))) - 1;
    } else if (matchers[3].hasMatch(line)) {// add | remove | combine | divide
      // group 1  type
      // group 2 ingredient
      // group 6 nr mixing bowl
print('anaylse METHOD '+line);
        switch (matchers[3].firstMatch(line).group(1)) {
          case 'add':  type = Type.Add; break;
          case 'remove':  type = Type.Remove; break;
          case 'combine':  type = Type.Combine; break;
          case 'divide':  type = Type.Divide; break;
        }
        ingredient = matchers[3].firstMatch(line).group(2);
        mixingbowl = (matchers[3].firstMatch(line).group(6) == null ? 1 : int.parse(matchers[3].firstMatch(line).group(6))) - 1;
print('anaylse METHOD '+line + ' => '+matchers[3].firstMatch(line).group(1)+'.'+matchers[3].firstMatch(line).group(2)+'.'+mixingbowl.toString());
    } else if (matchers[4].hasMatch(line)) {//liquefy contents
        type = Type.LiquefyBowl;
        mixingbowl = (matchers[4].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[4].firstMatch(line).group(2))) - 1;
    } else if (matchers[5].hasMatch(line)) {//liquefy
        type = Type.Liquefy;
        ingredient = matchers[5].firstMatch(line).group(1);
    } else if (matchers[6].hasMatch(line)) {// stir the
        type = Type.Stir;
        mixingbowl = (matchers[6].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[6].firstMatch(line).group(3))) - 1;
        time = int.parse(matchers[6].firstMatch(line).group(5));
    } else if (matchers[7].hasMatch(line)) {// stir into
        type = Type.StirInto;
        ingredient = matchers[7].firstMatch(line).group(1);
        mixingbowl = (matchers[7].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[7].firstMatch(line).group(3))) - 1;
    } else if (matchers[8].hasMatch(line)) {// mix
        type = Type.Mix;
        mixingbowl = (matchers[8].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[8].firstMatch(line).group(3))) - 1;
    } else if (matchers[9].hasMatch(line)) {// clean
        type = Type.Clean;
        mixingbowl = (matchers[9].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[9].firstMatch(line).group(2))) - 1;
    } else if (matchers[10].hasMatch(line)) {// pour
        type = Type.Pour;
        mixingbowl = (matchers[10].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(2))) - 1;
        bakingdish = (matchers[10].firstMatch(line).group(5) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(5))) - 1;
    } else if (matchers[11].hasMatch(line)) {// set aside
        type = Type.SetAside;
    } else if (matchers[12].hasMatch(line)) {// refridgerate
        type = Type.Refrigerate;
        time = matchers[12].firstMatch(line).group(2) == null ? 0 : int.parse(matchers[12].firstMatch(line).group(2));
    } else if (matchers[13].hasMatch(line)) {// serve with
        type = Type.Serve;
        auxrecipe = matchers[13].firstMatch(line).group(1);
    } else if (matchers[14].hasMatch(line)) {// suggestion
        type = Type.Remember;
    } else if (matchers[15].hasMatch(line)) {// xxx the ingredient until yyyed
      // group 3 ingredient
      // group 4 verb ed
        type = Type.VerbUntil;
        verb = matchers[15].firstMatch(line).group(4);
        if (matchers[15].firstMatch(line).group(3) != null) {
          ingredient = matchers[15].firstMatch(line).group(3);
          print('method type.verbuntil '+verb+' '+ingredient);
        } else
          print('method type.verbuntil '+verb);
    } else if (matchers[16].hasMatch(line)) {// yyy the ingredient
        type = Type.Verb;
        verb = matchers[16].firstMatch(line).group(1);
        ingredient = matchers[16].firstMatch(line).group(2);
print('method type.verb '+verb+' '+ingredient);
    } else { // invalid method
        type = Type.Invalid;
        ingredient = line;
    }
  }
}