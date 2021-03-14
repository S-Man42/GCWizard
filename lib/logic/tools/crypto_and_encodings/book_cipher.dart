import 'dart:math';
import 'package:tuple/tuple.dart';

class _wordClass {
  int SectionIndex;
  int RowIndex;
  int WordIndex;
  String Text;

  _wordClass(int sectionIndex, int rowIndex, int wordIndex, String text) {
    SectionIndex = sectionIndex;
    RowIndex = rowIndex;
    WordIndex = wordIndex;
    Text = text;
  }
}

enum searchFormat {
  SectionRowWord,
  RowWord,
  Word,
  SectionRowWordLetter,
  RowWordLetter,
  WordLetter,
  Letter,
}

enum decodeOutFormat {
  SectionRowWord,
  RowWord,
  Word,
}

enum encodeOutFormat { SectionRowWordLetter, RowWordLetter, WordLetter, Letter }

String decodeSearchWord(
    String input, String word, decodeOutFormat format, String sectionLabel, String rowLabel, String wordLabel) {
  if (input == null || input.length == 0) return "";
  if (word == null || word.length == 0) return "";

  var wordList = _wordList(input);
  word = word.toUpperCase();

  var out = wordList.where((e) => e.Text.toUpperCase() == word).map((e) {
    switch (format) {
      case decodeOutFormat.SectionRowWord:
        return sectionLabel +
            ": " +
            e.SectionIndex.toString() +
            ", " +
            rowLabel +
            ": " +
            e.RowIndex.toString() +
            ", " +
            wordLabel +
            ": " +
            e.WordIndex.toString();
      case decodeOutFormat.RowWord:
        return rowLabel +
            ": " +
            _findRowIndex(e, wordList).toString() +
            ", " +
            wordLabel +
            ": " +
            e.WordIndex.toString();
      case decodeOutFormat.Word:
        return wordLabel + ": " + _findWordIndex(e, wordList).toString();
    }
    ;
  }).join('\n');

  return out;
}

String decodeFindWord(String input, String positions, searchFormat format) {
  if (input == null || input.length == 0) return "";
  if (positions == null || positions.length == 0) return "";

  List<int> positionList = List<int>();
  List<String> out = List<String>();
  int i = 0;

  RegExp regExp = new RegExp("[0-9]{1,}");
  regExp.allMatches(positions).forEach((elem) {
    positionList.add(int.tryParse(positions.substring(elem.start, elem.end)));
  });

  var wordList = _wordList(input);

  while (i < positionList.length) {
    switch (format) {
      case searchFormat.SectionRowWord:
        if (i + 2 < positionList.length)
          out.add(_findWord(wordList, format,
              section: positionList[i + 0], row: positionList[i + 1], word: positionList[i + 2]));
        i += 3;
        break;

      case searchFormat.RowWord:
        if (i + 1 < positionList.length)
          out.add(_findWord(wordList, format, row: positionList[i + 0], word: positionList[i + 1]));
        i += 2;
        break;

      case searchFormat.Word:
        if (i + 0 < positionList.length) out.add(_findWord(wordList, format, word: positionList[i + 0]));
        i += 1;
        break;

      case searchFormat.SectionRowWordLetter:
        if (i + 3 < positionList.length)
          out.add(_findWord(wordList, format,
              section: positionList[i + 0],
              row: positionList[i + 1],
              word: positionList[i + 2],
              letter: positionList[i + 3]));
        i += 4;
        break;

      case searchFormat.RowWordLetter:
        if (i + 2 < positionList.length)
          out.add(_findWord(wordList, format,
              row: positionList[i + 0], word: positionList[i + 1], letter: positionList[i + 2]));
        i += 3;
        break;

      case searchFormat.WordLetter:
        if (i + 1 < positionList.length)
          out.add(_findWord(wordList, format, word: positionList[i + 0], letter: positionList[i + 1]));
        i += 2;
        break;

      case searchFormat.Letter:
        if (i + 0 < positionList.length) out.add(_findWord(wordList, format, letter: positionList[i + 0]));
        i += 1;
        break;
    }
  }

  return out.map((e) {
    return e.toUpperCase();
  }).join();
}

