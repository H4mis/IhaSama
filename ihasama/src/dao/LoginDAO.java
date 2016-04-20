package dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import luokat.Kayttaja;





public class LoginDAO {

	public LoginDAO() {
		
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (java.lang.ClassNotFoundException ex) {
			System.out.print("ClassNotFoundException: ");
			System.out.println(ex.getMessage());
		}
	}


	Connection yhteys = null;
	
	
	public void avaaYhteys() throws SQLException {
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
	
	//etsitään käyttäjä
		
	public Kayttaja haeKayttaja(String kayttaja, String salasana) throws SQLException {
		
		//haetaan yksi kayttaja tietokannasta 
		
		String sql = "SELECT * FROM Kayttaja WHERE kayttajatunnus= ? and salasana = ?";
		PreparedStatement lause = yhteys.prepareStatement(sql);
		lause.setString(1, kayttaja); //täytetään lausekkeen ? kohta
		lause.setString(2, salasana);
		ResultSet tulokset = lause.executeQuery();//haetaan tietokannasta kayttaja 
	
		
		if(tulokset.equals(null)) { //jos kayttajaa ei löydy tietokannasta palauta null
			System.out.println(tulokset);
			return null;
		}
		
		//haetaan pizzan tiedot
		String etunimi = tulokset.getString("etunimi");
		String sukunimi = tulokset.getString("sukunimi");
		String osoite = tulokset.getString("osoite ");
		String postinro = tulokset.getString("postinro");
		String sahkoposti = tulokset.getString("sahkoposti");
		String kayttajatunnus = tulokset.getString("kayttajatunnus");
		String salasana1 = tulokset.getString("salasana");
		Boolean admin = tulokset.getBoolean("admin");
		String postitmp = tulokset.getString("postitmp");

		Kayttaja kayttaja1 = new Kayttaja(etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, salasana1, admin, postitmp); //luodaan tilaus olio
		return kayttaja1; //palautetaan pizza

}

	
}
	




