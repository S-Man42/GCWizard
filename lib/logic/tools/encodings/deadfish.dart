String encodeDeadfish(text) {
  if (text == null ||  text == '')
    return '';

  var out = '';
  var memory = 0;
  text.codeUnits.forEach((ascii) {
    if (ascii > memory) {
      while (memory != ascii) {
        if (memory <= 1) {
          out += 'i';
          memory++;
        }
        if (memory * memory <= ascii && memory > 1) {
          out += 's';
          memory *= memory;
        }
        if (memory * memory >= ascii) {
          while (ascii > memory) {
            out += 'i';
            memory++;
          }
        }
      }
    } else if (ascii < memory) {
      while (ascii < memory) {
        out += 'd';
        memory--;
      }
    }
    out += 'o';
  });
  return out;
}

String decodeDeadfish(text) {
  if (text == null || text == '')
    return '';

  var memory = 0;
  List<int> ascii = [];
  text.toLowerCase().split('').forEach((character) {
    switch (character) {
      case 'i': memory++; break;
      case 'd': memory--; break;
      case 's': memory *= memory; break;
      case 'o': ascii.add(memory); break;
    }
  });
  return String.fromCharCodes(ascii).replaceAll('\x00', '');
}
