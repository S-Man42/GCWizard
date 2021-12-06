// https://de.wikipedia.org/wiki/Lucas-Folge
// could build not recursive
// https://oeis.org/A000225   Mersenne
// https://oeis.org/A000051   Mersenne-like with Fermat-numbers
// https://oeis.org/A000251   Fermat
// https://oeis.org/A000108   Catalan
// https://oeis.org/A001045   Jacobsthal
// https://oeis.org/A014551   Jacobsthal-Lucas
// https://oeis.org/A084175   Jacobsthal-Oblong
// should be build recursive
// https://oeis.org/A000032   Lucas
// https://oeis.org/A000045   Fibonacci
// https://oeis.org/A000129   Pell
// https://oeis.org/A002203   Pell-Lucas
//
// recursive sequences
// https://oeis.org/A005132   Recamán
// https://oeis.org/A000142   Factorial
// https://oeis.org/A000110   Bell                B(n) = summe von (n-1 über k)*B8k) für k = 0 bis n-1
//
// https://oeis.org/A081357   Sublime numbers
// https://oeis.org/A000396   Perfect numbers
// https://oeis.org/A019279   Superperfect numbers
// https://oeis.org/A054377   Pseudoperfect numbers
// https://oeis.org/A006037   Weird numbers
// https://oeis.org/A000668   Mersenne primes
// https://oeis.org/A000043   Mersenne exponents
// https://oeis.org/A023108   Lychrel numbers
//
// suggestions - https://en.wikipedia.org/wiki/List_of_integer_sequences
// https://oeis.org/A008336   RecamánII           a(n+1) = a(n)/n if n|a(n) else a(n)*n, a(1) = 1.
// https://oeis.org/A000058   Sylvester           a(n) = 1 + a(0)*a(1)*...*a(n-1)

import 'dart:math';

class PositionOfSequenceOutput {
  final String number;
  final int positionSequence;
  final int positionDigits;
  PositionOfSequenceOutput(this.number, this.positionSequence, this.positionDigits);
}

enum NumberSequencesMode {
  LUCAS,
  FIBONACCI,
  MERSENNE,
  MERSENNE_FERMAT,
  FERMAT,
  JACOBSTAHL,
  JACOBSTHAL_LUCAS,
  JACOBSTHAL_OBLONG,
  PELL,
  PELL_LUCAS,
  CATALAN,
  RECAMAN,
  BELL,
  FACTORIAL,
  MERSENNE_PRIMES,
  MERSENNE_EXPONENTS,
  PERFECT_NUMBERS,
  SUPERPERFECT_NUMBERS,
  PRIMARY_PSEUDOPERFECT_NUMBERS,
  WEIRD_NUMBERS,
  SUBLIME_NUMBERS,
  LYCHREL
}

