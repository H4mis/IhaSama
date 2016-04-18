package luokat;

public class Maksu {
	
		
		private String korttiHaltija;
		   private String tyyppi;
		    private String korttiNro;
		    private String vanhenee;

		    public Maksu (String korttiHaltija, String korttiNro, String tyyppi, String vanhenee)
		    {
		    	super();
		    	this.korttiHaltija=korttiHaltija;
		    	this.korttiNro=korttiNro;
		    	this.tyyppi=tyyppi;
		    	this.vanhenee=vanhenee;
		    	
		    	
		    }

			public String getKorttiHaltija() {
				return korttiHaltija;
			}

			public void setKorttiHaltija(String korttiHaltija) {
				this.korttiHaltija = korttiHaltija;
			}

			public String getTyyppi() {
				return tyyppi;
			}

			public void setTyyppi(String tyyppi) {
				this.tyyppi = tyyppi;
			}

			public String getKorttiNro() {
				return korttiNro;
			}

			public void setKorttiNro(String korttiNro) {
				this.korttiNro = korttiNro;
			}

			public String getVanhenee() {
				return vanhenee;
			}

			public void setVanhenee(String vanhenee) {
				this.vanhenee = vanhenee;
			}

			@Override
			public String toString() {
				return "Maksu [korttiHaltija=" + korttiHaltija + ", tyyppi="
						+ tyyppi + ", korttiNro=" + korttiNro + ", vanhenee="
						+ vanhenee + "]";
			}
			

		    

	}

