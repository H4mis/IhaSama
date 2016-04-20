package luokat;

public class TilattuPizza {
	private Pizza pizza;
	private boolean oregano;
	private boolean laktoositon;
	private boolean gluteeniton;

	public TilattuPizza(Pizza pizza, boolean oregano, boolean laktoositon, boolean gluteeniton) {
		this.pizza = pizza;
		this.oregano = oregano;
		this.laktoositon = laktoositon;
		this.gluteeniton = gluteeniton;
	}

	public Pizza getPizza() {
		return pizza;
	}

	public void setPizza(Pizza pizza) {
		this.pizza = pizza;
	}

	public boolean isOregano() {
		return oregano;
	}

	public void setOregano(boolean oregano) {
		this.oregano = oregano;
	}

	public boolean isLaktoositon() {
		return laktoositon;
	}

	public void setLaktoositon(boolean laktoositon) {
		this.laktoositon = laktoositon;
	}

	public boolean isGluteeniton() {
		return gluteeniton;
	}

	public void setGluteeniton(boolean gluteeniton) {
		this.gluteeniton = gluteeniton;
	}
	
	
}
