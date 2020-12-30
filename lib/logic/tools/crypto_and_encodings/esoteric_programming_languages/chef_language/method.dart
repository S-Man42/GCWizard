
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/chef_international.dart';

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

  Method(String line, int n, language) {
    line = line.trim();
    this.n = n;
    List<RegExp> matchers = new List<RegExp>();
    if (language == 'ENG') {
      matchers = matchersENG;
      if (matchers[0].hasMatch(line)) {// take
        ingredient = matchers[0].firstMatch(line).group(2);
        type = Type.Take;

      } else if (matchers[1].hasMatch(line)) {// put | fold
        if (matchers[1].firstMatch(line).group(1) == 'put')
          type = Type.Put;
        else
          type = Type.Fold;
        ingredient = matchers[1].firstMatch(line).group(3);
        mixingbowl = (matchers[1].firstMatch(line).group(6) == null ? 1 : int.parse(matchers[1].firstMatch(line).group(6))) - 1;

      } else if (matchers[2].hasMatch(line)) {// add dry ingredients
        type = Type.AddDry;
        mixingbowl = (matchers[2].firstMatch(line).group(5) == null ? 1 : int.parse(matchers[2].firstMatch(line).group(5))) - 1;

      } else if (matchers[3].hasMatch(line)) {// add | remove | combine | divide
        switch (matchers[3].firstMatch(line).group(1)) {
          case 'add':  type = Type.Add; break;
          case 'remove':  type = Type.Remove; break;
          case 'combine':  type = Type.Combine; break;
          case 'divide':  type = Type.Divide; break;
        }
        ingredient = matchers[3].firstMatch(line).group(3);
        mixingbowl = (matchers[3].firstMatch(line).group(8) == null ? 1 : int.parse(matchers[3].firstMatch(line).group(8))) - 1;

      } else if (matchers[4].hasMatch(line)) {//liquefy contents
        type = Type.LiquefyBowl;
        mixingbowl = (matchers[4].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[4].firstMatch(line).group(3))) - 1;

      } else if (matchers[5].hasMatch(line)) {//liquefy
        type = Type.Liquefy;
        ingredient = matchers[5].firstMatch(line).group(2);

      } else if (matchers[6].hasMatch(line)) {// stir the
        type = Type.Stir;
        mixingbowl = (matchers[6].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[6].firstMatch(line).group(4))) - 1;
        time = int.parse(matchers[6].firstMatch(line).group(6));

      } else if (matchers[7].hasMatch(line)) {// stir into
        type = Type.StirInto;
        ingredient = matchers[7].firstMatch(line).group(2);
        mixingbowl = (matchers[7].firstMatch(line).group(5) == null ? 1 : int.parse(matchers[7].firstMatch(line).group(5))) - 1;

      } else if (matchers[8].hasMatch(line)) {// mix
        type = Type.Mix;
        mixingbowl = (matchers[8].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[8].firstMatch(line).group(4))) - 1;

      } else if (matchers[9].hasMatch(line)) {// clean
        type = Type.Clean;
        mixingbowl = (matchers[9].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[9].firstMatch(line).group(3))) - 1;

      } else if (matchers[10].hasMatch(line)) {// pour
        type = Type.Pour;
        mixingbowl =  (matchers[10].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(4))) - 1;
        bakingdish = (matchers[10].firstMatch(line).group(8) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(8))) - 1;

      } else if (matchers[11].hasMatch(line)) {// set aside
        type = Type.SetAside;

      } else if (matchers[12].hasMatch(line)) {// refridgerate
        type = Type.Refrigerate;
        time = matchers[12].firstMatch(line).group(2) == null ? 0 : int.parse(matchers[12].firstMatch(line).group(2));

      } else if (matchers[13].hasMatch(line)) {// serve with
        type = Type.Serve;
        auxrecipe = matchers[13].firstMatch(line).group(2);

      } else if (matchers[14].hasMatch(line)) {// suggestion
        type = Type.Remember;

      } else if (matchers[15].hasMatch(line)) {// xxx (the) ingredient until yyyed
        type = Type.VerbUntil;
        verb = matchers[15].firstMatch(line).group(5);
        ingredient = matchers[15].firstMatch(line).group(4);

      } else if (matchers[16].hasMatch(line)) {// yyy (the) ingredient
        type = Type.Verb;
        verb = matchers[16].firstMatch(line).group(1);
        ingredient = matchers[16].firstMatch(line).group(3);

      } else { // invalid method
        type = Type.Invalid;
        ingredient = line;
      }
    } else {
      matchers = matchersDEU;
      if (matchers[0].hasMatch(line)) {// die zutat aus dem kühlschrank nehmen
        ingredient = matchers[0].firstMatch(line).group(2);
        type = Type.Take;

      } else if (matchers[1].hasMatch(line)) {// zutat in die schüssel geben
        type = Type.Put;
        ingredient = matchers[1].firstMatch(line).group(2);
        mixingbowl = (matchers[1].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[1].firstMatch(line).group(4))) - 1;

      } else if (matchers[2].hasMatch(line)) {// zutat in die schüssel unterheben
        type = Type.Fold;
        ingredient = matchers[2].firstMatch(line).group(2);
        mixingbowl = (matchers[2].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[2].firstMatch(line).group(4))) - 1;

      } else if (matchers[3].hasMatch(line)) {// feste zutaten hinzufügen
        type = Type.AddDry;
        mixingbowl = (matchers[3].firstMatch(line).group(8) == null ? 1 : int.parse(matchers[3].firstMatch(line).group(8))) - 1;

      } else if (matchers[4].hasMatch(line)) {// füge hinzu |entferne | kombiniere | teile
        switch (matchers[4].firstMatch(line).group(12)) {
          case 'hinzufügen':
          case 'dazugeben': type = Type.Add; break;
          case 'entfernen':
          case 'abschöpfen':type = Type.Remove; break;
          case 'kombinieren':type = Type.Combine; break;
          case 'teilen': type = Type.Divide; break;
        }
        ingredient = matchers[4].firstMatch(line).group(2);
        mixingbowl = (matchers[4].firstMatch(line).group(7) == null ? 1 : int.parse(matchers[4].firstMatch(line).group(7))) - 1;

      } else if (matchers[5].hasMatch(line)) {//inhalt der schüssel verflüssigen
        type = Type.LiquefyBowl;
        mixingbowl = (matchers[5].firstMatch(line).group(3) == null ? 1 : int.parse(matchers[5].firstMatch(line).group(3))) - 1;

      } else if (matchers[6].hasMatch(line)) {//zutat verflüssigen
        type = Type.Liquefy;
        ingredient = matchers[6].firstMatch(line).group(2);

      } else if (matchers[7].hasMatch(line)) {// schüssel rühren
        type = Type.Stir;
        mixingbowl = (matchers[7].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[7].firstMatch(line).group(4))) - 1;
        time = int.parse(matchers[7].firstMatch(line).group(7));

      } else if (matchers[8].hasMatch(line)) {// zutat unterrühren
        type = Type.StirInto;
        ingredient = matchers[8].firstMatch(line).group(2);
        mixingbowl = (matchers[8].firstMatch(line).group(6) == null ? 1 : int.parse(matchers[8].firstMatch(line).group(6))) - 1;

      } else if (matchers[9].hasMatch(line)) {// mischen
        type = Type.Mix;
        mixingbowl = (matchers[9].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[9].firstMatch(line).group(2))) - 1;

      } else if (matchers[10].hasMatch(line)) {// säubern || waschen
        type = Type.Clean;
        mixingbowl = (matchers[10].firstMatch(line).group(2) == null ? 1 : int.parse(matchers[10].firstMatch(line).group(2))) - 1;

      } else if (matchers[11].hasMatch(line)) {// stürzen || gießen
        type = Type.Pour;
        mixingbowl =  (matchers[11].firstMatch(line).group(4) == null ? 1 : int.parse(matchers[11].firstMatch(line).group(4))) - 1;
        bakingdish = (matchers[11].firstMatch(line).group(12) == null ? 1 : int.parse(matchers[11].firstMatch(line).group(12))) - 1;

      } else if (matchers[12].hasMatch(line)) {// zur seite stellen
        type = Type.SetAside;

      } else if (matchers[13].hasMatch(line)) {// einfrieren
        type = Type.Refrigerate;
        time = matchers[13].firstMatch(line).group(3) == null ? 0 : int.parse(matchers[13].firstMatch(line).group(3));

      } else if (matchers[14].hasMatch(line)) {// serve with
        type = Type.Serve;
        auxrecipe = matchers[14].firstMatch(line).group(2);

      } else if (matchers[15].hasMatch(line)) {// vorschlag
        type = Type.Remember;

      } else if (matchers[16].hasMatch(line)) {// solange yyy bis zutat zur ...
        type = Type.VerbUntil;
        verb = matchers[16].firstMatch(line).group(1);
        ingredient = matchers[16].firstMatch(line).group(4);

      } else if (matchers[17].hasMatch(line)) {// die zutat yyy
        type = Type.Verb;
        verb = matchers[17].firstMatch(line).group(3);
        ingredient = matchers[17].firstMatch(line).group(2);

      } else { // invalid method
        type = Type.Invalid;
        ingredient = line;
      }
    }
  }
}