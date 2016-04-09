package luokat;

public class Tayte {

	private int tayteid;
	private String taytenimi;
	private boolean saatavilla;
	
	public Tayte(int tayteid, String taytenimi, boolean saatavilla) {
		super();
		this.tayteid = tayteid;
		this.taytenimi = taytenimi;
		this.saatavilla = saatavilla;
	}

	public int getTayteid() {
		return tayteid;
	}

	public void setTayteid(int tayteid) {
		this.tayteid = tayteid;
	}

	public String getTaytenimi() {
		return taytenimi;
	}

	public void setTaytenimi(String taytenimi) {
		this.taytenimi = taytenimi;
	}

	public boolean isSaatavilla() {
		return saatavilla;
	}

	public void setSaatavilla(boolean saatavilla) {
		this.saatavilla = saatavilla;
	}
}