List<String> lychrel_numbers = [
  '196',
  '295',
  '394',
  '493',
  '592',
  '689',
  '691',
  '788',
  '790',
  '879',
  '887',
  '978',
  '986',
  '1495',
  '1497',
  '1585',
  '1587',
  '1675',
  '1677',
  '1765',
  '1767',
  '1855',
  '1857',
  '1945',
  '1947',
  '1997',
  '2494',
  '2496',
  '2584',
  '2586',
  '2674',
  '2676',
  '2764',
  '2766',
  '2854',
  '2856',
  '2944',
  '2946',
  '2996',
  '3493',
  '3495',
  '3583',
  '3585',
  '3673',
  '3675',
  '3763',
  '3765',
  '3853',
  '3855',
  '3943',
  '3945',
  '3995',
  '4079',
  '4169',
  '4259',
  '4349',
  '4439',
  '4492',
  '4494',
  '4529',
  '4582',
  '4584',
  '4619',
  '4672',
  '4674',
  '4709',
  '4762',
  '4764',
  '4799',
  '4852',
  '4854',
  '4889',
  '4942',
  '4944',
  '4979',
  '5078',
  '5168',
  '5258',
  '5348',
  '5438',
  '5491',
  '5493',
  '5528',
  '5581',
  '5583',
  '5618',
  '5671',
  '5673',
  '5708',
  '5761',
  '5763',
  '5798',
  '5851',
  '5853',
  '5888',
  '5941',
  '5943',
  '5978',
  '5993',
  '6077',
  '6167',
  '6257',
  '6347',
  '6437',
  '6490',
  '6492',
  '6527',
  '6580',
  '6582',
  '6617',
  '6670',
  '6672',
  '6707',
  '6760',
  '6762',
  '6797',
  '6850',
  '6852',
  '6887',
  '6940',
  '6942',
  '6977',
  '6992',
  '7059',
  '7076',
  '7149',
  '7166',
  '7239',
  '7256',
  '7329',
  '7346',
  '7419',
  '7436',
  '7491',
  '7509',
  '7526',
  '7581',
  '7599',
  '7616',
  '7671',
  '7689',
  '7706',
  '7761',
  '7779',
  '7796',
  '7851',
  '7869',
  '7886',
  '7941',
  '7959',
  '7976',
  '7991',
  '8058',
  '8075',
  '8079',
  '8089',
  '8148',
  '8165',
  '8169',
  '8179',
  '8238',
  '8255',
  '8259',
  '8269',
  '8328',
  '8345',
  '8349',
  '8359',
  '8418',
  '8435',
  '8439',
  '8449',
  '8490',
  '8508',
  '8525',
  '8529',
  '8539',
  '8580',
  '8598',
  '8615',
  '8619',
  '8629',
  '8670',
  '8688',
  '8705',
  '8709',
  '8719',
  '8760',
  '8795',
  '8799',
  '8809',
  '8850',
  '8868',
  '8885',
  '8889',
  '8899',
  '8940',
  '8958',
  '8975',
  '8979',
  '8989',
  '8990',
  '9057',
  '9074',
  '9078',
  '9088',
  '9147',
  '9164',
  '9168',
  '9178',
  '9237',
  '9254',
  '9258',
  '9268',
  '9327',
  '9344',
  '9348',
  '9358',
  '9417',
  '9434',
  '9438',
  '9448',
  '9507',
  '9524',
  '9528',
  '9538',
  '9597',
  '9614',
  '9618',
  '9628',
  '9687',
  '9704',
  '9708',
  '9718',
  '9777',
  '9794',
  '9798',
  '9808',
  '9867',
  '9884',
  '9888',
  '9898',
  '9957',
  '9974',
  '9978',
  '9988'
];
List<String> mersenne_primes = [
  '3',
  '7',
  '31',
  '127',
  '8191',
  '131071',
  '524287',
  '2147483647',
  '2305843009213693951',
  '618970019642690137449562111',
  '162259276829213363391578010288127',
  '170141183460469231731687303715884105727',
  '6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057151',
  '531137992816767098689588206552468627329593117727031923199444138200403559860852242739162502265229285668889329486246501015346579337652707239409519978766587351943831270835393219031728127',
  '10407932194664399081925240327364085538615262247266704805319112350403608059673360298012239441732324184842421613954281007791383566248323464908139906605677320762924129509389220345773183349661583550472959420547689811211693677147548478866962501384438260291732348885311160828538416585028255604666224831890918801847068222203140521026698435488732958028878050869736186900714720710555703168729087',
  '1475979915214180235084898622737381736312066145333169775147771216478570297878078949377407337049389289382748507531496480477281264838760259191814463365330269540496961201113430156902396093989090226259326935025281409614983499388222831448598601834318536230923772641390209490231836446899608210795482963763094236630945410832793769905399982457186322944729636418890623372171723742105636440368218459649632948538696905872650486914434637457507280441823676813517852099348660847172579408422316678097670224011990280170474894487426924742108823536808485072502240519452587542875349976558572670229633962575212637477897785501552646522609988869914013540483809865681250419497686697771007',
  '446087557183758429571151706402101809886208632412859901111991219963404685792820473369112545269003989026153245931124316702395758705693679364790903497461147071065254193353938124978226307947312410798874869040070279328428810311754844108094878252494866760969586998128982645877596028979171536962503068429617331702184750324583009171832104916050157628886606372145501702225925125224076829605427173573964812995250569412480720738476855293681666712844831190877620606786663862190240118570736831901886479225810414714078935386562497968178729127629594924411960961386713946279899275006954917139758796061223803393537381034666494402951052059047968693255388647930440925104186817009640171764133172418132836351',
  '259117086013202627776246767922441530941818887553125427303974923161874019266586362086201209516800483406550695241733194177441689509238807017410377709597512042313066624082916353517952311186154862265604547691127595848775610568757931191017711408826252153849035830401185072116424747461823031471398340229288074545677907941037288235820705892351068433882986888616658650280927692080339605869308790500409503709875902119018371991620994002568935113136548829739112656797303241986517250116412703509705427773477972349821676443446668383119322540099648994051790241624056519054483690809616061625743042361721863339415852426431208737266591962061753535748892894599629195183082621860853400937932839420261866586142503251450773096274235376822938649407127700846077124211823080804139298087057504713825264571448379371125032081826126566649084251699453951887789613650248405739378594599444335231188280123660406262468609212150349937584782292237144339628858485938215738821232393687046160677362909315071',
  '190797007524439073807468042969529173669356994749940177394741882673528979787005053706368049835514900244303495954950709725762186311224148828811920216904542206960744666169364221195289538436845390250168663932838805192055137154390912666527533007309292687539092257043362517857366624699975402375462954490293259233303137330643531556539739921926201438606439020075174723029056838272505051571967594608350063404495977660656269020823960825567012344189908927956646011998057988548630107637380993519826582389781888135705408653045219655801758081251164080554609057468028203308718724654081055323215860189611391296030471108443146745671967766308925858547271507311563765171008318248647110097614890313562856541784154881743146033909602737947385055355960331855614540900081456378659068370317267696980001187750995491090350108417050917991562167972281070161305972518044872048331306383715094854938415738549894606070722584737978176686422134354526989443028353644037187375385397838259511833166416134323695660367676897722287918773420968982326089026150031515424165462111337527431154890666327374921446276833564519776797633875503548665093914556482031482248883127023777039667707976559857333357013727342079099064400455741830654320379350833236245819348824064783585692924881021978332974949906122664421376034687815350484991'
];
List<String> mersenne_exponents = [
  '2',
  '3',
  '5',
  '7',
  '13',
  '17',
  '19',
  '31',
  '61',
  '89',
  '107',
  '127',
  '521',
  '607',
  '1279',
  '2203',
  '2281',
  '3217',
  '4253',
  '4423',
  '9689',
  '9941',
  '11213',
  '19937',
  '21701',
  '23209',
  '44497',
  '86243',
  '110503',
  '132049',
  '216091',
  '756839',
  '859433',
  '1257787',
  '1398269',
  '2976221',
  '3021377',
  '6972593',
  '13466917',
  '20996011',
  '24036583',
  '25964951',
  '30402457',
  '32582657',
  '37156667',
  '42643801',
  '43112609',
  '57885161',
  '74207281',
  '77232917',
  '82589933'
];
List<String> perfect_numbers = [
  '6',
  '28',
  '496',
  '8128',
  '33550336',
  '8589869056',
  '137438691328',
  '2305843008139952128',
  '2658455991569831744654692615953842176',
  '191561942608236107294793378084303638130997321548169216 ',
  '13164036458569648337239753460458722910223472318386943117783728128',
  '14474011154664524427946373126085988481573677491474835889066354349131199152128'
];
List<String> superperfect_numbers = [
  '2',
  '4',
  '16',
  '64',
  '4096',
  '65536',
  '262144',
  '1073741824',
  '1152921504606846976'
];
List<String> primary_pseudo_perfect_numbers = [
  '2',
  '6',
  '42',
  '1806',
  '47058',
  '2214502422',
  '52495396602',
  '8490421583559688410706771261086 '
];
List<String> weird_numbers = [
  '70',
  '836',
  '4030',
  '5830',
  '7192',
  '7912',
  '9272',
  '10430',
  '10570',
  '10792',
  '10990',
  '11410',
  '11690',
  '12110',
  '12530',
  '12670',
  '13370',
  '13510',
  '13790',
  '13930',
  '14770',
  '15610',
  '15890',
  '16030',
  '16310',
  '16730',
  '16870',
  '17272',
  '17570',
  '17990',
  '18410',
  '18830',
  '18970',
  '19390',
  '19670'
];
List<String> sublime_number = ['12', '6086555670238378989670371734243169622657830773351885970528324860512791691264'];

