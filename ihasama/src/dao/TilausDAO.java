package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import luokat.TilattuPizza;
import luokat.Tilaus;

public class TilausDAO {

	public TilausDAO() {

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
	
	public Tilaus haeTilaus(Tilaus tilaus) throws SQLException {
		
				//haetaan yksi tilaus tietokannasta ja palautetaan se valmiina Pizzaoliona
				String sql = "SELECT * FROM Tilaus WHERE tilausnro= " + tilaus.getTilausnro();
				PreparedStatement lause = yhteys.prepareStatement(sql);
				ResultSet tulokset = lause.executeQuery();//haetaan tietokannasta tilausnro löytyvä Tilaus
				tulokset.next(); //mene ekalle riville
				
				if(tulokset.equals(null)) { //jos tilausta ei löydy tietokannasta palauta null
					return null;
				}
				
				//haetaan pizzan tiedot
				int tilausnro = tulokset.getInt("tilausnro");
				String tilaajatunnus = tulokset.getString("tilaajatunnus");
				Date tilausaika = tulokset.getDate("tilausaika");
				int varausnro = tulokset.getInt("varausnro");
				boolean valmiina = tulokset.getBoolean("valmiina");
				boolean toimitettu = tulokset.getBoolean("toimitettu");
				String toimitustapa = tulokset.getString("toimitustapa");

				Tilaus tilaus1 = new Tilaus(tilausnro, tilaajatunnus, tilausaika, varausnro, valmiina, toimitettu, toimitustapa); //luodaan tilaus olio
				return tilaus1; //palautetaan pizza

	}
	
	public void LisaaTilaus(Tilaus tilaus) {
		
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Tilaus (tilausaika, valmiina, toimitettu, toimitustapa) VALUES (?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// täydennetään puuttuvat tiedot (eli käyttäjän tiedot)
			lause.setDate(1, (Date) tilaus.getTilausaika());
			lause.setBoolean(2, tilaus.isValmiina());
			lause.setBoolean(3, tilaus.isToimitettu());
			lause.setString(4, tilaus.getToimitustapa());
			
			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			
			if (vaikutetutRowit == 0){
				throw new SQLException("Tilauksen luominen epäonnistui, kenttiä tyhjinä?");
			}
			
			System.out.println("Tilaus " + tilaus.getTilausnro() + " lisätty tietokantaan.");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Tilauksen lisäämisyritys aiheutti virheen lisäysvaiheessa!");
			System.out.println(tilaus.toString());
		}
	}
	
	public void LisaaPizzaTilaukseen(TilattuPizza tpizza, Tilaus tilaus) {
		
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizzantaytteet(tilausnro, pizzaid, laktoositon, gluteeniton, oregano) VALUES(?,?,?,?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			
			//täytetään lausekkeen VALUES() kohdat.
			lause.setInt(1, tilaus.getTilausnro());
			lause.setInt(2, tpizza.getPizza().getPizzaid());
			lause.setBoolean(3, tpizza.isLaktoositon());
			lause.setBoolean(4, tpizza.isGluteeniton());
			lause.setBoolean(5, tpizza.isOregano());
			
			// suoritetaan lause
			lause.executeUpdate();
			System.out.println("Lisättiin pizzaan: " + tpizza.getPizza().getPizzanimi() + " tilaukseen: " + tilaus.getTilausnro());
			
			System.out.println("Tilaukseen lisätty Pizza" + tpizza.getPizza().getPizzanimi() + "lisätty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("Pizzan lisäämisyritys aiheutti virheen pizzantäytevaiheessa!");
		}
	}
	
}
