/*# -*- coding: utf-8 -*-
"""Basic functions for encoding/decoding substitution ciphers with a given key
"""
import sys
*/
import 'dart:io';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';

class AlphabetInvalid{
/*
    """An exception raised when an alphabet is invalid"""
    pass
    */
    AlphabetInvalid(Exception ex);
}

class KeyInvalid{
/*    """An exception raised when a key is invalid"""
    pass
    */
KeyInvalid(Exception ex);
    }


class Key{
/*
    """Uses a key and an alphabet for transcoding substitution ciphers.

    The first character of the alphabet corresponds to the first character of the
    key, the second character of the alphabet to the second character of the key,
    and so on. The alphabet can consist of any characters (including e.g.
    umlauts), and the length is variable, i.e., it is not restricted to the 26 letters
    of the alphabet.

    :example:
        ::

            Alphabet: abcdefghijklmnopqrstuvwxyz
            Key:      zebrascdfghijklmnopqtuvwxy

        The letter "a" from the plaintext maps to "z" in the ciphertext, "b" to "e",
        and so on. Thus the plaintext "flee at once. we are discovered!" is enciphered
        as "siaa zq lkba. va zoa rfpbluaoar!"

        This example was taken from
        `Wikipedia <https://en.wikipedia.org/wiki/Substitution_cipher>`_.

    :param str key: The key to use. Must have the same length than alphabet.
        It is case insensitive.
    :param str alphabet: The set of characters which define the alphabet.
        Characters which are not in the alphabet will be ignored when transcoding.
    """
*/

    //static const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyz";
    String _alphabet = null;
    String _key = null;
    Map<String,String> _encode = null;
    Map<String,String> _decode = null;

Key (String key, {String alphabet=DEFAULT_ALPHABET}) {
/*       """Instantiate object
    """
    */
    this._alphabet = check_alphabet(alphabet);
    if (this._alphabet == null)
        return;
    this._key = check_key(key, this._alphabet);
    if (this._key == null)
        return;

    var camel_key = (_upper(key) + key.toLowerCase()).split('').toList();
    var camel_alphabet = (_upper(alphabet) + alphabet.toLowerCase()).split('').toList();
    this._encode = _maketrans(camel_alphabet, camel_key);
    this._decode = _maketrans(camel_key, camel_alphabet);
}



//@staticmethod
static String check_alphabet(String alphabet) {
    /*
    """Checks an alphabet for consistency

    Checks, if each character is unique.

    :param str alphabet: the alphabet to check
    :return: the alphabet in normalized form (i.e., in lower cases)
    :rtype: str
    :raises: AlphabetInvalid if the check fails
    """
    */
    if ((alphabet == null) || (alphabet == ''))
        return null;
    alphabet = alphabet.toLowerCase();
    if (alphabet.length != _set(alphabet).length)
        //raise AlphabetInvalid("alphabet characters must be unique")
        return null;
    return alphabet;
}

//@staticmethod
static String check_key(String key, String alphabet){
/*        """Checks a key for consistency against a given alphabet

    It is assumed that the given alphabet has already been check for consistency
    before. The following checks are performed:

    - the characters in the key must be unique
    - the key must have the same length than the alphabet
    - the set of characters in the key must be the same than the set of characters
      in the alphabet

    :param str key: the key to be validated
    :param str alphabet: the alphabet against which the key is validated
    :return: the validated key in normalized form (i.e., in lower cases)
    :rtype: str
    :raises: KeyInvalid if one of the checks fails
    """
    */
    if ((key == null) || (key == ''))
        return null;
    key = key.toLowerCase();
    if (key.length != _set(key).length) 
        //raise KeyInvalid("key characters must be unique");
        return null;

    if (key.length != alphabet.length)
        //raise KeyInvalid("key must be as long as the alphabet");
        return null;
    bool result = true;
    key.split('').map((char) =>  result & alphabet.contains(char));
    if (!result)
       // raise KeyInvalid("key must use the same set of characters than the alphabet");
       return null;
    return key;
}

//@staticmethod
static String _upper(String string){
/*        """
    Converts a string to upper case in a safe way

    Reason for this function is the German "ß".
    Problem: "ß".upper() results in "SS" which corrupts the xcoding translation
    table. Therefore in such a case the character is simply taken as it is and
    is not converted.

    :Example:
        "Viele Grüße".upper() results in "VIELE GRÜSSE"
        _upper("Viele Grüße") results in "VIELE GRÜßE"

    :param str string: the string to be converted to upper case
    :return: the string converted to upper case
    :rtype: str
    """
    */
/*
    return "".join(
        [char.upper() if len(char.upper()) == 1 else char for char in string]  ;
    );
    */
 return string.toUpperCase();
}

String decode(String ciphertext){
/*    """Decodes a ciphertext with the given key into the plaintext

    :param str ciphertext: the ciphertext to decode with the given key
    :return: the resulting plaintext
    :rtype: str
    """
    return ciphertext.translate(this._decode);
    */
    return substitution(ciphertext, this._decode);
}

String encode(String plaintext){
/*    """Encodes a plaintext with the given key into the ciphertext

    :param str plaintext: the plaintext to encode with the given key
    :return: the resulting ciphertext
    :rtype: str
    """
     return plaintext.translate(this._encode);
   */
    return substitution(plaintext, this._encode);
}

decode_file(String ciphertext, File plaintext_fh){
/*    """Decodes ciphertext read from the given file handle

    :param ciphertext_fh: the file handle (i.e., a read()-supporting file like
        object) the ciphertext is read from. Defaults to STDIN.
    :type ciphertext_fh: file object
    :param plaintext_fh: the file handle (i.e., a .write()-supporting file like
        object) the resulting plaintext is written to. Defaults to STDOUT.
    :type plaintext_fh: file object
    """

    for line in ciphertext_fh:
        plaintext_fh.write(this.decode(line))
              */
ciphertext
    .split('\n')
    .forEach((line) {
        plaintext_fh.writeAsString(this.decode(line));
}   );

}

encode_file(String plaintext, File ciphertext_fh){
/*    """Encodes plaintext read from the given file handle

    :param plaintext_fh: the file handle (i.e., a read()-supporting file like
        object) the plaintext is read from. Defaults to STDIN.
    :type plaintext_fh: file object
    :param ciphertext_fh: the file handle (i.e., a .write()-supporting file like
        object) the resulting ciphertext is written to. Defaults to STDOUT.
    :type ciphertext_fh: file object
    """

    for line in plaintext_fh:
        ciphertext_fh.write(this.encode(line));
        */
    plaintext
    .split('\n')
    .forEach((line) {
        ciphertext_fh.writeAsString(this.encode(line));
    });
}

static Map<String,String> _maketrans(List<String> keyList, List<String> valueList){
    Map<String, String> map = {};
    for (int i = keyList.length -1; i >= 0; i--) {
        map.putIfAbsent(keyList[i], () => valueList[i]);
    }
    return map;
}
// remove double characters
static String _set(String text) {
   return text.split('').toSet().join(); // remove double characters
}
}