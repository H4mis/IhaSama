package luokat;

import java.util.ArrayList;
import java.util.List;

public class Pizza {
	
	//heh
	
	List<Tayte> taytteet = new ArrayList<Tayte>();

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

	public List<Tayte> getTaytteet() {
		return taytteet;
	}

	public void setTaytteet(List<Tayte> taytteet) {
		this.taytteet = taytteet;
	}
	//tostringit

	@Override
	public String toString() {
		return "Pizza [taytteet=" + taytteet + ", pizzaid=" + pizzaid
				+ ", pizzanimi=" + pizzanimi + ", hinta=" + hinta + "]";
	}
	
	
	
	
	
}
