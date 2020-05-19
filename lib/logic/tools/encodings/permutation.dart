List buildPermutation(String input, bool avoidDouble) {
  if (input == null || input == '')
    return [];

  var letters = input.split('');
  var out = [];

  swap(text, a, b) {
    var storage = text[a];
    text[a] = text[b];
    text[b] = storage;
  }

  perm(text, endIndex) {
    if (endIndex == 0)
      if (!avoidDouble || !out.contains(text.join()))
        return out.add(text.join());
      else
        return;

    perm(text, endIndex-1);
    for (int i = 0; i <= endIndex - 1; i++) {
      swap(text, i, endIndex);
      perm(text,endIndex-1);
      swap(text,i, endIndex);
    }
  }

  perm(letters, letters.length - 1);

  return out;
}
