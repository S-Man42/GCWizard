import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/ingredient.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chefException.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/component.dart';

class Container {

  List<Component> _contents;

/*
  Container() {
    _contents = new List<Component>();
  }
*/

  Container(Container container) {
    _contents = new List<Component>();
    if (container != null)
      _contents.addAll(container._contents);
  }

  void push(Component c) {
    _contents.add(c);
  }

  Component peek() {
    return _contents[_contents.length-1];
  }

  Component pop()  { //throws ChefException
    if (_contents.length == 0)
      throw new ChefException(ChefException.LOCAL, "Folded from empty container");
    return _contents.removeAt(_contents.length-1);
  }

  int size() {
    return _contents.length;
  }

  void combine(Container c) {
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
      if (_contents[i].getState() == State.Dry) {
        result += _contents[i].getValue().toString() + " ";
      }
      else {
        result += (_contents[i].getValue() % 1112064).toString()[0];
      }
    }
    return result;
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