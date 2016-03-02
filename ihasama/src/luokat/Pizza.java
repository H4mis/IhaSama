package luokat;

public class Pizza {
	
	//heh

	private int pizzaid;
	private String pizzanimi;
	private double hinta;
	
	//parametriton konstruktori
	public Pizza() {
		this.pizzaid = 0;
		this.pizzanimi = null;
		this.hinta = 0;
	}
		
	//parametrillinen konstruktori
	public Pizza(int id, String nimi, double hinta) {
		this.pizzaid = id;
		this.pizzanimi = nimi;
		this.hinta = hinta;
	}

	public int getPizzaid() {
		return pizzaid;
	}

	public void setPizzaid(int pizzaid) {
		this.pizzaid = pizzaid;
	}

	public String getPizzanimi() {
		return pizzanimi;
	}

	public void setPizzanimi(String pizzanimi) {
		this.pizzanimi = pizzanimi;
	}

	public double getHinta() {
		return hinta;
	}

	public void setHinta(double hinta) {
		this.hinta = hinta;
	}

	@Override
	public String toString() {
		return "Pizza [pizzaid=" + pizzaid + ", pizzanimi=" + pizzanimi
				+ ", hinta=" + hinta + "]";
	}
	
	
	
	
	
}
