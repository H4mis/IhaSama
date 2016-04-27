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
	
	//etsit��n k�ytt�j�
		
	public Kayttaja haeKayttaja(String kayttaja, String salasana)
			throws SQLException {

		// haetaan yksi kayttaja tietokannasta

		String sql = "SELECT * FROM Kayttaja WHERE kayttajatunnus= ? and salasana = ?";
		PreparedStatement lause = yhteys.prepareStatement(sql);
		lause.setString(1, kayttaja); // t�ytet��n lausekkeen ? kohta
		lause.setString(2, salasana);
		ResultSet tulokset = lause.executeQuery();// haetaan tietokannasta
													// kayttaja
		Kayttaja kayttaja1 = new Kayttaja();

		while (tulokset.next()) {

			// haetaan pizzan tiedot
			String etunimi = tulokset.getString("etunimi");
			String sukunimi = tulokset.getString("sukunimi");
			String osoite = tulokset.getString("osoite");
			String postinro = tulokset.getString("postinro");
			String sahkoposti = tulokset.getString("sahkoposti");
			String kayttajatunnus = tulokset.getString("kayttajatunnus");
			String salasana1 = tulokset.getString("salasana");
			Boolean admin = tulokset.getBoolean("admin");
			String postitmp = tulokset.getString("postitmp");

			if (postinro == null) {
				postinro = "0";
			}
			int postinro2 = Integer.parseInt(postinro);
			
			kayttaja1.setEtunimi(etunimi);  // luodaan
			kayttaja1.setSukunimi(sukunimi);
			kayttaja1.setOsoite(osoite);
			kayttaja1.setPostinro(postinro2); // tilaus
			kayttaja1.setSahkoposti(sahkoposti);
			kayttaja1.setKayttajatunnus(kayttajatunnus);
			kayttaja1.setSalasana(salasana1);
			kayttaja1.setAdmin(admin); 
			kayttaja1.setPostitmp(postitmp);// olio
			
		
		}

		return kayttaja1;
	}

	
}
	