final Zero = BigInt.zero;
final One = BigInt.one;
final Two = BigInt.two;
final Three = BigInt.from(3);
final sqrt5 = sqrt(5);
final sqrt2 = sqrt(2);

BigInt _getMersenneFermat(int n) {
  return Two.pow(n) + One;
}

BigInt _getFermat(int n) {
  return Two.pow(pow(2, n)) + One;
}

BigInt _getMersenne(int n) {
  return Two.pow(n) - One;
}

BigInt _getCatalan(int n) {
  if (n == 0) return BigInt.one;

  try {
    return _getBinomialCoefficient(2 * n, n) ~/ (BigInt.from(n) + One);
  } catch (e) {
    return BigInt.from(-1);
  }
}

BigInt _getJacobsthal(int n) {
  return (Two.pow(n) - BigInt.from(-1).pow(n)) ~/ Three;
}

BigInt _getJacobsthalLucas(int n) {
  return Two.pow(n) + BigInt.from(-1).pow(n);
}

BigInt _getJacobsthalOblong(int n) {
  return _getJacobsthal(n) * _getJacobsthal(n + 1);
}

BigInt _getfactorial(int n) {
  if (n > 0)
    return n <= 1 ? One : BigInt.from(n) * _getfactorial(n - 1);
  else
    return One;
}

