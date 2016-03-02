package luokat;

public class Pizzantaytteet {
	//heh
	private int pizzaid;
	private int tayteid;
	
	public Pizzantaytteet(){
		this.pizzaid = 0;
		this.tayteid= 0;
	}
	public Pizzantaytteet(int pizzaid, int tayteid){
		this.pizzaid=pizzaid;
		this.tayteid=tayteid;
	}
	@Override
	public String toString() {
		return "Pizzantaytteet [pizzaid=" + pizzaid + ", tayteid=" + tayteid
				+ "]";
	}
	public int getPizzaid() {
		return pizzaid;
	}
	public void setPizzaid(int pizzaid) {
		this.pizzaid = pizzaid;
	}
	public int getTayteid() {
		return tayteid;
	}
	public void setTayteid(int tayteid) {
		this.tayteid = tayteid;
	}

}
