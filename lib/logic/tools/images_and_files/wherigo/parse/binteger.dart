
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bobject.dart';

class BInteger extends BObject {
  
  final BigInt big;
  final int n;
  
  static BigInt MAX_INT = null;
  static BigInt MIN_INT = null;
  
  BInteger(BInteger b) {
    this.big = b.big;
    this.n = b.n;
  }
  
  BInteger(int n) {
    this.big = null;
    this.n = n;
  }
  
  BInteger(BigInt big) {
    this.big = big;
    this.n = 0;
    if(MAX_INT == null) {
      MAX_INT = BigInt.from(int.MAX_VALUE);
      MIN_INT = BigInt.from(int.MIN_VALUE);
    }
  }

  int asInt() {
    if(big == null) {
      return n;
    } else if(big.compareTo(MAX_INT) > 0 || big.compareTo(MIN_INT) < 0) {
      throw new IllegalStateException("The size of an integer is outside the range that unluac can handle.");
    } else {
      return big.toInt();
    }
  }
  
  void iterate(Runnable thunk) {
    if(big == null) {
      int i = n;
      while(i-- != 0) {
        thunk.run();
      }
    } else {
      BigInteger i = big;
      while(i.signum() > 0) {
        thunk.run();
        i = i.subtract(BigInteger.ONE);
      }
    }
  }

}
