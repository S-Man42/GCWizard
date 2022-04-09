class PietIO{
    Output(dynamic value) {
        print(value.ToString());
    }

    int ReadInt() {
        return int.tryParse("3");
    }

    String ReadChar() {
        return 'A'; // (char)Console.Read();
    }
}

