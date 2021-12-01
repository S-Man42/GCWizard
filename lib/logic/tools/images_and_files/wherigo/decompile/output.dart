

class Output {

  OutputProvider out;
  int indentationLevel = 0;
  int position = 0;

  Output() {
    this(new OutputProvider() {

      void print(String s) {
        System.out.print(s);
      }

      void print(byte b) {
        System.out.write(b);
      }

      @Override
      public void println() {
        System.out.println();
      }

    });
  }

  Output(OutputProvider out) {
    this.out = out;
  }

  void indent() {
    indentationLevel += 2;
  }

  void dedent() {
    indentationLevel -= 2;
  }

  int getIndentationLevel() {
    return indentationLevel;
  }

  int getPosition() {
    return position;
  }

  void setIndentationLevel(int indentationLevel) {
    this.indentationLevel = indentationLevel;
  }

  void start() {
    if(position == 0) {
      for(int i = indentationLevel; i != 0; i--) {
        out.print(" ");
        position++;
      }
    }
  }

  void print(String s) {
    start();
    out.print(s);
    position += s.length;
  }

  void print(int b) {
    start();
    out.print(b);
    position += 1;
  }

  void println() {
    start();
    out.println();
    position = 0;
  }

  void println(String s) {
    print(s);
    println();
  }

}
