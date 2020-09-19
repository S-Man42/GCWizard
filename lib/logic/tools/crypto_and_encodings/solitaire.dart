import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:tuple/tuple.dart';

const int _jockerA = 53;
const int _jockerB = 54;

class SolitaireOutput {
  final String output;
  final String keyStream;
  final String resultDeck;

  SolitaireOutput(this.output, this.keyStream, this.resultDeck);
}

Map<String, int> createSolitaireAlphabetMap() {
  return alphabet_AZ;
}

SolitaireOutput encryptSolitaire (String input, String key) {
  return solitaireBase(input, key, true);
}

SolitaireOutput decryptSolitaire (String input, String key) {
  return solitaireBase(input, key, false);
}

SolitaireOutput solitaireBase (String input, String key,bool encrpyt) {
  if (input == null || input.length == 0)
    return null;

  var alphabet = createSolitaireAlphabetMap();
  if (alphabet == null)
    return null;

  input = input
      .toUpperCase()
      .split('')
      .map((character) => alphabet.containsKey(character) ? character : '')
      .join();

  if (key != null) {
    key = key
        .toUpperCase()
        .split('')
        .map((character) => alphabet.containsKey(character) ? character : '')
        .join();
  }

  if (encrpyt) {
    int streamLength = (input.length / 5.0).ceil() * 5;
    input = input.padRight(streamLength, 'X');
  }

  var deck = createDeck();
  var tuple = createKeyStream(input, key, deck, alphabet);
  var keyStream = tuple.item1;
  deck = tuple.item2;
  String output;
  if (encrpyt) {
    output = createEncryptOutput(input, keyStream, alphabet);
    output = insertSpaceEveryNthCharacter(output, 5);
  }
  else
    output = createDecryptOutput(input, keyStream, alphabet);

  return SolitaireOutput(output, keyStream, solitaireDeckToString(deck));
}

String createEncryptOutput(String input, String keyStream, Map<String, int> alphabet) {
  var output = "";
  for (int i = 0; i < input.length; i++)
    output += Chr(alphabet[input[i]] + alphabet[keyStream[i]], alphabet);

  return output;
}

String createDecryptOutput(String input, String keyStream, Map<String, int> alphabet) {
  var output = "";
  for (int i = 0; i < input.length; i++)
    output += Chr(alphabet[input[i]] - alphabet[keyStream[i]], alphabet);

  return output;
}


List<int> createDeck() {
  var deck = new List<int>();

  for (int i = 0; i < 54; i++)
    deck.add(i + 1);

  return deck;
}

Tuple2<String, List<int>> createKeyStream(String input, String key, List<int> deck, Map<String, int> alphabet) {
  var streamLetters = "";
  int _issueCard;

  // use Key -> init deck
  if (key != null && key!= "") {
    for (int i = 0; i < key.length; i++) {
      deck = cycleDeck(deck);
      deck = takeOff(deck, alphabet[key[i]]);
    }
  }

  for (int i = 0; i < input.length; i++) {
    deck = cycleDeck(deck);
    _issueCard = issueCard(key, i, deck);

    // if issueCard a jocker ?
    while ((_issueCard == _jockerA) || (_issueCard == _jockerB)) {
      deck = cycleDeck(deck);
      _issueCard = issueCard(key, i, deck);
    }
    streamLetters += Chr(_issueCard,alphabet);
  }

  return Tuple2<String, List<int>>( streamLetters,deck);
}

String Chr(int letter, Map<String, int> alphabet) {
  letter = letter % alphabet.length;

  if (letter == 0)
    letter = alphabet.length;

  var letterString = alphabet.keys.firstWhere(
        (k) => alphabet[k] == letter, orElse: () => null);

  return letterString;
}

int issueCard(String key, int index, List<int> deck) {
  int cardIndex= deck[0];

  if (cardIndex == _jockerB)
    cardIndex = _jockerA;
  return deck[cardIndex];
}

List<int> cycleDeck(List<int> deck) {

  // Step 1
  var deckSize = deck.length;
  var offet = 1;
  var jockerAPos = deck.indexOf(_jockerA);
  // last card?
  if (jockerAPos == deckSize - 1)
    // under first card
    offet += 1;
  var newPos = (jockerAPos + offet) % (deckSize);
  deck.remove(_jockerA);
  deck.insert(newPos, _jockerA);

  // Step 2
  offet = 2;
  var jockerBPos = deck.indexOf(_jockerB);
  // last/ prelast card ?
  if (jockerBPos >= deckSize - 2)
    // under first/ second card
    offet += 1;
  newPos = (jockerBPos + offet) % (deckSize);
  deck.remove(_jockerB);
  deck.insert(newPos, _jockerB);

  // Step 3
  jockerAPos = deck.indexOf(_jockerA);
  jockerBPos = deck.indexOf(_jockerB);
  var firstJocker = jockerAPos < jockerBPos ? jockerAPos : jockerBPos;
  var secondJocker = jockerAPos < jockerBPos ? jockerBPos : jockerAPos;

  var newDeck = new List<int>();
  var positionFrom = secondJocker + 1;
  var count = (deckSize - 1) - secondJocker;
  newDeck = copyToDeck(deck, newDeck, positionFrom, count);

  positionFrom = firstJocker;
  count = secondJocker - firstJocker + 1;
  newDeck = copyToDeck(deck, newDeck, positionFrom, count);
  positionFrom = 0;
  count = firstJocker;
  newDeck = copyToDeck(deck, newDeck, positionFrom, count);
  deck = newDeck;

  return takeOff(deck, deck[deckSize - 1]);
}

// Step 4
List<int> takeOff(List<int> deck, int liftOffPosition)  {
  var deckSize = deck.length;
  var newDeck = new List<int>();
  var positionFrom = liftOffPosition;
  if (positionFrom == _jockerB)
    positionFrom = _jockerA;
  var count = (deckSize - 1) - positionFrom;

  newDeck = copyToDeck(deck, newDeck, positionFrom, count);
  count = positionFrom;
  positionFrom = 0;
  newDeck = copyToDeck(deck, newDeck, positionFrom, count);

  // set last card
  newDeck = copyToDeck(deck, newDeck, deckSize - 1, 1);

  return newDeck;
}

List<int> copyToDeck(List<int> deck, List<int> targetDeck, int positionFrom, int count) {

  for (int i = 0; i < count; i++)
    targetDeck.add(deck[positionFrom + i]);

  return targetDeck;
}

String solitaireDeckToString(List<int> deck) {
  var output = '';

  output = deck
    .map((entry) => entry.toString() + ", ")
    .join();

  return  output.replaceFirst(', ', '', output.length-2);
}