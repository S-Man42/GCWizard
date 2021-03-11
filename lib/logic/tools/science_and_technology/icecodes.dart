// https://www.code-knacker.de/eiscode.htm
//
// EU     https://eur-lex.europa.eu/legal-content/DE/TXT/PDF/?uri=CELEX:32007R0416
//        S.  83 Ice condition code
//        S.  89 Ice_accessibility_code
//        S.  92 Ice_classification_code
//
// BALTIC https://www.bsh.de/EN/TOPICS/Marine_environment/Ice/Ice_observations/Ice_observations_node.html
//        https://www.bsh.de/DE/THEMEN/Meeresumwelt/Eis/Eisbeobachtungen/eisbeobachtungen_node.html
//
// WMO    https://library.wmo.int/doc_num.php?explnum_id=4651
//        S. 115 Concentration
//        S. 116 Stage of development and thickness - Symbols
//        S. 117 Form of ice
//        S. 118 Stage of melting (ms)
//        S. 119 Snow depth (s)
//
// SIGRID http://www.aari.ru/gdsidb/format/sigrid-1.pdf
//        S. 16 Concentration

enum IceCodeLanguage {DE, EN}
Map<IceCodeLanguage, String> ICECODE_LANGUAGES = {
  IceCodeLanguage.DE : 'common_language_german',
  IceCodeLanguage.EN : 'common_language_english',
};

enum IceCodeSystem {EU, BALTIC, WMO, SIGRID, }
Map<IceCodeSystem, String> ICECODE_SYSTEM = {
  IceCodeSystem.EU : 'icecodes_system_eu',
  IceCodeSystem.BALTIC : 'icecodes_system_baltic',
  IceCodeSystem.WMO : 'icecodes_system_wmo',
  IceCodeSystem.SIGRID : 'icecodes_system_sigrid',
};

enum IceCodeSubSystem {CONDITION, ACCESSIBILITY, CLASSIFICATION, CONCENTRATION, DEVELOPMENT, FORM, MELTING, SNOW, A, S, T, K, SIGRID}
Map<IceCodeSubSystem, String> ICECODE_SUBSYSTEM_EU = {
  IceCodeSubSystem.CONDITION : 'icecodes_system_eu_condition',
  IceCodeSubSystem.ACCESSIBILITY : 'icecodes_system_eu_accessibility',
  IceCodeSubSystem.CLASSIFICATION : 'icecodes_system_eu_classification',
};

Map<IceCodeSubSystem, String> ICECODE_SUBSYSTEM_BALTIC = {
  IceCodeSubSystem.A : 'icecodes_system_baltic_a',
  IceCodeSubSystem.S : 'icecodes_system_baltic_s',
  IceCodeSubSystem.T : 'icecodes_system_baltic_t',
  IceCodeSubSystem.K : 'icecodes_system_baltic_k',
};

Map<IceCodeSubSystem, String> ICECODE_SUBSYSTEM_WMO = {
  IceCodeSubSystem.CONCENTRATION : 'icecodes_system_wmo_concentration',
  IceCodeSubSystem.DEVELOPMENT : 'icecodes_system_wmo_development',
  IceCodeSubSystem.FORM : 'icecodes_system_wmo_form',
  IceCodeSubSystem.MELTING : 'icecodes_system_wmo_melting',
  IceCodeSubSystem.SNOW : 'icecodes_system_wmo_snow',
};

