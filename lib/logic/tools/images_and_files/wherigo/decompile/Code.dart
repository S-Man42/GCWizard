
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/lfunction.dart';

class Code {

   CodeExtract Code51 = new CodeExtract() {

     int extract_A(int codepoint) {
      return (codepoint >> 6) & 0x0000000FF;
    }

    int extract_C(int codepoint) {
      return (codepoint >> 14) & 0x000001FF;
    }

    int extract_B(int codepoint) {
      return codepoint >>> 23;
    }

    int extract_Bx(int codepoint) {
      return codepoint >>> 14;
    }

    int extract_sBx(int codepoint) {
      return (codepoint >>> 14) - 131071;
    }

    int extract_op(int codepoint) {
      return codepoint & 0x0000003F;
    }

  };

  final CodeExtract extractor;
  final OpcodeMap map;
  final int[] code;

  Code(LFunction function) {
    this.code = function.code;
    map = function.header.version.getOpcodeMap();
    extractor = function.header.extractor;
  }

  //public boolean reentered = false;

  Op op(int line) {
    /*if(!reentered) {
      reentered = true;
      System.out.println("line " + line + ": " + toString(line));
      reentered = false;
    }*/
    return map.get(opcode(line));
  }

  int opcode(int line) {
    return code[line - 1] & 0x0000003F;
  }

  int A(int line) {
    return extractor.extract_A(code[line - 1]);
  }

  int C(int line) {
    return extractor.extract_C(code[line - 1]);
  }

  int B(int line) {
    return extractor.extract_B(code[line - 1]);
  }

  int Bx(int line) {
    return extractor.extract_Bx(code[line - 1]);
  }

  int sBx(int line) {
    return extractor.extract_sBx(code[line - 1]);
  }

  int codepoint(int line) {
    return code[line - 1];
  }

  int length() {
    return code.length;
  }

  String toString(int line) {
    return op(line).codePointToString(codepoint(line), extractor);
  }

}
