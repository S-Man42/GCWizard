import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/beatnik_language.dart';
import 'package:gc_wizard/logic/tools/games/scrabble_sets.dart';

void main() {

  group("beatnik_language.interpret", () {
    //https://en.wikipedia.org/wiki/Beatnik_(programming_language)
    //https://esolangs.org/wiki/beatnik
    //http://cliffle.com/esoterica/beatnik/
    //   does not work - to much adds => delete two - baser, lilac
    //                 - numbers wrong: queasy => queasiest
    //                 - prints in thw wrong order

    String HelloWorld = '''Soars, larkspurs, rains. 
Indistinctness.
Mario snarl (nurses, natures, rules...) sensuously retries goal.
Agribusinesses' costs par lain ropes (mopes) autos' cores.
Tuner ambitiousness.
Flit.
Dour entombment.
Legals' saner kinking lapse.
Nests glint.
Dread, tied futures, dourer usual tumor grunts alter atonal
  garb tries shouldered coins.
Taste a vast lustiness.
Stile stuns gad subgroup gram lanes.
Draftee insurer road: cuckold blunt, strut sunnier.
Rely enure pantheism: arty gain groups (genies, pan) titters, tattles, nears.
Bluffer tapes?  Idle diatom stooge!
Feted antes anklets ague?  Remit goiter gout!
Doubtless teared toed alohas will dull gangs' aerials' tails' sluices;
Gusset ends!  Gawkier halo!

Enter abstruse rested loser beer guy louts.
Curtain roams lasso weir lupus stunt.
Truant bears animate talon.  Entire torte originally timer.
Redo stilt gobs.

Utter centaurs;
Urgent stars;
Usurers (dilute);
Noses;
Bones;
Brig sonar graders;
Utensil silts;
Lazies.
Fret arson veterinary rows.

Atlas grunted: "Pates, slues, sulfuric manor liaising tines,
  trailers, rep... unfair!  Instant snots!"

Sled rested until eatery fail.
Ergs fortitude
  Indent spotter
Euros enter egg.
Curious tenures.
Torus cutlasses.
Sarong torso earns cruel lags it reeled.

Engineer: "Erase handbag -- unite ratification!"

oaring oaten donkeys unsold, surer rapid saltest tags
BUTTERED TIBIA LUGS REWIRING TOILETS
anion festers raring edit epilogues.
DIRGE ROTOR.
linnet oaring.
GORE BOOTIES.
Ironed goon lists tallest sublets --
Riots,
Raucous onset.

Ignobly, runners' diet anguishes sunrise loner.
Erode mob, slier switcher!
Loaners stilt drudge pearl atoll, risking hats' ends.

Rebind sitters.

Toga epistles -- crud lard.  (Pager purse dons souls.)

glob title a curio hired rites shed suds lade grease strut arctic revs toad
unless idlers rind stilt region land GERMICIDES SULTANA GUTS gill siting leans
nice spurs
tests gloves
roused asp

Holes!  Moles!  (Sores!)
Hygienists!  Scars!  (Asses!)
Smells spell rares.

Cubs instant sing in parse goodies.
Rosin.  Unhelpful sisal acres.  Slope told.
MALENESS PASTA LAB.  "Infirmary vine," rang illiterates (beans).
Rosin sours, insults truss abalones, nailed rules, helical atlases.
Dear remodeling stings mar rents.
Sunless shiner orb (silly idol.)
Clarity disses senna.
Vagabonds sauted; sloes performed gelds.
Alter post radial lip sectioning gums.
Saint Towellings.
Larger aeons telephone stolid char, pal!
Boats Dean forsook, rosters, tunas, terrariums -- united, traced.
Nude pagoda careens.''';
    String Rudimentary = '''Hello, aunts! Around, around, swim!Hello, aunts! Around, around, swim!''';
    String Alphabet = '''Ho humbuzz, Dionysus. | orgasm if I feel altruistic & alone...
    Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch?! Ha!
    Monarchies spoil; language intermediates everyone!''';
    String Cliffle = '''Baa, badassed areas!
Jarheads' arses
      queasy nude adverbs!
    Dare address abase adder? *bares baser dadas* HA!
Equalize, add bezique, bra emblaze.
  He (quezal), aeons liable.  Label lilac "bulla," ocean sauce!
Ends, addends,
   duodena sounded amends.''';
    String testTitleCommentsTimeTemp = '''''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'scrabbleSet' : scrabbleID_EN, 'sourcecode' : HelloWorld, 'input' : '', 'expectedOutput' : ['Hello, world!']},
      {'scrabbleSet' : scrabbleID_EN, 'sourcecode' : Rudimentary, 'input' : 'a', 'expectedOutput' : ['h']},
      {'scrabbleSet' : scrabbleID_EN, 'sourcecode' : Alphabet, 'input' : '', 'expectedOutput' : [' !"#\$%&'+"'"+'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~']},
      {'scrabbleSet' : scrabbleID_EN, 'sourcecode' : Cliffle, 'input' : '', 'expectedOutput' : ['beatnik_error_runtime','beatnik_error_runtime_stack','beatnik_error_runtime_add']},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = interpretBeatnik(elem['scrabbleSet'], elem['sourcecode'], elem['input']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual.output[i], elem['expectedOutput'][i]);
        }
      });
    });
  });


}