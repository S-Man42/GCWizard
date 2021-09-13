
enum MurrayCodebook { GEOCACHING, ROYALNAVY, FISCHER, ROUCOUX }

Map<MurrayCodebook, Map<String, String>> MURRAY_CODEBOOK = {
  MurrayCodebook.GEOCACHING: {'title': 'telegraph_murray_geocaching_title', 'subtitle': 'telegraph_murray_geocaching_description'},
  MurrayCodebook.ROYALNAVY: {'title': 'telegraph_murray_royalnavy_title', 'subtitle': 'telegraph_murray_royalnavy_description'},
  MurrayCodebook.FISCHER: {'title': 'telegraph_murray_fischer_title', 'subtitle': 'telegraph_murray_fischer_description'},
  MurrayCodebook.ROUCOUX : {'title': 'telegraph_murray_roucoux_title', 'subtitle': 'telegraph_murray_roucoux_description'},
};


final Map<String, List<String>> CODEBOOK_ROYALNAVY = {
  'A': ['2', '3', '4', '5', '6'],
  'B': ['1', '3', '4', '5', '6'],
  'C': ['1', '2', '4', '5', '6'],
  'D': ['1', '2', '3', '5', '6'],
  'E': ['1', '2', '3', '4', '6'],
  'F': ['1', '2', '3', '4', '5'],
  'G': ['1'],
  'H': ['2'],
  'I': ['3'],
  'K': ['4'],
  'L': ['5'],
  'M': ['6'],
  'N': [],
  'O': [],
  'P': [],
  'Q': [],
  'R': [],
  'S': [],
  'T': [],
  'V': [],
  '0': [],
  '1': [],
  '2': [],
  '3': [],
  '4': [],
  '5': [],
  '6': [],
  '7': [],
  '8': [],
  '9': [],
  ':': [],
  ';': [],
};

final Map<String, List<String>> CODEBOOK_GEOCACHING = {
  'A': [],
  'B': [],
  'C': [],
  'D': [],
  'E': [],
  'F': [],
  'G': [],
  'H': [],
  'I': [],
  'J': [],
  'K': [],
  'L': [],
  'M': [],
  'N': [],
  'O': [],
  'P': [],
  'Q': [],
  'R': [],
  'S': [],
  'T': [],
  'U': [],
  'V': [],
  '0': [],
  '1': [],
  '2': [],
  '3': [],
  '4': [],
  '5': [],
  '6': [],
  '7': [],
  '8': [],
  '9': [],
  ':': [],
  ';': [],
};

final Map<String, List<String>> CODEBOOK_FISCHER = {
  'A': [],
  'B': [],
  'C': [],
  'D': [],
  'E': [],
  'F': [],
  'G': [],
  'H': [],
  'I': [],
  'J': [],
  'K': [],
  'L': [],
  'M': [],
  'N': [],
  'O': [],
  'P': [],
  'Q': [],
  'R': [],
  'S': [],
  'T': [],
  'U': [],
  'V': [],
  '0': [],
  '1': [],
  '2': [],
  '3': [],
  '4': [],
  '5': [],
  '6': [],
  '7': [],
  '8': [],
  '9': [],
  ':': [],
  ';': [],
};

final Map<String, List<String>> CODEBOOK_ROUCOUX = {
  'A': [],
  'B': [],
  'C': [],
  'D': [],
  'E': [],
  'F': [],
  'G': [],
  'H': [],
  'I': [],
  'J': [],
  'K': [],
  'L': [],
  'M': [],
  'N': [],
  'O': [],
  'P': [],
  'Q': [],
  'R': [],
  'S': [],
  'T': [],
  'U': [],
  'V': [],
  '0': [],
  '1': [],
  '2': [],
  '3': [],
  '4': [],
  '5': [],
  '6': [],
  '7': [],
  '8': [],
  '9': [],
  ':': [],
  ';': [],
};


List<List<String>> encodeMurray(String input, MurrayCodebook language) {
  if (input == null) return [];

  Map<String, List<String>> CODEBOOK = new Map<String, List<String>>();
  switch (language) {
    case MurrayCodebook.GEOCACHING:
      CODEBOOK = CODEBOOK_GEOCACHING;
      break;
    case MurrayCodebook.ROYALNAVY:
      CODEBOOK = CODEBOOK_ROYALNAVY;
      break;
    case MurrayCodebook.FISCHER:
      CODEBOOK = CODEBOOK_FISCHER;
      break;
    case MurrayCodebook.ROUCOUX:
      CODEBOOK = CODEBOOK_ROUCOUX;
      break;
    }

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (CODEBOOK[inputs[i].toUpperCase()] != null)
      result.add(CODEBOOK[inputs[i].toUpperCase()]);
  }
  return result;
}

Map<String, dynamic> decodeMurray(
    List<String> input, MurrayCodebook language, bool letters) {
  if (input == null || input.length == 0)
    return {
      'displays': <List<String>>[],
      'chars': [0]
    };
}