BigInt _getBinomialCoefficient(int n, k) {
  if (n == k)
    return Zero;
  else
    return _getfactorial(n) ~/ _getfactorial(k) ~/ _getfactorial(n - k);
}

Function _getNumberSequenceFunction(NumberSequencesMode mode) {
  switch (mode) {
    case NumberSequencesMode.FERMAT:
      return _getFermat;
    case NumberSequencesMode.MERSENNE:
      return _getMersenne;
    case NumberSequencesMode.MERSENNE_FERMAT:
      return _getMersenneFermat;
    case NumberSequencesMode.CATALAN:
      return _getCatalan;
    case NumberSequencesMode.JACOBSTAHL:
      return _getJacobsthal;
    case NumberSequencesMode.JACOBSTHAL_LUCAS:
      return _getJacobsthalLucas;
    case NumberSequencesMode.JACOBSTHAL_OBLONG:
      return _getJacobsthalOblong;
    default:
      return null;
  }
}

BigInt getNumberAt(NumberSequencesMode sequence, int n) {
  if (n == null)
    return Zero;
  else
    return getNumbersInRange(sequence, n, n)[0];
}

List getNumbersInRange(NumberSequencesMode sequence, int start, stop) {
  if (start == null || stop == null || start == '' || stop == '') return [-1];

  List numberList = new List();
  List<String> sequenceList = new List<String>();

  var numberSequenceFunction = _getNumberSequenceFunction(sequence);
  if (numberSequenceFunction != null) {
    for (int i = start; i <= stop; i++) {
      numberList.add(numberSequenceFunction(i));
    }
  } else if (sequence == NumberSequencesMode.FIBONACCI) {
    BigInt number;
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    int index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = Zero;
      else if (index == 1)
        number = One;
      else {
        number = pn0 + pn1;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start) numberList.add(number);
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.PELL) {
    BigInt number;
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    int index = 0;
    while (index <= stop) {
      if (index == 0)
        number = pn0;
      else if (index == 1)
        number = pn1;
      else {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start) numberList.add(number);
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.PELL_LUCAS) {
    BigInt number;
    BigInt pn0 = Two;
    BigInt pn1 = Two;
    int index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = pn0;
      else if (index == 1)
        number = pn1;
      else {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start) numberList.add(number);
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.LUCAS) {
    BigInt number;
    BigInt pn0 = Two;
    BigInt pn1 = One;
    int index = 0;
    while (index <= stop) {
      if (index == 0)
        number = pn0;
      else if (index == 1)
        number = pn1;
      else {
        number = pn0 + pn1;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start) numberList.add(number);
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.RECAMAN) {
    List<BigInt> recamanSequence = new List<BigInt>();
    BigInt number;
    BigInt pn0 = Zero;
    BigInt index = Zero;
    recamanSequence.add(Zero);
    index = Zero;
    while (index < BigInt.from(stop) + One) {
      if (index == Zero)
        number = pn0;
      else if ((pn0 - index) > Zero && !recamanSequence.contains(pn0 - index))
        number = pn0 - index;
      else
        number = pn0 + index;
      recamanSequence.add(number);
      pn0 = number;
      if (index >= BigInt.from(start)) numberList.add(number);
      index = index + One;
    }
  } else if (sequence == NumberSequencesMode.FACTORIAL) {
    BigInt number;
    int index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = One;
      else if (index == 1)
        number = One;
      else {
        number = number * BigInt.from(index);
      }
      if (index >= start) numberList.add(number);
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.BELL) {
    List<BigInt> bellList = new List<BigInt>();
    BigInt number;
    int index = 0;
    while (index <= stop) {
      if (index == 0)
        number = One;
      else
        for (int k = 0; k <= index - 1; k++) {
          number = number + _getBinomialCoefficient(index - 1, k) * bellList[k];
        }
      bellList.add(number);
      if (index >= start) numberList.add(number);
      index = index + 1;
    }
  } else {
    switch (sequence) {
      case NumberSequencesMode.MERSENNE_PRIMES:
        sequenceList.addAll(mersenne_primes);
        break;
      case NumberSequencesMode.MERSENNE_EXPONENTS:
        sequenceList.addAll(mersenne_exponents);
        break;
      case NumberSequencesMode.PERFECT_NUMBERS:
        sequenceList.addAll(perfect_numbers);
        break;
      case NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS:
        sequenceList.addAll(primary_pseudo_perfect_numbers);
        break;
      case NumberSequencesMode.SUPERPERFECT_NUMBERS:
        sequenceList.addAll(superperfect_numbers);
        break;
      case NumberSequencesMode.SUBLIME_NUMBERS:
        sequenceList.addAll(sublime_number);
        break;
      case NumberSequencesMode.WEIRD_NUMBERS:
        sequenceList.addAll(weird_numbers);
        break;
      case NumberSequencesMode.LYCHREL:
        sequenceList.addAll(lychrel_numbers);
        break;
    }
    for (int i = start; i <= stop; i++) numberList.add(BigInt.parse(sequenceList[i]));
  }

  return numberList;
}

int checkNumber(NumberSequencesMode sequence, BigInt checkNumber, int maxIndex) {
  if (checkNumber == null || checkNumber == '')
    return -1;
  else if (getFirstPositionOfSequence(sequence, checkNumber.toString(), maxIndex).positionSequence == -1)
    return -1;
  else if (getFirstPositionOfSequence(sequence, checkNumber.toString(), maxIndex).positionDigits == 1)
    return getFirstPositionOfSequence(sequence, checkNumber.toString(), maxIndex).positionSequence;
  else
    return -1;
}

PositionOfSequenceOutput getFirstPositionOfSequence(NumberSequencesMode sequence, String check, int maxIndex) {
  if (check == null || check == '') {
    return PositionOfSequenceOutput('-1', 0, 0);
  }

  BigInt number = Zero;

  BigInt pn0 = Zero;
  BigInt pn1 = One;
  int index = 0;
  String numberString = '';
  List<String> sequenceList = new List<String>();

  RegExp expr = new RegExp(r'(' + check + ')');

  var numberSequenceFunction = _getNumberSequenceFunction(sequence);
  if (numberSequenceFunction != null) {
    while (index <= maxIndex) {
      number = numberSequenceFunction(index);
      numberString = number.toString();
      if (numberString.contains(check)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check)) j++;
        return PositionOfSequenceOutput(numberString, index, (j + 1));
      }
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.FIBONACCI) {
    pn0 = Zero;
    pn1 = One;
    number = pn1;
    if (check == Zero.toString()) {
      return PositionOfSequenceOutput('0', 0, 1);
    } else if (check == One.toString()) {
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 2;
      while (index <= maxIndex) {
        number = pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check)) j++;
          return PositionOfSequenceOutput(numberString, index, j + 1);
        }
        index = index + 1;
      }
    }
  } else if (sequence == NumberSequencesMode.PELL) {
    pn0 = Zero;
    pn1 = One;
    number = pn1;
    if (check == Zero.toString()) {
      return PositionOfSequenceOutput('0', 0, 1);
    } else if (check == One.toString()) {
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 2;
      while (index <= maxIndex) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check)) j++;
          return PositionOfSequenceOutput(numberString, index, j + 1);
        }
        index = index + 1;
      }
    }
  } else if (sequence == NumberSequencesMode.PELL_LUCAS) {
    if (check == Two.toString()) {
      return PositionOfSequenceOutput('2', 0, 1);
    }
    pn0 = Two;
    pn1 = Two;
    number = pn1;
    index = 2;
    while (index <= maxIndex) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check)) j++;
        return PositionOfSequenceOutput(numberString, index, j + 1);
      }
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.LUCAS) {
    pn0 = Two;
    pn1 = One;
    if (check == Two.toString()) {
      return PositionOfSequenceOutput('2', 0, 1);
    } else if ((check == One.toString())) {
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 1;
      number = Three;
      while (index <= maxIndex) {
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check)) j++;
          return PositionOfSequenceOutput(numberString, index, j + 1);
        }
        index = index + 1;
        number = pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
    }
  } else if (sequence == NumberSequencesMode.RECAMAN) {
    List<int> recamanSequence = new List<int>();
    int index = 0;
    int maxIndex = 111111;
    int pn0 = 0;
    int number = 0;
    recamanSequence.add(0);
    while (index <= maxIndex) {
      if (index == Zero)
        number = 0;
      else if ((pn0 - index) > 0 && !recamanSequence.contains(pn0 - index))
        number = pn0 - index;
      else
        number = pn0 + index;
      recamanSequence.add(number);
      pn0 = number;
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check)) j++;
        return PositionOfSequenceOutput(numberString, index, j + 1);
      }
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.FACTORIAL) {
    number = One;
    if (check == Zero.toString()) {
      return PositionOfSequenceOutput('0', 0, 1);
    } else if (check == One.toString()) {
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 2;
      while (index <= maxIndex) {
        number = number * BigInt.from(index);
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check)) j++;
          return PositionOfSequenceOutput(numberString, index, j + 1);
        }
        index = index + 1;
      }
    }
  } else if (sequence == NumberSequencesMode.BELL) {
    List<BigInt> bellList = new List<BigInt>();
    while (index <= maxIndex) {
      if (index == 0)
        number = One;
      else
        for (int k = 0; k <= index - 1; k++) {
          number = number + _getBinomialCoefficient(index - 1, k) * bellList[k];
        }
      bellList.add(number);
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check)) j++;
        return PositionOfSequenceOutput(numberString, index, j + 1);
      }
      index = index + 1;
    }
  } else {
    switch (sequence) {
      case NumberSequencesMode.MERSENNE_PRIMES:
        sequenceList.addAll(mersenne_primes);
        break;
      case NumberSequencesMode.MERSENNE_EXPONENTS:
        sequenceList.addAll(mersenne_exponents);
        break;
      case NumberSequencesMode.PERFECT_NUMBERS:
        sequenceList.addAll(perfect_numbers);
        break;
      case NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS:
        sequenceList.addAll(primary_pseudo_perfect_numbers);
        break;
      case NumberSequencesMode.SUPERPERFECT_NUMBERS:
        sequenceList.addAll(superperfect_numbers);
        break;
      case NumberSequencesMode.SUBLIME_NUMBERS:
        sequenceList.addAll(sublime_number);
        break;
      case NumberSequencesMode.WEIRD_NUMBERS:
        sequenceList.addAll(weird_numbers);
        break;
      case NumberSequencesMode.LYCHREL:
        sequenceList.addAll(lychrel_numbers);
        break;
    }
    for (int i = 0; i < sequenceList.length; i++) {
      if (expr.hasMatch(sequenceList[i])) {
        int j = 0;
        while (!sequenceList[i].substring(j).startsWith(check)) j++;
        return PositionOfSequenceOutput(sequenceList[i], i, j + 1);
      }
    }
  }

  return PositionOfSequenceOutput('-1', 0, 0);
}

