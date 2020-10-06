import 'dart:math';

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

enum outFormat {
  SectionRowWord,
  RowWord,
  Word,
}

String searchWord(String input, String word, outFormat format, String sectionLabel, String rowLabel, String wordLabel){
  if (input == null || input.length == 0)
    return "";
  if (word == null || word.length == 0)
    return "";

  var wordList = _wordList(input);
  word = word.toUpperCase();

  var x = wordList
      .where((e) => e.Text.toUpperCase() == word);
  var y = wordList
      .where((e) => e.Text.toUpperCase() == word);

  var out = wordList
    .where((e) => e.Text.toUpperCase() == word)
    .map((e) {
      switch (format) {
        case outFormat.SectionRowWord:
          return sectionLabel + ": " + e.SectionIndex.toString() + ", " + rowLabel + ": " + e.RowIndex.toString() + ", " + wordLabel + ": " + e.WordIndex.toString();
        case outFormat.RowWord:
          return rowLabel + ": " + _findRowIndex(e, wordList).toString() + ", " + wordLabel + ": " + e.WordIndex.toString();
        case outFormat.Word:
          return wordLabel + ": " + _findWordIndex(e, wordList).toString();
      };
    })
    .join('\n');

  /*
  wordList.forEach((e) {
    out += e.Text + ": " + e.SectionIndex.toString() + " " + e.RowIndex.toString() + " " + e.WordIndex.toString() + "\n";
  });*/
  return out;
}

String findWord(String input, String positions, searchFormat format){
  if (input == null || input.length == 0)
    return "";
  if (positions == null || positions.length == 0)
    return "";

  List<int> positionList = List<int>();
  List<String> out = List<String>();
  int i = 0;

  RegExp regExp = new RegExp("[0-9]{1,}");
  regExp.allMatches(positions).forEach((elem) {
    positionList.add(int.tryParse(positions.substring(elem.start, elem.end)));
  });

  var wordList = _wordList(input);

  while (i < positionList.length){
    switch (format) {
      case searchFormat.SectionRowWord:
        if (i + 2 < positionList.length)
         out.add(_findWord(wordList, format, section : positionList[i+0], row : positionList[i+1], word : positionList[i+2]));
        i+=3;
        break;

      case searchFormat.RowWord:
        if (i + 1 < positionList.length)
          out.add(_findWord(wordList, format, row : positionList[i+0], word : positionList[i+1]));
        i+=2;
        break;

      case searchFormat.Word:
        if (i + 0 < positionList.length)
          out.add(_findWord(wordList, format, word : positionList[i+0]));
        i+=1;
        break;

      case searchFormat.SectionRowWordLetter:
        if (i + 3 < positionList.length)
          out.add(_findWord(wordList, format, section : positionList[i+0], row : positionList[i+1], word : positionList[i+2], letter : positionList[i+3]));
        i+=4;
        break;

      case searchFormat.RowWordLetter:
        if (i + 2 < positionList.length)
          out.add(_findWord(wordList, format, row : positionList[i+0], word : positionList[i+1], letter : positionList[i+2]));
        i+=3;
        break;

      case searchFormat.WordLetter:
        if (i + 1 < positionList.length)
          out.add(_findWord(wordList, format, word : positionList[i+0], letter : positionList[i+1]));
        i+=2;
        break;

      case searchFormat.Letter:
        if (i + 0 < positionList.length)
          out.add(_findWord(wordList, format, letter : positionList[i+0]));
        i+=1;
        break;
    }
  }

  return out
    .map((e) {
      return e;
    })
    .join('\n');
}

int _findRowIndex(_wordClass word, List<_wordClass> wordList){
  var rowIndex = 0;
  var rowIndexTmp = 0;
  var lastRowIndex = 0;
  var sectionIndex = 0;

  for (var item in wordList) {
    if (sectionIndex != item.SectionIndex)
      rowIndexTmp += 1;
    else if (lastRowIndex != item.RowIndex)
      rowIndexTmp += 1;

    lastRowIndex = item.RowIndex;
    sectionIndex = item.SectionIndex;

    if (word == item){
      rowIndex = rowIndexTmp;
      break;
    }
  };

  return rowIndex;
}

int _findWordIndex(_wordClass word, List<_wordClass> wordList){
  return wordList.indexOf(word) + 1;
}

String _findWord(List<_wordClass> wordList, searchFormat format, { int section : 0, int row : 0, int word : 0, int letter : 0}) {
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
      list =  List<_wordClass>.from([wordEntry]);
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
    if (item.SectionIndex == index)
      list.add(item);
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
    else if (lastRowIndex != item.RowIndex)
      rowIndex += 1;

    lastRowIndex = item.RowIndex;
    sectionIndex = item.SectionIndex;

    if (rowIndex == index)
      list.add(item);
 });

  return list;
}

_wordClass _filterWord(int index, List<_wordClass> wordList) {
  if (index > 0 && wordList.length >= index)
    return wordList[index - 1];

  return new _wordClass(-1, -1, -1, "");
}

String _filterLetter(int index, List<_wordClass> wordList) {
  var text = "";

  wordList.forEach((item) {text += item.Text;});
  text = text.replaceAll(RegExp(r"[!\W]"), "");

  if (index > 0 && index <= text.length)
    return text[index - 1];

  return "";
}

List<_wordClass> _wordList(String input) {
  var list = new List<_wordClass>();
  int sectionIndex = 0;
  int rowIndex = 0;
  int wordIndex = 0;

  input
    .split(RegExp(r"\n\s*\n"))
    .forEach((section) {
      sectionIndex += 1;
      rowIndex = 0;
      section
        .split(RegExp(r"\n"))
        .forEach((row) {
          rowIndex += 1;
          wordIndex = 0;
          row
            .split(RegExp(r"\s"))
            .forEach((word) {
              word = word.replaceAll(RegExp(r"^[!\W]|[!\W]$"), "");
              if (word.length > 0) {
                wordIndex += 1;
                list.add(new _wordClass(sectionIndex, rowIndex, wordIndex, word));
              }
            });
        });
    });

  return list;
}

