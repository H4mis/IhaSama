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
		// Kï¿½yttï¿½jï¿½tiedot ja DB:n osoite - lisï¿½ï¿½ puuttuvat tiedot!
		String username = "a1500925";
		String password = "syKA4t68r";
		String url = "jdbc:mariadb://localhost/a1500925?useUnicode=true&characterEncoding=utf-8";

		try {
			// Yhdistetï¿½ï¿½n tietokantaan
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
		
		String sql = "SELECT * FROM Kayttaja WHERE kayttajatunnus=?"; //haetaan kaikki käyttätunnukset
		PreparedStatement haku = yhteys.prepareStatement(sql);
		haku.setString(1, kayttajatunnus);
		ResultSet tulokset = haku.executeQuery();
		
		while (tulokset.next()) {
			String etunimi = tulokset.getString("etunimi");
			String sukunimi = tulokset.getString("sukunimi");
			String sahkoposti = tulokset.getString("sahkoposti");
			String osoite = tulokset.getString("osoite");
			String Spostinro = tulokset.getString("postinro");
			int postinro;
			if (Spostinro == null){
				postinro = -1;
			} else {
				postinro = Integer.parseInt(Spostinro);
			}
			String postitmp = tulokset.getString("postitmp");
			kayttaja = new Kayttaja(etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, postitmp);
		}
		System.out.println("Tietokannasta haettiin käyttäjä " + kayttaja.getKayttajatunnus() + ", etunimi: " + kayttaja.getEtunimi() + ", sukunimi: " + kayttaja.getSukunimi() + " sähköposti: " + kayttaja.getSahkoposti());
		return kayttaja;
	}
	
	public boolean onkoKayttajatunnusOlemassa(Kayttaja k) throws SQLException {
		
		String sql = "SELECT * FROM Kayttaja"; //haetaan kaikki käyttätunnukset
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);
				
		while (tulokset.next()) {
			String kayttajatunnus = tulokset.getString("kayttajatunnus");
			
			//HUOM: EI OTA HUOMIOON ONKO KIRJOITETTU ISOILLA VAI PIENILLÄ KIRJAIMILLA!
			if(k.getKayttajatunnus().equalsIgnoreCase(kayttajatunnus)) {
				  System.out.println("Löydettiin samalla nimellä oleva käyttäjätunnus: " + kayttajatunnus);
				  return true; //käyttäjä löytyi
			}
		}
			    
		return false; //käyttäjää ei löytynyt
	}
	
	
	public void lisaaKayttaja(Kayttaja k) {

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// täydennetään puuttuvat tiedot (eli käyttäjän tiedot)
			lause.setString(1, k.getEtunimi());
			lause.setString(2, k.getSukunimi());
			lause.setString(3, k.getSahkoposti());
			lause.setString(4, k.getKayttajatunnus());
			lause.setString(5, k.getSalasana());
			lause.setBoolean(6, k.isAdmin());

			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			
			if (vaikutetutRowit == 0){
				throw new SQLException("Käyttäjän luominen epäonnistui, mihinkään rowiin ei tullut mitään");
			}
			
			System.out.println("Käyttäjä " + k.getKayttajatunnus() + " lisätty tietokantaan.");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Käyttäjän lisäämisyritys aiheutti virheen käyttäjän lisäysvaiheessa!");
			System.out.println(k.toString());
		}
		
	}
	
	public void lisaaOsoiteKayttajalle(Kayttaja k, String osoite, String postinro, String postitmp){
		
		try {
			// alustetaan sql-lause
			String sql = "UPDATE Kayttaja SET osoite=?,postinro=?,postitmp=? WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// tï¿½ydennetï¿½ï¿½n puuttuvat tiedot (eli käyttäjän tiedot)
			lause.setString(1, osoite);
			lause.setString(2, postinro);
			lause.setString(3, postitmp);
			lause.setString(4, k.getKayttajatunnus());

			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			if (vaikutetutRowit == 0){
				throw new SQLException("Käyttäjän osoitteiden lisäys ei onnistunut! rowit on tyhjiä!");
			}
			System.out.println("tietokantaan lisättiin käyttäjän " + k.getKayttajatunnus());
			System.out.println("osoitetiedot: " + k.getOsoite() + " " + k.getPostinro() + " " + k.getPostitmp());
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Osoitetietojen lisäys käyttäjälle aiheutti virheen!");
		}
		
	}

	public void poistaKayttaja(String[] poistok) {
		
		try {
			String sql = "DELETE FROM Kayttaja WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			for (String s : poistok){
				lause.setString(1, s);
				lause.executeUpdate();
				System.out.println("Listalta poistettii käyttäjätunnus: "+ s);
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe yritettäessä poistaa käyttäjää: " + poistok);
			e.printStackTrace();
		}
		
	}

}

