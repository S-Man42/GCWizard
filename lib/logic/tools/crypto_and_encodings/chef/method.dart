

enum Type {Take, Put, Fold, Add, Remove, Combine, Divide, AddDry, Liquefy, LiquefyBowl, Stir, StirInto, Mix, Clean, Pour,
  Verb, VerbUntil, SetAside, Serve, Refrigerate, Remember}

class Method {
  String ingredient;
  int mixingbowl;
  int bakingdish;
  String auxrecipe;
  int time; //'Refrigerate for number of hours' / 'Stir for number of minutes'
  String verb;
  Type type;
  int n;

Method(String line, int n) {
  line = line.trim();
  this.n = n;
  RegExp expr = new RegExp('^Take ([a-zA-Z ]+) from refrigerator.\$');
  if (expr.hasMatch(line)) {
    ingredient = expr.firstMatch(line).group(0);
    type = Type.Take;
  } else {
    RegExp expr = new RegExp(
        '^(Put|Fold) ([a-zA-Z ]+) into( the)?( (\\d+)(nd|rd|th|st))? mixing bowl.\$');
    if (expr.hasMatch(line)) {
      type = expr.firstMatch(line).group(1) == 'Put' ? Type.Put : Type.Fold;
      ingredient = expr.firstMatch(line).group(2);
      mixingbowl = expr.firstMatch(line).group(5) == null ? 1 : int.parse(
          expr.firstMatch(line).group(5)) - 1;
    } else {
      RegExp expr = new RegExp(
          '^Add dry ingredients( to( (\\d+)(nd|rd|th|st))? mixing bowl)?.\$');
      if (expr.hasMatch(line)) {
        type = Type.AddDry;
        mixingbowl = expr.firstMatch(line).group(3) == null ? 1 : int.parse(
            expr.firstMatch(line).group(3)) - 1;
      } else {
        RegExp expr = new RegExp(
            '^(Add|Remove|Combine|Divide) ([a-zA-Z ]+?)( (to|into|from)( (\\d+)(nd|rd|th|st))? mixing bowl)?.\$');
        if (expr.hasMatch(line)) {
          type =
          expr.firstMatch(line).group(1) == 'Add' ? Type.Add : (expr.firstMatch(
              line).group(1) == 'Remove' ? Type.Remove : (expr.firstMatch(line)
              .group(1) == 'Combine') ? Type.Combine : Type.Divide);
          ingredient = expr.firstMatch(line).group(2);
          mixingbowl = (expr.firstMatch(line).group(6) == null ? 1 : int.parse(
              expr.firstMatch(line).group(6))) - 1;
        } else {
          RegExp expr = new RegExp(
              '^Liquefy contents of the( (\\d+)(nd|rd|th|st))? mixing bowl.\$');
          if (expr.hasMatch(line)) {
            type = Type.LiquefyBowl;
            mixingbowl =
                (expr.firstMatch(line).group(2) == null ? 1 : int.parse(
                    expr.firstMatch(line).group(2))) - 1;
          } else {
            RegExp expr = new RegExp('^Liquefy ([a-zA-Z ]+).\$');
            if (expr.hasMatch(line)) {
              type = Type.Liquefy;
              ingredient = expr.firstMatch(line).group(1);
            } else {
              RegExp expr = new RegExp(
                  '^Stir( the( (\\d+)(nd|rd|th|st))? mixing bowl)? for (\\d+) minutes.\$');
              if (expr.hasMatch(line)) {
                type = Type.Stir;
                mixingbowl =
                    (expr.firstMatch(line).group(3) == null ? 1 : int.parse(
                        expr.firstMatch(line).group(3))) - 1;
                time = int.parse(expr.firstMatch(line).group(5));
              } else {
                RegExp expr = new RegExp(
                    '^Stir ([a-zA-Z ]+) into the( (\\d+)(nd|rd|th|st))? mixing bowl.\$');
                if (expr.hasMatch(line)) {
                  type = Type.StirInto;
                  ingredient = expr.firstMatch(line).group(1);
                  mixingbowl =
                      (expr.firstMatch(line).group(3) == null ? 1 : int.parse(
                          expr.firstMatch(line).group(3))) - 1;
                } else {
                  RegExp expr = new RegExp(
                      '^Mix( the( (\\d+)(nd|rd|th|st))? mixing bowl)? well.\$');
                  if (expr.hasMatch(line)) {
                    type = Type.Mix;
                    mixingbowl =
                        (expr.firstMatch(line).group(3) == null ? 1 : int.parse(
                            expr.firstMatch(line).group(3))) - 1;
                  } else {
                    RegExp expr = new RegExp(
                        '^Clean( (\\d+)(nd|rd|th|st))? mixing bowl.\$');
                    if (expr.hasMatch(line)) {
                      type = Type.Clean;
                      mixingbowl =
                          (expr.firstMatch(line).group(2) == null ? 1 : int
                              .parse(expr.firstMatch(line).group(2))) - 1;
                    } else {
                      RegExp expr = new RegExp(
                          '^Pour contents of the( (\\d+)(nd|rd|th|st))? mixing bowl into the( (\\d+)(nd|rd|th|st))? baking dish.\$');
                      if (expr.hasMatch(line)) {
                        type = Type.Pour;
                        mixingbowl =
                            (expr.firstMatch(line).group(2) == null ? 1 : int
                                .parse(expr.firstMatch(line).group(2))) - 1;
                        bakingdish =
                            (expr.firstMatch(line).group(5) == null ? 1 : int
                                .parse(expr.firstMatch(line).group(5))) - 1;
                      } else {
                        RegExp expr = new RegExp('^Set aside.\$');
                        if (expr.hasMatch(line)) {
                          type = Type.SetAside;
                        } else {
                          RegExp expr = new RegExp(
                              '^Refrigerate( for (\\d+) hours)?.\$');
                          if (expr.hasMatch(line)) {
                            type = Type.Refrigerate;
                            time = expr.firstMatch(line).group(2) == null
                                ? 0
                                : int.parse(expr.firstMatch(line).group(2));
                          } else {
                            RegExp expr = new RegExp(
                                '^Serve with ([a-zA-Z ]+).\$');
                            if (expr.hasMatch(line)) {
                              type = Type.Serve;
                              auxrecipe = expr.firstMatch(line).group(1);
                            } else {
                              RegExp expr = new RegExp('^Suggestion: (.*).\$');
                              if (expr.hasMatch(line)) {
                                type = Type.Remember;
                              } else {
                                RegExp expr = new RegExp(
                                    '^([a-zA-Z]+?)( the ([a-zA-Z ]+))? until ([a-zA-Z]+).\$');
                                if (expr.hasMatch(line)) {
                                  type = Type.VerbUntil;
                                  verb = expr.firstMatch(line).group(4);
                                  ingredient = expr.firstMatch(line).group(3);
                                } else {
                                  RegExp expr = new RegExp(
                                      '^([a-zA-Z]+) the ([a-zA-Z ]+).\$');
                                  if (expr.hasMatch(line)) {
                                    type = Type.Verb;
                                    verb = expr.firstMatch(line).group(1);
                                    ingredient = expr.firstMatch(line).group(2);
                                  } else {
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
}