List getNumbersWithNDigits(NumberSequencesMode sequence, int digits) {
  if (digits == null) return [];

  BigInt number;

  List numberList = new List();
  List<String> sequenceList = new List<String>();

  var numberSequenceFunction = _getNumberSequenceFunction(sequence);
  if (numberSequenceFunction != null) {
    int index = 0;
    number = Two;
    while (number.toString().length < digits + 1) {
      number = numberSequenceFunction(index);
      if (number.toString().length == digits) numberList.add(number);
      index = index + 1;
    }
  } else if (sequence == NumberSequencesMode.FIBONACCI) {
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits) numberList.add(number);
    }
  } else if (sequence == NumberSequencesMode.PELL) {
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits) numberList.add(number);
    }
  } else if (sequence == NumberSequencesMode.PELL_LUCAS) {
    BigInt pn0 = Two;
    BigInt pn1 = Two;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits) numberList.add(number);
    }
  } else if (sequence == NumberSequencesMode.LUCAS) {
    BigInt pn0 = Two;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits) numberList.add(number);
    }
  } else if (sequence == NumberSequencesMode.RECAMAN) {
    BigInt pn0 = Zero;
    List<BigInt> recamanSequence = new List<BigInt>();
    for (int index = 0; index < 11111; index++) {
      if (index == 0)
        number = Zero;
      else if ((pn0 - BigInt.from(index)) > Zero && !recamanSequence.contains(pn0 - BigInt.from(index)))
        number = pn0 - BigInt.from(index);
      else
        number = pn0 + BigInt.from(index);
      recamanSequence.add(number);
      pn0 = number;
      if (number.toString().length == digits) numberList.add(number);
    }
  } else if (sequence == NumberSequencesMode.FACTORIAL) {
    BigInt index = BigInt.from(4);
    if (digits == 1) {
      numberList.add(One);
      numberList.add(Two);
      numberList.add(BigInt.from(6));
    }
    number = BigInt.from(6);
    while (number.toString().length < digits + 1) {
      number = number * index;
      if (number.toString().length == digits) numberList.add(number);
      index = index + One;
    }
  } else if (sequence == NumberSequencesMode.BELL) {
    List<BigInt> bellList = new List<BigInt>();
    BigInt number = One;
    int index = 0;
    while (number.toString().length < digits + 1) {
      if (index == 0)
        number = One;
      else
        for (int k = 0; k <= index - 1; k++) {
          number = number + _getBinomialCoefficient(index - 1, k) * bellList[k];
        }
      bellList.add(number);
      if (number.toString().length == digits) numberList.add(number);
      index = index + 1;
    }
  } else {
    switch (sequence) {
      case NumberSequencesMode.MERSENNE_PRIMES:
        sequenceList.addAll(mersenne_primes);
        break;
      case NumberSequencesMode.MERSENNE_EXPONENTS:
        sequenceList.addAll(mersenne_exponents);
        break;
      case NumberSequencesMode.PERFECT_NUMBERS:
        sequenceList.addAll(perfect_numbers);
        break;
      case NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS:
        sequenceList.addAll(primary_pseudo_perfect_numbers);
        break;
      case NumberSequencesMode.SUPERPERFECT_NUMBERS:
        sequenceList.addAll(superperfect_numbers);
        break;
      case NumberSequencesMode.SUBLIME_NUMBERS:
        sequenceList.addAll(sublime_number);
        break;
      case NumberSequencesMode.WEIRD_NUMBERS:
        sequenceList.addAll(weird_numbers);
        break;
      case NumberSequencesMode.LYCHREL:
        sequenceList.addAll(lychrel_numbers);
        break;
    }
    for (int i = 0; i < sequenceList.length; i++) if (sequenceList[i].length == digits) numberList.add(sequenceList[i]);
  }

  return numberList;
}
