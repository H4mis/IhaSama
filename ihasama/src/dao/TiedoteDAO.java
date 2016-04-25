package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import luokat.Pizza;
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
		System.out.println("Tietokantayhteytt� suljettaessa tapahtui virhe!");
		e.printStackTrace();
	}
}

public void lisaaTiedote(Tiedote t) {

	try {
		// alustetaan sql-lause
		String sql = "INSERT INTO Tiedote (tiedote, saatavilla) VALUES (?, ?)";
		PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

		// t�ydennet��n puuttuvat tiedot (eli tiedote)
		lause.setString(1, t.getTiedote());
		lause.setBoolean(2, t.isPiilossa());
	

		// suoritetaan lause
		int vaikutetutRowit = lause.executeUpdate();
		
		if (vaikutetutRowit == 0){
			throw new SQLException("Tiedotteen luominen ep�onnistui, mihink��n rowiin ei tullut mit��n");
		}
		
		System.out.println("Tiedote " + t.getTiedote() + " lis�tty tietokantaan.");
	} catch (Exception e) {
		// Tapahtui jokin virhe
		System.out.println("Tiedotteen lis��misyritys aiheutti virheen tiedotteen lis�ysvaiheessa!");
		System.out.println(t.toString());
	}
	
}

public void muokkaaTiedote(Tiedote t){
	
	try {
		// alustetaan sql-lause
		String sql = "UPDATE Tiedote SET tiedote=?, saatavilla=? WHERE tiedoteid=?";
		PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

		// t�ydennet��n puuttuvat tiedot (eli k�ytt�j�n tiedot)
		lause.setString(1, t.getTiedote());
		lause.setBoolean(2, t.isPiilossa());
		lause.setInt(3, t.getTiedotenro());

		// suoritetaan lause
		int vaikutetutRowit = lause.executeUpdate();
		if (vaikutetutRowit == 0){
			throw new SQLException("Tiedotteen muokkaus ei onnistunut! rowit on tyhji�!");
		}
		System.out.println("tietokantaan lis�ttiin tiedote: " + t.getTiedote() + " .");
		
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
	    System.out.println("Tapahtui virhe yritett�ess� poistaa tiedotetta: " + poistoT);
		e.printStackTrace();
	}
	
}

public List<Tiedote> haeTiedotteet() throws NumberFormatException, SQLException {
	String sql = "SELECT * from Tiedote GROUP BY Tiedote.tiedoteid order by Tiedote.tiedoteid";
	Statement haku = yhteys.createStatement();
	ResultSet tulokset = haku.executeQuery(sql);	
	List<Tiedote> tiedotelista = new ArrayList<Tiedote>();
	tulokset.next();
		int id = tulokset.getInt("tiedoteid");
		String tiedote = tulokset.getString("tiedote");
		boolean piilossa = tulokset.getBoolean("saatavilla");
		Tiedote tiedotus = new Tiedote(id, tiedote, piilossa);
		tiedotelista.add(tiedotus);
		System.out.println("Tietokannasta haettu tiedote: " + tiedotus.getTiedotenro());
	
	if(tiedotelista.isEmpty()){
		return null;
	}
	
	return tiedotelista;
}
	
}
