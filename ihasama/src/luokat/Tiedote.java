package luokat;

public class Tiedote {
	
	private int tiedotenro;
	private String tiedote;
	private boolean piilossa;
	
	 public Tiedote() {
	        this.tiedotenro = 0;
	        this.tiedote = null;
	        this.piilossa = false;
	    }
	        
	    //parametrillinen konstruktori
	    public Tiedote(int tiedotenro, String tiedote, boolean piilossa) {
	        this.tiedotenro = tiedotenro;
	        this.tiedote = tiedote;
	        this.piilossa=piilossa;
	    }
	
	
	public int getTiedotenro() {
		return tiedotenro;
	}
	public void setTiedoteNro(int tiedotenro) {
		this.tiedotenro = tiedotenro;
	}
	public String getTiedote() {
		return tiedote;
	}
	public void setTiedote(String tiedote) {
		this.tiedote = tiedote;
	}
	public boolean isPiilossa() {
		return piilossa;
	}
	public void setPiilossa(boolean piilossa) {
		this.piilossa = piilossa;
	}
	@Override
	public String toString() {
		return "Tiedote [tiedotenro=" + tiedotenro + ", tiedote=" + tiedote
				+ ", piilossa=" + piilossa + "]";
	}
	

}

