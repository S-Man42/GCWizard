import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/ingredient.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/component.dart';

class Container {

  List<Component> _contents;

  Container(Container container) {
    _contents = new List<Component>();
    if (container != null)
      _contents.addAll(container._contents);
  }

  void push(Component c) {
print('        CONTAINER push ['+c.getName()+'.'+c.getValue().toString()+'.'+c.getState().toString()+']');
    _contents.add(c);
  }

  Component peek() {
    var c = _contents[_contents.length-1];
print('        CONTAINER peek ['+c.getName()+'.'+c.getValue().toString()+'.'+c.getState().toString()+']');
    return c;
  }

  Component pop()  { //throws ChefException
    if (_contents.length != 0) {
      var c = _contents.removeAt(_contents.length - 1);
      // TO DO throw new ChefException(ChefException.LOCAL, "Folded from empty container");
print('        CONTAINER pop ['+c.getName()+'.'+c.getValue().toString()+'.'+c.getState().toString()+']');
      return c;
    }
  }

  int size() {
    return _contents.length;
  }

  void combine(Container c) {
String inhalt = ''; for (int i=0;i<c._contents.length;i++){inhalt=inhalt+c._contents[i].getName()+'.'+c._contents[i].getValue().toString();};
print('       CONTAINER combine ['+inhalt+']');
    _contents.addAll(c._contents);
  }

  void liquefy() {
    _contents.forEach((c) {
      c.liquefy();
    });
  }

  void clean() {
    _contents = new List<Component>();
  }

  String serve() {
    String result = "";
    for (int i = _contents.length-1; i >= 0; i--) {
print('conatiner.serve content '+i.toString()+' - '+_contents[i].getValue().toString()) ;
      if (_contents[i].getState() == State.Dry) {
        result = result + _contents[i].getValue().toString() + ' ';
      }
      else {// in charCodes umwandeln
        //result += (_contents[i].getValue() % 1112064).toString()[0];
        //result = result + (_contents[i].getValue()).toString() + ' ';
        result = result + String.fromCharCode(_contents[i].getValue()) ;
      }
    }
print('container.serve ' + result);
    return result;
  }

  List<String> getContent(){
    List<String> out = new List<String>();
    for (int i = _contents.length-1; i >= 0; i--) {
      out.add(_contents[i].getValue().toString());
    }
    return out;
  }

  void shuffle() {
    _contents.shuffle();
  }

  void stir(int time) {
    for (int i = 0; i < time && i + 1< _contents.length; i++) {
      var tmp = _contents[_contents.length-i-1];
      _contents[_contents.length-i-1] = _contents[_contents.length-i-2];
      _contents[_contents.length-i-2] = tmp;
    }
  }
}