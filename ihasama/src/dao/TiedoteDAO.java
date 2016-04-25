package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import luokat.Tiedote;

public class TiedoteDAO {
	
	public TiedoteDAO() {


	try {
		Class.forName("org.mariadb.jdbc.Driver");
	} catch (java.lang.ClassNotFoundException ex) {
		System.out.print("ClassNotFoundException: ");
		System.out.println(ex.getMessage());
	}
}
	
Connection yhteys = null;

public void avaaYhteys() {
	// Käyttäjätiedot ja DB:n osoite - lisää puuttuvat tiedot!
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
		System.out.println("Tietokantayhteyttä suljettaessa tapahtui virhe!");
		e.printStackTrace();
	}
}

public void lisaaTiedote(Tiedote t) {

	try {
		// alustetaan sql-lause
		String sql = "INSERT INTO Tiedote (tiedote, piilossa) VALUES (?, ?)";
		PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

		// täydennetään puuttuvat tiedot (eli tiedote)
		lause.setString(1, t.getTiedote());
		lause.setBoolean(2, t.isPiilossa());
	

		// suoritetaan lause
		int vaikutetutRowit = lause.executeUpdate();
		
		if (vaikutetutRowit == 0){
			throw new SQLException("Tiedotteen luominen epäonnistui, mihinkään rowiin ei tullut mitään");
		}
		
		System.out.println("Tiedote " + t.getTiedote() + " lisätty tietokantaan.");
	} catch (Exception e) {
		// Tapahtui jokin virhe
		System.out.println("Tiedotteen lisäämisyritys aiheutti virheen tiedotteen lisäysvaiheessa!");
		System.out.println(t.toString());
	}
	
}

public void muokkaaTiedote(Tiedote t){
	
	try {
		// alustetaan sql-lause
		String sql = "UPDATE Tiedote SET tiedote=?, piilossa=? WHERE tiedotenro=?";
		PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

		// tï¿½ydennetï¿½ï¿½n puuttuvat tiedot (eli käyttäjän tiedot)
		lause.setString(1, t.getTiedote());
		lause.setBoolean(2, t.isPiilossa());

		// suoritetaan lause
		int vaikutetutRowit = lause.executeUpdate();
		if (vaikutetutRowit == 0){
			throw new SQLException("Tiedotteen muokkaus ei onnistunut! rowit on tyhjiä!");
		}
		System.out.println("tietokantaan lisättiin tiedote: " + t.getTiedote() + " .");
		
	} catch (Exception e) {
		// Tapahtui jokin virhe
		System.out.println("Tiedotteen muokkaus aiheutti virheen!");
	}
	
}

public void poistaTiedote(String[] poistoT) {
	
	try {
		String sql = "DELETE FROM Tiedote WHERE tiedotenro=?";
		PreparedStatement lause = yhteys.prepareStatement(sql);
		for (String T : poistoT){
			lause.setString(1, T);
			lause.executeUpdate();
			System.out.println("Listalta poistettiin tiedote: "+ T);
		}
	} catch (SQLException e) {
	    System.out.println("Tapahtui virhe yritettäessä poistaa tiedotetta: " + poistoT);
		e.printStackTrace();
	}
	
}
	
}
