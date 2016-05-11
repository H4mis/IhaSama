package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import luokat.Kayttaja;


public class TietojenMuokkausDAO {
	
	public TietojenMuokkausDAO() {

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

	
	
	public void muokkaaTietoja(Kayttaja k){
		
		try {
			// alustetaan sql-lause
			String sql = "UPDATE Kayttaja SET etunimi=?, sukunimi=?, osoite=?, postinro=?, postitmp=?, sahkoposti=? WHERE kayttajatunnus=?";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// t�ydennet��n puuttuvat tiedot (eli k�ytt�j�n tiedot)
			 	lause.setString(1, k.getEtunimi());
			 	lause.setString(2, k.getSukunimi());
	            lause.setString(3, k.getOsoite());
	            lause.setString(4, k.getPostinro());
	            lause.setString(5, k.getPostitmp());
	            lause.setString(6, k.getSahkoposti());

	            lause.setString(7, k.getKayttajatunnus());

	    
			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			if (vaikutetutRowit == 0){
				throw new SQLException("Tietojen muokkaus ei onnistunut! rowit on tyhji�!");
			}
			System.out.println("tietokantaan muokattiin k�ytt�j�n " + k.getKayttajatunnus());
			System.out.println("tiedot: " + k.getEtunimi() + " " + k.getSukunimi() + " " + k.getOsoite() + " " + k.getPostinro() + " " + k.getPostitmp() + " "  + k.getSahkoposti());
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("K�ytt�j�n tietojen muokkaus aiheutti virheen!");
		}
		
	}
}

	