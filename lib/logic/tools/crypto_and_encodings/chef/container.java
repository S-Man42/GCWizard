package interpreter;

import interpreter.Ingredient.State;

import java.util.ArrayList;
import java.util.Collections;

public class Container {

	ArrayList<Component> contents;
	
	public Container() {
		contents = new ArrayList<Component>();
	}
	
	public Container(Container container) {
		contents = new ArrayList<Component>(container.contents);
	}

	public void push(Component c) {
		contents.add(c);
	}
	
	public Component peek() {
		return contents.get(contents.size()-1);
	}
	
	public Component pop() throws ChefException {
		if (contents.size() == 0)
			throw new ChefException(ChefException.LOCAL, "Folded from empty container");
		return contents.remove(contents.size()-1);
	}
	
	public int size() {
		return contents.size();
	}
	
	public void combine(Container c) {
		contents.addAll(c.contents);
	}

	public void liquefy() {
		for (Component c : contents)
			c.liquefy();
	}

	public void clean() {
		contents = new ArrayList<Component>();
	}
	
	public String serve() {
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

	public void shuffle() {
		Collections.shuffle(contents);
	}

	public void stir(int time) {
		for (int i = 0; i < time && i + 1< contents.size(); i++) {
			Collections.swap(contents, contents.size()-i-1, contents.size()-i-2);
		}
	}
}