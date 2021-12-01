
//import unluac.decompile.Declaration;
//import unluac.decompile.Decompiler;
//import unluac.decompile.Output;

abstract class Target {

  void print(Decompiler d, Output out);
  
  void printMethod(Decompiler d, Output out);
  
  bool isDeclaration(Declaration decl) {
    return false;
  }
  
  bool isLocal() {
    return false;
  }
  
  int getIndex() {
    throw new IllegalStateException();
  }
  
  bool isFunctionName() {
    return true;
  }
  
  bool beginsWithParen() {
    return false;
  }
  
}