String encodeText(String input, String text, encodeOutFormat format) {
  if (input == null || input.length == 0) return "";
  if (text == null || text.length == 0) return "";

  var out = '';
  var wordList = _wordList(input);
  var positionList = List<Tuple2<_wordClass, int>>();
  text = _removeNonLetters(text);

  text.split('').forEach((letter) {
    positionList.add(_selectRandomLetterPosition(letter, wordList));
  });

  positionList.forEach((element) {
    var e = element.item1;
    switch (format) {
      case encodeOutFormat.SectionRowWordLetter:
        if (e == null)
          out += _createOutElement(true, -1, -1, -1, -1);
        else
          out += _createOutElement(false, e.SectionIndex, e.RowIndex, e.WordIndex, element.item2);
        break;

      case encodeOutFormat.RowWordLetter:
        if (e == null)
          out += _createOutElement(true, 0, -1, -1, -1);
        else
          out += _createOutElement(false, 0, _findRowIndex(e, wordList), e.WordIndex, element.item2);
        break;

      case encodeOutFormat.WordLetter:
        if (e == null)
          out += _createOutElement(true, 0, 0, -1, -1);
        else
          out += _createOutElement(false, 0, 0, _findWordIndex(e, wordList), element.item2);
        break;

      case encodeOutFormat.Letter:
        if (e == null)
          out += _createOutElement(true, 0, 0, 0, -1);
        else
          out += _createOutElement(false, 0, 0, 0, _globalLetterPosition(e, element.item2, wordList));
        break;
    }
  });

  return out.trim();
}

String _createOutElement(bool emptyElement, int number1, int number2, int number3, int number4) {
  var seperator = '.';
  var out = '';

  if (emptyElement) {
    if (number1 != 0) out += "?" + seperator;
    if (number2 != 0) out += "?" + seperator;
    if (number3 != 0) out += "?" + seperator;
    if (number4 != 0) out += "?";
  } else {
    if (number1 != 0) out += number1.toString() + seperator;
    if (number2 != 0) out += number2.toString() + seperator;
    if (number3 != 0) out += number3.toString() + seperator;
    if (number4 != 0) out += number4.toString();
  }

  return out + " ";
}

int _findRowIndex(_wordClass word, List<_wordClass> wordList) {
  var rowIndex = 0;
  var rowIndexTmp = 0;
  var lastRowIndex = 0;
  var sectionIndex = 0;

  for (var item in wordList) {
    if (sectionIndex != item.SectionIndex)
      rowIndexTmp += 1;
    else if (lastRowIndex != item.RowIndex) rowIndexTmp += 1;

    lastRowIndex = item.RowIndex;
    sectionIndex = item.SectionIndex;

    if (word == item) {
      rowIndex = rowIndexTmp;
      break;
    }
  }
  ;

  return rowIndex;
}

int _findWordIndex(_wordClass word, List<_wordClass> wordList) {
  return wordList.indexOf(word) + 1;
}

String _findWord(List<_wordClass> wordList, searchFormat format,
    {int section: 0, int row: 0, int word: 0, int letter: 0}) {
  List<_wordClass> list;
  _wordClass wordEntry;

  switch (format) {
    case searchFormat.SectionRowWord:
      list = _filterSection(section, wordList);
      list = _filterRow(row, list);
      return _filterWord(word, list).Text;

    case searchFormat.RowWord:
      list = _filterRow(row, wordList);
      return _filterWord(word, list).Text;

    case searchFormat.Word:
      return _filterWord(word, wordList).Text;

    case searchFormat.SectionRowWordLetter:
      list = _filterSection(section, wordList);
      list = _filterRow(row, list);
      wordEntry = _filterWord(word, list);
      list = List<_wordClass>.from([wordEntry]);
      return _filterLetter(letter, list);

    case searchFormat.RowWordLetter:
      list = _filterRow(row, wordList);
      wordEntry = _filterWord(word, list);
      list = List<_wordClass>.from([wordEntry]);
      return _filterLetter(letter, list);

    case searchFormat.WordLetter:
      wordEntry = _filterWord(word, wordList);
      list = List<_wordClass>.from([wordEntry]);
      return _filterLetter(letter, list);

    case searchFormat.Letter:
      return _filterLetter(letter, wordList);
  }

  return "";
}

