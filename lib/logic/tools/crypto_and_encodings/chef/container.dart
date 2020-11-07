
class Container {

  List contents;

   Container() {
    contents = new List();
  }

  Container(Container container) {
    contents = new List(container.contents);
  }

  void push(Component c) {
    contents.add(c);
  }

  Component peek() {
    return contents.get(contents.size()-1);
  }

  Component pop() throws ChefException {
  if (contents.size() != 0)
    return contents.remove(contents.size()-1);
  else
    return null;
}

int size() {
  return contents.size();
}

void combine(Container c) {
  contents.addAll(c.contents);
}

void liquefy() {
  for (Component c : contents)
    c.liquefy();
}

void clean() {
  contents = new List<Component>();
}

String serve() {
  String result = "";
  for (int i = contents.size()-1; i >= 0; i--) {
    if (contents.get(i).getState() == State.Dry) {
      result += contents.get(i).getValue()+" ";
    }
    else {
      result += Character.toChars((int) (contents.get(i).getValue() % 1112064))[0];
    }
  }
  return result;
}

void shuffle() {
  Collections.shuffle(contents);
}

void stir(int time) {
  for (int i = 0; i < time && i + 1< contents.size(); i++) {
    Collections.swap(contents, contents.size()-i-1, contents.size()-i-2);
  }
}
}