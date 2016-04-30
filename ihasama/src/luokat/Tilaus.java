package luokat;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Tilaus {

	private int tilausnro; //id
	private String tilaajatunnus; //asiakasid
	private Date tilausaika; 
	private int varausnro; //p�yd�n varausnro
	private boolean valmiina;
	private boolean toimitettu;
	private String toimitustapa; //tekstin�: nouto, kuljetus, paikanp��ll�
	List<Integer> pizzantilausAvuste;
	
	List<TilattuPizza> tilatutPizzat;
	
	public Tilaus() {
		this.tilausnro = -1;
		this.tilaajatunnus = null;
		this.tilausaika = new Date(); //luodaan uusi tilausaika Tilaus-olion luodessa.
		this.varausnro = -1;
		this.valmiina = false;
		this.toimitustapa = "ei valittu";
		List<TilattuPizza> tilatutPizzat1 = new ArrayList<TilattuPizza>(); //luodaan tyhj� lista pizzoille
		this.tilatutPizzat = tilatutPizzat1;
		List<Integer> pizzantilausAvuste2 = new ArrayList<Integer>();
		this.pizzantilausAvuste = pizzantilausAvuste2;
	}
	
	public Tilaus(int tilausnro, Date tilausaika, String toimitustapa) {
		this.tilausnro = tilausnro;
		this.tilaajatunnus = null;
		this.tilausaika = tilausaika;
		this.varausnro = -1;
		this.valmiina = false;
		this.toimitettu = false;
		this.toimitustapa = toimitustapa;		
		
		List<TilattuPizza> tilatutPizzat1 = new ArrayList<TilattuPizza>(); //luodaan tyhj� lista pizzoille
		this.tilatutPizzat = tilatutPizzat1;
	}
	
	public Tilaus(int tilausnro, String tilaajatunnus, Date tilausaika, int varausnro, boolean valmiina, boolean toimitettu, String toimitustapa) {
		this.tilausnro = tilausnro;
		this.tilaajatunnus = tilaajatunnus;
		this.tilausaika = tilausaika;
		this.varausnro = varausnro;
		this.valmiina = valmiina;
		this.toimitettu = toimitettu;
		this.toimitustapa = toimitustapa;
	}
	
	public Tilaus(int tilausnro, String tilaajatunnus, Date tilausaika, boolean valmiina, boolean toimitettu, String toimitustapa, List<TilattuPizza> tilatutPizzat) {
		this.tilausnro = tilausnro;
		this.tilaajatunnus = tilaajatunnus;
		this.tilausaika = tilausaika;		
		this.valmiina = valmiina;
		this.toimitettu = toimitettu;
		this.toimitustapa = toimitustapa;
		this.tilatutPizzat = tilatutPizzat;
	}
	
	public Tilaus(int tilausnro, String tilaajatunnus, Date tilausaika, boolean valmiina, boolean toimitettu, String toimitustapa, List<TilattuPizza> tilatutPizzat, List<Integer> pizzantilausAvuste) {
		this.tilausnro = tilausnro;
		this.tilaajatunnus = tilaajatunnus;
		this.tilausaika = tilausaika;		
		this.valmiina = valmiina;
		this.toimitettu = toimitettu;
		this.toimitustapa = toimitustapa;
		this.tilatutPizzat = tilatutPizzat;
		this.pizzantilausAvuste = pizzantilausAvuste;
	}

		
	public int getTilausnro() {
		return tilausnro;
	}

	public void setTilausnro(int tilausnro) {
		this.tilausnro = tilausnro;
	}

	public String getTilaajatunnus() {
		return tilaajatunnus;
	}

	public void setTilaajatunnus(String tilaajatunnus) {
		this.tilaajatunnus = tilaajatunnus;
	}

	public Date getTilausaika() {
		return tilausaika;
	}

	public void setTilausaika(Date tilausaika) {
		this.tilausaika = tilausaika;
	}

	public int getVarausnro() {
		return varausnro;
	}

	public void setVarausnro(int varausnro) {
		this.varausnro = varausnro;
	}

	public boolean isValmiina() {
		return valmiina;
	}

	public void setValmiina(boolean valmiina) {
		this.valmiina = valmiina;
	}

	public boolean isToimitettu() {
		return toimitettu;
	}

	public void setToimitettu(boolean toimitettu) {
		this.toimitettu = toimitettu;
	}

	public String getToimitustapa() {
		return toimitustapa;
	}

	public void setToimitustapa(String toimitustapa) {
		this.toimitustapa = toimitustapa;
	}

	public List<TilattuPizza> getTilatutPizzat() {
		return tilatutPizzat;
	}

	public void setTilatutPizzat(List<TilattuPizza> tilatutPizzat) {
		this.tilatutPizzat = tilatutPizzat;
	}
	public List<Integer> getPizzantilausAvuste() {
		return pizzantilausAvuste;
	}

	public void setPizzantilausAvuste(List<Integer> pizzantilausAvuste) {	
		
		this.pizzantilausAvuste = pizzantilausAvuste;
	}
	
}