List<_wordClass> _filterSection(int index, List<_wordClass> wordList) {
  var list = new List<_wordClass>();

  wordList.forEach((item) {
    if (item.SectionIndex == index) list.add(item);
  });

  return list;
}

List<_wordClass> _filterRow(int index, List<_wordClass> wordList) {
  var list = new List<_wordClass>();
  var rowIndex = 0;
  var lastRowIndex = 0;
  var sectionIndex = 0;

  wordList.forEach((item) {
    if (sectionIndex != item.SectionIndex)
      rowIndex += 1;
    else if (lastRowIndex != item.RowIndex) rowIndex += 1;

    lastRowIndex = item.RowIndex;
    sectionIndex = item.SectionIndex;

    if (rowIndex == index) list.add(item);
  });

  return list;
}

_wordClass _filterWord(int index, List<_wordClass> wordList) {
  if (index > 0 && wordList.length >= index) return wordList[index - 1];

  return new _wordClass(-1, -1, -1, "");
}

String _filterLetter(int index, List<_wordClass> wordList) {
  var text = "";

  wordList.forEach((item) {
    text += item.Text;
  });
  text = _removeNonLetters(text);

  if (index > 0 && index <= text.length) return text[index - 1];

  return "";
}

int _globalLetterPosition(_wordClass word, int letterPosition, List<_wordClass> wordList) {
  var text = "";

  for (var item in wordList) {
    if (item == word) break;
    text += item.Text;
  }

  text = _removeNonLetters(text);

  return text.length + letterPosition;
}

String _removeNonLetters(String text, {bool startCharacter = false, bool lastCharacter = false}) {
  if (!startCharacter & !lastCharacter) return text.replaceAll(RegExp(r"[!\W]"), '');
  if (startCharacter) text = text.replaceAll(RegExp(r"^[!\W]"), '');
  if (lastCharacter) text = text.replaceAll(RegExp(r"[!\W]$"), '');

  return text;
}

Tuple2<_wordClass, int> _selectRandomLetterPosition(String letter, List<_wordClass> wordList) {
  var letterCount = 0;
  var letterCountTmp = 0;
  var letterWordList = List<_wordClass>();
  var letterPosition = 0;
  var outWord = null;
  var outLetterPosition = 0;

  var regexp = RegExp(letter, caseSensitive: false);

  wordList.forEach((element) {
    letterCountTmp = regexp.allMatches(element.Text).length;
    if (letterCountTmp > 0) letterWordList.add(element);
    letterCount += letterCountTmp;
  });

  if (letterCount > 0) {
    var randomIndex = Random().nextInt(letterCount);

    letterCount = 0;
    letterCountTmp = 0;
    for (_wordClass word in letterWordList) {
      if (outWord != null) break;
      letterPosition = 0;
      regexp.allMatches(word.Text).forEach((element) {
        letterPosition = word.Text.toUpperCase().indexOf(letter.toUpperCase(), letterPosition);
        letterPosition += 1;
        if (letterCountTmp == randomIndex) {
          outWord = word;
          outLetterPosition = letterPosition;
        }
        letterCountTmp += 1;
      });
    }
    ;
  }
  return Tuple2<_wordClass, int>(outWord, outLetterPosition);
}

List<_wordClass> _wordList(String input) {
  var list = new List<_wordClass>();
  int sectionIndex = 0;
  int rowIndex = 0;
  int wordIndex = 0;

  input.split(RegExp(r"\n\s*\n")).forEach((section) {
    sectionIndex += 1;
    rowIndex = 0;
    section.split(RegExp(r"\n")).forEach((row) {
      rowIndex += 1;
      wordIndex = 0;
      row.split(RegExp(r"[\s]|[\.]|[,]|[!]|[\?]|[\\]")).forEach((word) {
        // replace nonLetters at the beginning and at the end
        word = _removeNonLetters(word, startCharacter: true, lastCharacter: true);
        if (word.length > 0) {
          wordIndex += 1;
          list.add(new _wordClass(sectionIndex, rowIndex, wordIndex, word));
        }
      });
    });
  });

  return list;
}
