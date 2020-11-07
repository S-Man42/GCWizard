package interpreter;

import interpreter.Ingredient.State;

public class Component {

	private Ingredient.State state;
	private int value;
	
	public Component(int n, Ingredient.State s) {
		value = n;
		state = s;
	}
	
	public Component(Ingredient ingredient) {
		value = ingredient.getAmount();
		state = ingredient.getstate();
	}

	public int getValue() {
		return value;
	}
	
	public void setValue(int n) {
		value = n;
	}
	
	public Ingredient.State getState() {
		return state;
	}
	
	public void setState(Ingredient.State s) {
		state = s;
	}
	
	@Override
	public Component clone() {
		return new Component(value, state);
	}

	public void liquefy() {
		state = State.Liquid;
	}
}