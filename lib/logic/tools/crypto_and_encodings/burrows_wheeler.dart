
String encryptBurrowsWheeler(String plain, indexChar) {
  int len = plain.length;
  List<String> matrix = new List<String>();

  matrix.add(plain);
    for (int i= 0; i < len - 1; i++) {
      matrix.add(plain.substring(len - i - 1) + plain.substring(0, len - i - 1));
  }

  matrix.sort();

  String chiffre = '';
  int index = 0;
  for (int i = 0; i < len; i++){
    chiffre = chiffre + matrix[i].substring(len - 1);
    if (matrix[i] == plain)
      index = i;
  }

  chiffre = chiffre.substring(0,index) + indexChar + chiffre.substring(index);
  return chiffre;
}


String decryptBurrowsWheeler(String chiffre, indexChar) {
  if (chiffre == '' || chiffre == null)
    return '';

  int len = chiffre.length;
  int index = 0;
  String input = '';

  for (int  i = 0; i < len; i++){
    if (chiffre[i] != indexChar)
      input = input + chiffre[i];
    else
      index = i;
  }
  len = len - 1;

  Map<int, List<String>> tabelle = new Map<int, List<String>>();

  for (int i = 0; i < len; i++){
    tabelle[i] = ([i.toString(), input[i]]);
  }

  for (int i = 0; i < len; i++) {
    for (int j = 0; j < len - 1; j++) {
      if (tabelle[j][1].compareTo(tabelle[j+1][1]) == 1) {
        var h = tabelle[j];
        tabelle[j] = tabelle[j + 1];
        tabelle[j + 1] = h;
      }
    }
  }

  String decodiert = '';
  for (int i = 0; i < len; i++){
    decodiert = decodiert + tabelle[index][1];
    index = int.parse(tabelle[index][0]);
  }
  return decodiert;
}
