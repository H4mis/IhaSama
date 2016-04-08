package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
		} catch (SQLException ex) {
			System.out.println("Virhe yhteyden avaamisessa");
		}

	}

	public void suljeYhteys() {
		try {
			if (yhteys != null && !yhteys.isClosed())
				yhteys.close();
		} catch (Exception e) {
			System.out.println("Tietokantayhteys ei jostain syystÃ¤ suostu menemÃ¤Ã¤n kiinni.");
			e.printStackTrace();
		}
	}

	
	public void lisaaKayttaja(Kayttaja k) {

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// tï¿½ydennetï¿½ï¿½n puuttuvat tiedot (eli käyttäjän tiedot)
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
			
			System.out.println("Käyttäjä" + k.getKayttajatunnus() + "lisätty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Käyttäjän lisäämisyritys aiheutti virheen käyttäjän lisäysvaiheessa!");
			System.out.println(k.toString());
		}
		
	}
	
	public void lisaaOsoiteKayttajalle(Kayttaja k, String osoite, int postinro){
		
		try {
			// alustetaan sql-lause
			String sql = "UPDATE Kayttaja SET osoite=?,postinro=? WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// tï¿½ydennetï¿½ï¿½n puuttuvat tiedot (eli käyttäjän tiedot)
			lause.setString(1, osoite);
			lause.setInt(2, postinro);
			lause.setString(3, k.getKayttajatunnus());

			// suoritetaan lause
			
			
			System.out.println("Käyttäjän " + k.getKayttajatunnus() + " osoitetiedot lisÃ¤tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("Käyttäjän osoitetietojen lisÃ¤Ã¤misyritys aiheutti virheen osoitetietojen lisäysvaiheessa!");
		}
		
	}
		
	

	public void poistaKayttaja(String[] poistok) {
		
		
		try {
			String sql = "DELETE FROM Kayttaja WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			for (String s : poistok){
				lause.setString(1, s);
				lause.executeUpdate();
				System.out.println("Käyttäjätunnus: "+ s + " poistettiin listalta.");
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe poistossa!");
			e.printStackTrace();
		}
		
	}

}

