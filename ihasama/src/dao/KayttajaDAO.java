package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import luokat.Kayttaja;


public class KayttajaDAO {
	
	public KayttajaDAO() {

		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (java.lang.ClassNotFoundException ex) {
			System.out.print("ClassNotFoundException: ");
			System.out.println(ex.getMessage());
		}
	}

	Connection yhteys = null;

	public void avaaYhteys() {
		// K�ytt�j�tiedot ja DB:n osoite - lis�� puuttuvat tiedot!
		String username = "a1500925";
		String password = "syKA4t68r";
		String url = "jdbc:mariadb://localhost/a1500925?useUnicode=true&characterEncoding=utf-8";

		try {
			// Yhdistet��n tietokantaan
			yhteys = DriverManager.getConnection(url, username, password);
			System.out.println("Yhteys avattu tietokantaan.");
		} catch (SQLException ex) {
			System.out.println("Virhe yhteyden avaamisessa");
		}

	}

	public void suljeYhteys() {
		try {
			if (yhteys != null && !yhteys.isClosed()) {
				yhteys.close();
				System.out.println("Yhteys suljettu tietokantaan.");
			}
		} catch (Exception e) {
			System.out.println("Tietokantayhteyden sulkeminen ei onnistunut");
			e.printStackTrace();
		}
	}

	public Kayttaja HaeKayttaja(String kayttajatunnus) throws SQLException {
		Kayttaja kayttaja = new Kayttaja();
		
		String sql = "SELECT * FROM Kayttaja WHERE kayttajatunnus=?"; //haetaan kaikki k�ytt�tunnukset
		PreparedStatement haku = yhteys.prepareStatement(sql);
		haku.setString(1, kayttajatunnus);
		ResultSet tulokset = haku.executeQuery(sql);
		
		while (tulokset.next()) {
			String etunimi = tulokset.getString("etunimi");
			String sukunimi = tulokset.getString("sukunimi");
			String sahkoposti = tulokset.getString("sahkoposti");
			String osoite = tulokset.getString("osoite");
			String postinro = tulokset.getString("postinro");
			String postitmp = tulokset.getString("postitmp");
			kayttaja = new Kayttaja(etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, postitmp);
		}
		System.out.println("Tietokannasta haettiin k�ytt�j� " + kayttaja.getKayttajatunnus() + ", etunimi: " + kayttaja.getEtunimi() + ", sukunimi: " + kayttaja.getSukunimi() + " s�hk�posti: " + kayttaja.getSahkoposti());
		return kayttaja;
	}
	
	public boolean onkoKayttajatunnusOlemassa(Kayttaja k) throws SQLException {
		
		String sql = "SELECT * FROM Kayttaja"; //haetaan kaikki k�ytt�tunnukset
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);
				
		while (tulokset.next()) {
			String kayttajatunnus = tulokset.getString("kayttajatunnus");
			
			//HUOM: EI OTA HUOMIOON ONKO KIRJOITETTU ISOILLA VAI PIENILL� KIRJAIMILLA!
			if(k.getKayttajatunnus().equalsIgnoreCase(kayttajatunnus)) {
				  System.out.println("L�ydettiin samalla nimell� oleva k�ytt�j�tunnus: " + kayttajatunnus);
				  return true; //k�ytt�j� l�ytyi
			}
		}
			    
		return false; //k�ytt�j�� ei l�ytynyt
	}
	
	
	public void lisaaKayttaja(Kayttaja k) {

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// t�ydennet��n puuttuvat tiedot (eli k�ytt�j�n tiedot)
			lause.setString(1, k.getEtunimi());
			lause.setString(2, k.getSukunimi());
			lause.setString(3, k.getSahkoposti());
			lause.setString(4, k.getKayttajatunnus());
			lause.setString(5, k.getSalasana());
			lause.setBoolean(6, k.isAdmin());

			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			
			if (vaikutetutRowit == 0){
				throw new SQLException("K�ytt�j�n luominen ep�onnistui, mihink��n rowiin ei tullut mit��n");
			}
			
			System.out.println("K�ytt�j� " + k.getKayttajatunnus() + " lis�tty tietokantaan.");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("K�ytt�j�n lis��misyritys aiheutti virheen k�ytt�j�n lis�ysvaiheessa!");
			System.out.println(k.toString());
		}
		
	}
	
	public void lisaaOsoiteKayttajalle(Kayttaja k, String osoite, int postinro, String postitmp){
		
		try {
			// alustetaan sql-lause
			String sql = "UPDATE Kayttaja SET osoite=?,postinro=?,postitmp=? WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// t�ydennet��n puuttuvat tiedot (eli k�ytt�j�n tiedot)
			lause.setString(1, osoite);
			lause.setInt(2, postinro);
			lause.setString(3, postitmp);
			lause.setString(4, k.getKayttajatunnus());

			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			if (vaikutetutRowit == 0){
				throw new SQLException("K�ytt�j�n osoitteiden lis�ys ei onnistunut! rowit on tyhji�!");
			}
			System.out.println("tietokantaan lis�ttiin k�ytt�j�n " + k.getKayttajatunnus());
			System.out.println("osoitetiedot: " + k.getOsoite() + " " + k.getPostinro() + " " + k.getPostitmp());
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Osoitetietojen lis�ys k�ytt�j�lle aiheutti virheen!");
		}
		
	}

	public void poistaKayttaja(String[] poistok) {
		
		try {
			String sql = "DELETE FROM Kayttaja WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			for (String s : poistok){
				lause.setString(1, s);
				lause.executeUpdate();
				System.out.println("Listalta poistettii k�ytt�j�tunnus: "+ s);
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe yritett�ess� poistaa k�ytt�j��: " + poistok);
			e.printStackTrace();
		}
		
	}

}

