import 'package:gc_wizard/utils/common_utils.dart';

enum ChaoAlphabet{AZ, ZA, CUSTOM}

String _permuteChiffreAlphabet(String chiffreChar, String alphabet){
  int nadir = 13;
  int zenith = 0;
  String helpAlphabet = '';
  String returnAlphabet = '';
  int posChiffreChar = alphabet.indexOf(chiffreChar);

  //shift chiffreAlphabet to the left until the chiffreChar is at first position - zenith
  for (int i = posChiffreChar; i <= 25; i++){
    helpAlphabet = helpAlphabet + alphabet[i];
  }
  for (int i = 0; i < posChiffreChar; i++){
    helpAlphabet = helpAlphabet + alphabet[i];
  }

  //get char at position zenith + 1
  var helpChar = helpAlphabet[zenith + 1];

  //shift chiffreAlphabet to left from zenith + 2 to nadir
  returnAlphabet = helpAlphabet[0];
  for (int i = zenith + 2; i <= nadir; i++){
    returnAlphabet = returnAlphabet + helpAlphabet[i];
  }
  //insert char at nadir
  returnAlphabet = returnAlphabet +  helpChar;

  for (int i = nadir + 1; i <= 25; i++){
    returnAlphabet = returnAlphabet + helpAlphabet[i];
  }
print('new c = ' + returnAlphabet);
  return returnAlphabet;
}


String _permutePlainAlphabet(String plainChar, String alphabet){
  int nadir = 13;
  int zenith = 0;
  String helpAlphabet = '';
  String returnAlphabet = '';
  int posPlainChar = alphabet.indexOf(plainChar);

  //shift plainAlphabet to the left until the plainChar is at first position - zenith
  for (int i = posPlainChar; i <= 25; i++){
    helpAlphabet = helpAlphabet + alphabet[i];
  }
  for (int i = 0; i < posPlainChar; i++){
    helpAlphabet = helpAlphabet + alphabet[i];
  }

  //shift plainAlphabet 1 to the left
  returnAlphabet = helpAlphabet;
  helpAlphabet = '';
  var helpChar = returnAlphabet[0];
  for (int i = 1; i <=25; i++){
    helpAlphabet = helpAlphabet + returnAlphabet[i];
  }
  helpAlphabet = helpAlphabet + helpChar;

  //get chat at zenith + 2
  helpChar = helpAlphabet[zenith + 2];

  //shift plainalphabet from zenith + t to nadir one to the left
  returnAlphabet = helpAlphabet[0];
  returnAlphabet = returnAlphabet + helpAlphabet[1];
  for (int i = zenith + 3; i <= nadir; i++){
    returnAlphabet = returnAlphabet + helpAlphabet[i];
  }
  //insert char at nadir
  returnAlphabet = returnAlphabet + helpChar;

  for (int i = nadir + 1; i <= 25; i++){
    returnAlphabet = returnAlphabet + helpAlphabet[i];
  }

  print('new p : ' + returnAlphabet);
  return returnAlphabet;
}


String encryptChao(String plaintext, String alphabetPlain, String alphabetChiffre){
  String chiffretext = '';
  var chiffreChar;
  var plainChar;
  for (int i = 0; i < plaintext.length; i++) {
      plainChar = plaintext[i].toUpperCase();
      if (alphabetPlain.indexOf(plainChar) >= 0) {
        chiffreChar = alphabetChiffre[alphabetPlain.indexOf(plainChar)];
        chiffretext = chiffretext + chiffreChar;
        alphabetChiffre = _permuteChiffreAlphabet(chiffreChar, alphabetChiffre);
        alphabetPlain = _permutePlainAlphabet(plainChar, alphabetPlain);
      }
  }
  return chiffretext;
}


String decryptChao(String chiffretext, String alphabetPlain, String alphabetChiffre){
  String plaintext = '';
  var chiffreChar;
  var plainChar;
  for (int i = 0; i < chiffretext.length; i++) {
    chiffreChar = chiffretext[i].toUpperCase();
    if (alphabetChiffre.indexOf(chiffreChar) >= 0) {
      plainChar = alphabetPlain[alphabetChiffre.indexOf(chiffreChar)];
      plaintext = plaintext + plainChar;
      alphabetChiffre = _permuteChiffreAlphabet(chiffreChar, alphabetChiffre);
      alphabetPlain = _permutePlainAlphabet(plainChar, alphabetPlain);
    }
  }
  return plaintext;
}