final Map<IceCodeLanguage, Map<IceCodeSystem, Map<IceCodeSubSystem, Map<String, String>>>>ICECODES = {
  IceCodeLanguage.DE : {
    IceCodeSystem.EU : {
      IceCodeSubSystem.CONDITION : {'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '', 'F' : '', 'G' : '', 'H' : '', 'K' : '', 'L' : '', 'M' : '', 'P' : '', 'R' : '', 'S' : '', 'U' : '', 'O' : '', 'V' : '', },
      IceCodeSubSystem.ACCESSIBILITY : {'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '', 'F' : '', 'G' : '', 'H' : '', 'K' : '', 'L' : '', 'M' : '', 'P' : '', 'T' : '', 'X' : '', 'V' : '', },
      IceCodeSubSystem.CLASSIFICATION : {'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '',},
    },
    IceCodeSystem.BALTIC : {
      IceCodeSubSystem.A : {'0' : 'Eisfrei', '1' : 'Offenes Wasser Bedeckungsgrad kleiner 1/10', '2' : 'Sehr lockeres Eis Bedeckungsgrad 1/10 bis 3/10', '3' : 'Lockeres Eis Bedeckungsgrad 4/10 bis 6/10', '4' : 'Dichtes Eis Bedeckungsgrad 7/10 bis 8/10', '5' : 'Sehr dichtes Eis Bedeckungsgrad 9/10 bis 9+/10', '6' : 'Zusammengeschobenes oder zusammenhängendes Eis Bedeckungsgrad 10/10', '7' : 'Eis außerhalb der Festeiskante', '8' : 'Festeis', '9' : 'Rinne in sehr dichtem oder zusammengeschobenem Eis oder entlang der Festeiskante', '/' : 'Außerstande zu melden',},
      IceCodeSubSystem.S : {'0' : 'Neueis oder dunkler Nilas weniger als 5 cm dick', '1' : 'Heller Nilas oder Eishaut 5 bis 10 cm dick', '2' : 'Graues Eis 10 bis 15 cm dick', '3' : 'Grauweißes Eis 15 bis 30 cm dick', '4' : 'Weißes Eis, 1. Stadium 30 bis 50 cm dick', '5' : 'Weißes Eis, 2. Stadium 50 bis 70 cm dick', '6' : 'Mitteldickes erstjähriges Eis 70 bis 120 cm dick', '7' : 'Eis, das überwiegend dünner als 15 cm ist, mit etwas dickerem Eis', '8' : 'Eis, das überwiegend 15 bis 30 cm dick ist, mit etwas dickerem Eis', '9' : 'Eis, das überwiegend dicker als 30 cm ist, mit etwas dünnerem Eis', '/' : 'Keine Information oder außerstande zu melden',},
      IceCodeSubSystem.T : {'0' : 'Pfannkucheneis, Eisbruchstücke, Trümmereis Durchmesser unter 20 m', '1' : 'Kleine Eisschollen Durchmesser 20 bis 100 m', '2' : 'Mittelgroße Eisschollen Durchmesser 100 bis 500 m', '3' : 'Große Eisschollen Durchmesser 500 bis 2000 m', '4' : 'Sehr große oder riesig große Eisschollen oder ebenes Eis Durchmesser über 2000 m', '5' : 'Übereinandergeschobenes Eis', '6' : 'Kompakter Schneebrei oder kompakte Eisbreiklümpchen oder kompaktes Trümmereis', '7' : 'Aufgepresstes Eis (in Form von Hügeln oder Wällen)', '8' : 'Schmelzwasserlöcher oder viele Pfützen auf dem Eis', '9' : 'Morsches Eis', '/' : 'Keine Information oder außerstande zu melden',},
      IceCodeSubSystem.K : {'0' : 'Schifffahrt unbehindert', '1' : 'Schifffahrt für Holzschiffe ohne Eisschutz schwierig oder gefährlich', '2' : 'Schifffahrt für nichteisverstärkte Schiffe oder für Stahlschiffe mit niedriger Maschinenleistung schwierig, für Holzschiffe sogar mit Eisschutz nicht ratsam', '3' : 'Schifffahrt ohne Eisbrecherhilfe ist nur für stark gebaute und für die Eisfahrt geeignete Schiffe mit hoher Maschinenleistung möglich', '4' : 'Schifffahrt verläuft in einer Rinne oder in einem aufgebrochenen Fahrwasser ohne Eisbrecherunterstützung', '5' : 'Eisbrecherunterstützung kann nur für die Eisfahrt geeigneten Schiffen von bestimmter Größe (tdw) gegeben werden', '6' : 'Eisbrecherunterstützung kann nur für die Eisfahrt verstärkten Schiffen von bestimmter Größe (tdw) gegeben werden', '7' : 'Eisbrecherunterstützung kann nur nach Sondergenehmigung gegeben werden', '8' : 'Schifffahrt vorübergehend eingestellt', '9' : 'Schifffahrt hat aufgehört', '/' : 'Unbekannt',},
    },
    IceCodeSystem.WMO : {
      IceCodeSubSystem.CONCENTRATION : {' ' : 'Eisfrei', '0' : 'Weniger als 1/10', '1' : '1/10', '2' : '2/10', '3' : '3/10', '4' : '4/10', '5' : '5/10', '6' : '6/10', '7' : '7/10', '8' : '8/10', '9' : '9/10', '9+' : 'Mehr als 9/10 weniger als 10/10','10' : '10/10','x' : 'Unbestimmt oder unbekannt'},
      IceCodeSubSystem.DEVELOPMENT : {'0' : 'Keine Entwicklung', '1' : 'Neues Eis', '2' : 'Nilas; Eishaut', '3' : 'Junges Eis', '4' : 'Graues Eis', '5' : 'Grauweißes Eis', '6' : 'Einjähriges Eis', '7' : 'Dünnes einjähriges Eis', '8' : 'Dünnes einjähriges Eis, 1. Stadium', '9' : 'Dünnes einjähriges Eis, 1. Stadium', '1•' : 'Mittleres einjähriges Eis', '4•' : 'Dickes einjähriges Eis', '7•' : 'Altes Eis', '8•' : 'Zweijähriges Eis', '9•' : 'Mehrjähriges Eis', '▲•' : 'Festlandeis', 'x' : 'Unbestimmt oder unbekann'},
      IceCodeSubSystem.FORM : {'0' : 'Pfannkucheneis', '1' : 'Eisbruchstücke', '2' : 'Trümmereis', '3' : 'Kleine Eisschollen', '4' : 'Mittlere Eisschollen', '5' : 'Mittelgroße Eisschollen', '6' : 'Große Eisschollen', '7' : 'Riesige Eisschollen', '8' : 'Festeis, Brummer oder Eischollen', '9' : 'Eisnberge', 'x' : 'Unbestimmt oder unbekann'},
      IceCodeSubSystem.MELTING : {'0' : 'Keine Schmelze', '1' : 'Wenige Pfützen', '2' : 'Viele Pfützen', '3' : 'Überflutetes Eis ', '4' : 'Wenige Schmelzlöcher', '5' : 'Viele Schmelzlöcher', '6' : 'Trockeneis', '7' : 'Fauleis', '8' : 'Wenige gefrorene Pfützen', '9' : 'Alle Pfützen gefroren ', },
      IceCodeSubSystem.SNOW : {'0' : 'Kein Schnee', '1' : 'Bis zu 5 cm', '2' : 'Bis zu 10 cm', '3' : 'Bis zu 20 cm', '4' : 'Bis zu 30 cm', '5' : 'Bis zu 50 cm', '6' : 'Bis zu 75 cm', '7' : 'Bis zu 100 cm', '8' : 'Mehr als 100 cm', '9' : 'Unbekannt', },
      },
    IceCodeSystem.SIGRID : {
      IceCodeSubSystem.SIGRID : {
        '00' : 'Eisfrei', '01' : 'Weniger als 1/10 (offenes Wasser)', '02' : 'Eisberge', '10' : '1/10', '20' : '2/10', '30' : '3/10', '40' : '4/10', '50' : '5/10', '60' : '6/10', '70' : '7/10', '80' : '8/10', '90' : '9/10',  '91' : 'Mehr als 9/10 weniger als 10/10', '92' : '10/10', '99' : 'Unbekannt',},
      }
  },
  IceCodeLanguage.EN : {
    IceCodeSystem.EU : {
      IceCodeSubSystem.CONDITION : {'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '', 'F' : '', 'G' : '', 'H' : '', 'K' : '', 'L' : '', 'M' : '', 'P' : '', 'R' : '', 'S' : '', 'U' : '', 'O' : '', 'V' : '', },
      IceCodeSubSystem.ACCESSIBILITY : {'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '', 'F' : '', 'G' : '', 'H' : '', 'K' : '', 'L' : '', 'M' : '', 'P' : '', 'T' : '', 'X' : '', 'V' : '', },
      IceCodeSubSystem.CLASSIFICATION : {'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '',},
    },
    IceCodeSystem.BALTIC : {
      IceCodeSubSystem.A : {'0' : 'Ice-free', '1' : 'Open water - concentration less than 1/10', '2' : 'Very open ice - concentration 1/10 to 3/10', '3' : 'Open ice - concentration 4/10 to 6/10', '4' : 'Close ice - concentration 7/10 to 8/10', '5' : 'Very close ice - concentration 9/10 to 9+/10', '6' : 'Compact ice, including consolidated ice - concentration 10/10', '7' : 'Fast ice with ice outside', '8' : 'Fast ice', '9' : 'Lead in very close or compact drift ice or along the fast ice edge', '/' : 'Unable to report',},
      IceCodeSubSystem.S : {'0' : 'New ice or dark nilas (less than 5 cm thick)', '1' : 'Light nilas or ice rind ( 5-10 cm thick)', '2' : 'Grey ice (10-15 cm thick)', '3' : 'Grey-white ice (15-30 cm thick)', '4' : 'White ice, first stage (30-50 cm thick)', '5' : 'White ice, second stage (50-70 cm thick)', '6' : 'Medium first year ice (70-120 cm thick)', '7' : 'Ice predominantly thinner than 15 cm with some thicker ice', '8' : 'Ice predominantly grey–white (15-30 cm thick) with some ice thicker than 30 cm', '9' : 'Ice predominantly thicker than 30 cm with some thinner ice', '/' : 'No information or unable to report',},
      IceCodeSubSystem.T : {'0' : 'Pancake ice, ice cakes, brash ice -less than 20 m across', '1' : 'Small ice floes - 20 - 100 m across', '2' : 'Medium ice floes - 100 - 500 m across', '3' : 'Big ice floes - 500 - 2000 m across', '4' : 'Vast or giant ice floes or level ice - more than 2000 m across', '5' : 'Rafted ice', '6' : 'Compacted slush or shuga, or compacted brash ice', '7' : 'Hummocked or ridged ice', '8' : 'Thaw holes or many puddles on the ice', '9' : 'Rotten ice', '/' : 'No information or unable to report',},
      IceCodeSubSystem.K : {'0' : 'Navigation unobstructed', '1' : 'Navigation difficult or dangerous for wooden vessels without ice sheathing', '2' : 'Navigation difficult for unstrengthened or low-powered vessels built on iron or steel. Navigation for wooden vessels even with ice sheathing not advisable', '3' : 'Navigation without icebreaker assistance possible only for high-powered vessels of strong construction and suitable for navigation in ice', '4' : 'Navigation proceeds in lead or broken ice-channel without the assistance of an icebreaker', '5' : 'Icebreaker assistance can only be given to vessels suitable for navigation in ice and of special size', '6' : 'Icebreaker assistance can only be given to vessels of special ice class and of special size', '7' : 'Icebreaker assistance can only be given to vessels after special permission', '8' : 'Navigation temporarily closed', '9' : 'Navigation has ceased', '/' : 'Unknown',},
    },
    IceCodeSystem.WMO : {
      IceCodeSubSystem.CONCENTRATION : {' ' : 'Ice free', '0' : 'Less than 1/10', '1' : '1/10', '2' : '2/10', '3' : '3/10', '4' : '4/10', '5' : '5/10', '6' : '6/10', '7' : '7/10', '8' : '8/10', '9' : '9/10', '9+' : 'More than 9/10 less than 10/10','10' : '10/10','x' : 'Undetermined or unknown'},
      IceCodeSubSystem.DEVELOPMENT : {'0' : 'No stage of development', '1' : 'New ice', '2' : 'Nilas; ice rind', '3' : 'Young ice ', '4' : 'Gray ice', '5' : 'Gray-white ice', '6' : 'First-year ice', '7' : 'Thin first-year ice', '8' : 'Thin first-year ice, first stage', '9' : 'Thin first-year ice, second stage', '1•' : 'Medium first-year ice', '4•' : 'Thick first-year ice', '7•' : 'Old ice', '8•' : 'Second-year ice', '9•' : 'Multi-year ice', '▲•' : 'Ice of land origin', 'x' : 'Undetermined of unknown'},
      IceCodeSubSystem.FORM : {'0' : 'Pancake ice', '1' : 'Small ice cake; brash ice', '2' : 'Ice cake ', '3' : 'Small floe', '4' : 'Medium floe', '5' : 'Big floe ', '6' : 'Vast floe', '7' : 'Giant floe', '8' : 'Fast ice, growlers or floebergs', '9' : 'Icebergs', 'x' : 'Undetermined or unknown', },
      IceCodeSubSystem.MELTING : {'0' : 'No melt', '1' : 'Few puddles', '2' : 'Many puddles', '3' : 'Flooded ice ', '4' : 'Few thawholes', '5' : 'Many thawholes ', '6' : 'Dried ice', '7' : 'Rotten ice', '8' : 'Few frozen puddles', '9' : 'All puddles frozen', },
      IceCodeSubSystem.SNOW : {'0' : 'No snow', '1' : 'Up to 5 cm', '2' : 'Up to 10 cm', '3' : 'Up to 20 cm', '4' : 'Up to 30 cm', '5' : 'Up to 50 cm', '6' : 'Up to 75 cm', '7' : 'Up to 100 cm', '8' : 'More than 100 cm', '9' : 'Unknown', },
    },
    IceCodeSystem.SIGRID : {
      IceCodeSubSystem.SIGRID : {'00' : 'Ice free', '01' : 'Less than 1/10 (open water)', '02' : 'Bergy Water', '10' : '1/10', '20' : '2/10', '30' : '3/10', '40' : '4/10', '50' : '5/10', '60' : '6/10', '70' : '7/10', '80' : '8/10', '90' : '9/10',  '91' : 'More than 9/10 less than 10/10', '92' : '10/10', '99' : 'Unknown',},
    }
  },
};
