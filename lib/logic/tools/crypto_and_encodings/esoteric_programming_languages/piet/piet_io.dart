class PietIO{
  Output(String value) {
    print(value);
  }

  int ReadInt() {
    return int.tryParse("5");
  }

  String ReadChar() {
    return 'A'; // (char)Console.Read();
  }
}

