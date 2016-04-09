package luokat;



public class Pizza {
	
	private int pizzaid;
	private String pizzanimi;
	private double hinta;
	private String taytteet;
	private boolean piilossa;
	
	//parametriton konstruktori
    public Pizza() {
        this.pizzaid = 0;
        this.pizzanimi = null;
        this.hinta = 0;
        this.taytteet = null;
        this.piilossa = false;
    }
        
    //parametrillinen konstruktori
    public Pizza(int id, String nimi, double hinta, String taytteet, boolean piilossa) {
        this.pizzaid = id;
        this.pizzanimi = nimi;
        this.hinta = hinta;
        this.taytteet = taytteet;
        this.piilossa=piilossa;
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

	public void setPiilossa(boolean piilossa) {
		this.piilossa = piilossa;
	}
	
	public boolean isPiilossa() {
		return piilossa;
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
		return "Pizza [pizzaid=" + pizzaid + ", pizzanimi=" + pizzanimi
				+ ", hinta=" + hinta + ", taytteet=" + taytteet + ", piilossa="
				+ piilossa + "]";
	}
}
