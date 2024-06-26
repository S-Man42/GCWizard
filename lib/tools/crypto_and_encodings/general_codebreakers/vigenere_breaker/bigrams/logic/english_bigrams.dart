import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/bigrams/logic/bigrams.dart';

class EnglishBigrams extends Bigrams {
  EnglishBigrams() {
    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    replacementList = {};
    bigrams = [
      //       A       B       C       D       E       F       G       H       I       J       K       L       M       N       O       P       Q       R       S       T       U       V       W       X       Y       Z
      [
        674016,
        799875,
        854970,
        840659,
        616349,
        766571,
        800171,
        693864,
        835825,
        621327,
        758506,
        913541,
        846164,
        960064,
        609791,
        797899,
        542827,
        921492,
        912651,
        931603,
        754601,
        795467,
        737590,
        600056,
        820922,
        611705
      ], //A
      [
        800680,
        603299,
        544119,
        481117,
        861440,
        432294,
        384355,
        487765,
        745767,
        534427,
        352977,
        781756,
        504482,
        458752,
        794373,
        465066,
        230248,
        750323,
        658592,
        566545,
        793812,
        468298,
        480260,
        183773,
        759918,
        260280
      ], //B
      [
        863253,
        538538,
        717624,
        552791,
        862759,
        530219,
        500253,
        864032,
        796918,
        386257,
        784640,
        766308,
        535333,
        502952,
        885952,
        557897,
        489279,
        763978,
        657038,
        823334,
        750038,
        449563,
        527164,
        227203,
        642546,
        411958
      ], //C
      [
        853574,
        771861,
        734852,
        739196,
        886793,
        739823,
        701049,
        749731,
        869732,
        614761,
        582388,
        718246,
        729840,
        712724,
        830950,
        720593,
        534620,
        766561,
        813219,
        845111,
        768692,
        648594,
        754959,
        354170,
        693612,
        452628
      ], //D
      [
        923253,
        807922,
        883123,
        928955,
        857489,
        831722,
        795444,
        788347,
        846410,
        649735,
        700078,
        874629,
        856002,
        932741,
        833292,
        836098,
        661378,
        967811,
        944535,
        901913,
        732606,
        814279,
        840134,
        765847,
        788031,
        572979
      ], //E
      [
        796108,
        622899,
        666953,
        609633,
        797676,
        771593,
        597311,
        663781,
        824014,
        530862,
        518143,
        714081,
        649385,
        583644,
        859247,
        646140,
        396649,
        795936,
        687428,
        834268,
        720442,
        523294,
        632518,
        327109,
        613847,
        364133
      ], //F
      [
        818997,
        645137,
        652307,
        622168,
        838274,
        661582,
        661739,
        809037,
        783539,
        498252,
        492301,
        705195,
        644754,
        700550,
        794527,
        647122,
        414369,
        782298,
        737624,
        786158,
        734564,
        502429,
        666815,
        306431,
        630487,
        357212
      ], //G
      [
        908875,
        633138,
        660293,
        617551,
        988401,
        618065,
        566785,
        654097,
        888113,
        503712,
        511625,
        644158,
        655422,
        657169,
        862467,
        630396,
        455112,
        736078,
        701675,
        796049,
        710833,
        506757,
        658237,
        254296,
        660582,
        377479
      ], //H
      [
        809982,
        705842,
        868995,
        829622,
        827242,
        767082,
        806252,
        593959,
        593507,
        514771,
        705445,
        854853,
        814063,
        977707,
        868060,
        725439,
        536856,
        821974,
        911779,
        912987,
        589533,
        802928,
        625794,
        622130,
        452883,
        680251
      ], //I
      [
        673639,
        327377,
        346337,
        336833,
        662736,
        294357,
        290490,
        333432,
        552606,
        312979,
        302070,
        291296,
        338352,
        304708,
        709413,
        371981,
        73185,
        437372,
        382051,
        331370,
        714984,
        267469,
        312969,
        75815,
        233136,
        179514
      ], //J
      [
        712520,
        571706,
        565041,
        533152,
        814837,
        584074,
        511213,
        598791,
        768071,
        433781,
        467477,
        619170,
        576254,
        681810,
        675653,
        556416,
        301726,
        579586,
        722588,
        660450,
        579525,
        430039,
        606643,
        223973,
        586334,
        284957
      ], //K
      [
        874916,
        701728,
        697353,
        811841,
        895829,
        708876,
        626162,
        650776,
        875291,
        514500,
        643809,
        879631,
        693559,
        610074,
        844306,
        704205,
        434114,
        663652,
        798989,
        780365,
        746587,
        648576,
        679041,
        309952,
        834527,
        411153
      ], //L
      [
        870280,
        741489,
        639548,
        575536,
        887385,
        606153,
        535114,
        605695,
        825134,
        476923,
        462251,
        575117,
        733783,
        587043,
        829945,
        791118,
        334886,
        600032,
        737667,
        718372,
        734305,
        478095,
        627087,
        303620,
        683627,
        322824
      ], //M
      [
        876137,
        731089,
        842392,
        928199,
        887651,
        755641,
        914257,
        737520,
        852992,
        654833,
        718049,
        733002,
        735146,
        759158,
        859126,
        716119,
        514167,
        699497,
        868410,
        935392,
        733826,
        692789,
        743235,
        431771,
        745533,
        529881
      ], //N
      [
        777325,
        773188,
        789239,
        788867,
        706371,
        896229,
        742260,
        723240,
        761446,
        600086,
        726560,
        834439,
        867534,
        944325,
        811260,
        813437,
        469951,
        927411,
        833703,
        863860,
        897661,
        786179,
        839261,
        598789,
        682980,
        518026
      ], //O
      [
        824495,
        555106,
        561328,
        531800,
        844192,
        564700,
        511899,
        712310,
        764604,
        395895,
        439779,
        808502,
        626558,
        475402,
        823521,
        754431,
        324232,
        831366,
        698961,
        735462,
        736382,
        397620,
        583071,
        246617,
        560520,
        273879
      ], //P
      [
        430400,
        353871,
        281245,
        265300,
        237045,
        266186,
        171190,
        292080,
        430253,
        121080,
        152790,
        273126,
        292344,
        201660,
        271426,
        237582,
        169116,
        236465,
        333015,
        316862,
        742377,
        209451,
        372313,
        77655,
        215534,
        0
      ], //Q
      [
        891279,
        725383,
        782122,
        802046,
        949583,
        727434,
        750738,
        716135,
        888503,
        581265,
        748124,
        753311,
        786472,
        783119,
        892841,
        730777,
        488978,
        769151,
        868159,
        868951,
        761359,
        708588,
        725424,
        380720,
        799989,
        463897
      ], //R
      [
        895054,
        764527,
        815918,
        736063,
        898697,
        771446,
        687290,
        849926,
        883072,
        604994,
        697148,
        755870,
        764902,
        742165,
        877297,
        814254,
        614856,
        729159,
        859214,
        940289,
        810206,
        622369,
        798969,
        402097,
        693481,
        436764
      ], //S
      [
        884229,
        735522,
        759395,
        697963,
        921387,
        725895,
        664923,
        1000000,
        922463,
        587192,
        593915,
        762403,
        734388,
        676706,
        928067,
        718738,
        490043,
        845412,
        859242,
        861038,
        797205,
        604301,
        801052,
        356236,
        792812,
        533712
      ], //T
      [
        749802,
        716709,
        767108,
        728845,
        755289,
        604714,
        753777,
        548562,
        728445,
        444430,
        580773,
        811296,
        746355,
        842509,
        598769,
        761016,
        341894,
        852502,
        844815,
        841997,
        418514,
        512234,
        551552,
        482768,
        583296,
        487387
      ], //U
      [
        741294,
        359028,
        413425,
        442156,
        893079,
        356055,
        348838,
        361658,
        805022,
        286596,
        286846,
        399095,
        373100,
        368693,
        694831,
        417941,
        129059,
        451339,
        509279,
        418353,
        439605,
        338321,
        393502,
        188027,
        519541,
        173152
      ], //V
      [
        850228,
        560261,
        570092,
        567330,
        831330,
        547846,
        480095,
        823100,
        842384,
        453722,
        484951,
        599699,
        579383,
        732089,
        802736,
        544448,
        313744,
        647853,
        685181,
        652411,
        499952,
        419594,
        601651,
        217558,
        586383,
        404868
      ], //W
      [
        624278,
        449412,
        604284,
        414822,
        599247,
        463623,
        381979,
        493596,
        633951,
        280969,
        300302,
        414155,
        472925,
        372458,
        511914,
        679204,
        228876,
        446058,
        487694,
        663902,
        484205,
        363962,
        467808,
        373162,
        449649,
        155011
      ], //X
      [
        785009,
        708712,
        720174,
        690205,
        776675,
        696592,
        635765,
        696122,
        747603,
        557036,
        559698,
        686154,
        703359,
        662648,
        802582,
        705348,
        444241,
        686460,
        788147,
        779188,
        604009,
        563456,
        726138,
        317003,
        547098,
        435241
      ], //Y
      [
        626383,
        401606,
        385342,
        368281,
        673508,
        357601,
        351170,
        459847,
        598067,
        250520,
        344736,
        436956,
        394220,
        344669,
        565773,
        362133,
        233808,
        367760,
        450191,
        410668,
        463969,
        304101,
        425339,
        167995,
        458567,
        515524
      ], //Z
    ];
  }
}
