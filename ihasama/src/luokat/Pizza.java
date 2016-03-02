package luokat;

public class Pizza {

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
	
	
	
	
	
}
