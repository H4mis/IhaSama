package luokat;



public class Pizza {
	
	//heh
	
	

	private int pizzaid;
	private String pizzanimi;
	private double hinta;
	private String taytteet;
	
	//parametriton konstruktori
	public Pizza() {
		this.pizzaid = 0;
		this.pizzanimi = null;
		this.hinta = 0;
		this.taytteet = null;
	}
		
	//parametrillinen konstruktori
	public Pizza(int id, String nimi, double hinta, String taytteet) {
		this.pizzaid = id;
		this.pizzanimi = nimi;
		this.hinta = hinta;
		this.taytteet = taytteet;
	}

	//Getterit ja setterit
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

	
	

	public String getTaytteet() {
		return taytteet;
	}

	public void setTaytteet(String taytteet) {
		this.taytteet = taytteet;
	}

	//tostringit
	
	@Override
	public String toString() {
		return "Pizza [taytteet=" + taytteet + ", pizzaid=" + pizzaid
				+ ", pizzanimi=" + pizzanimi + ", hinta=" + hinta + "]";
	}
	
	
	
	
	
}
