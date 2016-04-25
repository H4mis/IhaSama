package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;
import java.text.ParseException;

import luokat.Pizza;
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
		SimpleDateFormat formatDateAndTime = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		
		if(tilaus.getTilausnro() > -1) {
			int tilausNro = tilaus.getTilausnro();
			
			//haetaan yksi tilaus tietokannasta ja palautetaan se valmiina Pizzaoliona
			String sql = "SELECT * FROM Tilaus WHERE tilausnro= '" + tilausNro + "';";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			ResultSet tulokset = lause.executeQuery();//haetaan tietokannasta tilausnro löytyvä Tilaus
			tulokset.next(); //mene ekalle riville
			
			if(tulokset.equals(null)) { //jos tilausta ei löydy tietokannasta palauta null
				return null;
			}
			
			//haetaan pizzan tiedot
			int tilausnro = tulokset.getInt("tilausnro");
			String tilaajatunnus = tulokset.getString("tilaajatunnus");
			String aika = tulokset.getString("tilausaika") + " " + tulokset.getString("tilausklo");
			java.util.Date tilausaika = new java.util.Date();
			try {
				tilausaika = formatDateAndTime.parse(aika);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int varausnro = tulokset.getInt("varausnro");
			boolean valmiina = tulokset.getBoolean("valmiina");
			boolean toimitettu = tulokset.getBoolean("toimitettu");
			String toimitustapa = tulokset.getString("toimitustapa");

			Tilaus tilaus1 = new Tilaus(tilausnro, tilaajatunnus, tilausaika, varausnro, valmiina, toimitettu, toimitustapa); //luodaan tilaus olio
			return tilaus1; //palautetaan pizza
		}
				
		return null; //tilausta ei löytynyt, palautetaan null	

	}
	
	public List<Tilaus> haeTilaukset(List<Pizza> pizzalista) throws NumberFormatException, SQLException {
		SimpleDateFormat formatDateAndTime = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		
		String sql = "SELECT pt.tilausnro, GROUP_CONCAT(p.pizzaid) as pizzaid, GROUP_CONCAT(t.tilaajatunnus) as Tilaajatunnus, GROUP_CONCAT(t.tilausaika) as tilausaika, GROUP_CONCAT(t.tilausklo) as tilausklo, GROUP_CONCAT(t.valmiina) as valmiina, GROUP_CONCAT(t.toimitettu) as toimitettu, GROUP_CONCAT(t.toimitustapa) as toimitustapa, pt.laktoositon, pt.gluteeniton, pt.oregano FROM Pizzatilaus pt LEFT JOIN Tilaus t ON pt.tilausnro = t.tilausnro LEFT JOIN Pizza p ON pt.pizzaid = p.pizzaid GROUP BY pt.tilausnro ORDER BY pt.tilausnro";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);		
		List<Tilaus>tilauxet = new ArrayList<Tilaus>();
		Pizza pizza = new Pizza();
		List<TilattuPizza> tilPizzat = new ArrayList<TilattuPizza>(); 
		while (tulokset.next()) {
			int tilausnro = tulokset.getInt("tilausnro");
			String tilaajatunnus = tulokset.getString("tilaajatunnus");
			String aika = tulokset.getString("tilausaika") + " " + tulokset.getString("tilausklo");
			java.util.Date tilausaika = new java.util.Date();
			try {
				tilausaika = formatDateAndTime.parse(aika);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			boolean valmiina = tulokset.getBoolean("valmiina");
			boolean toimitettu = tulokset.getBoolean("toimitettu");
			String toimitustapa = tulokset.getString("toimitustapa");		
			int pizzaid = tulokset.getInt("pizzaid");
			boolean oregano = tulokset.getBoolean("oregano");
			boolean laktoositon = tulokset.getBoolean("laktoositon");
			boolean gluteeniton = tulokset.getBoolean("gluteeniton");			
			for (int i = 0; i < pizzalista.size(); i++) {
				if(pizzalista.get(i).getPizzaid() == pizzaid){
					pizza = new Pizza(pizzalista.get(i).getPizzaid(), pizzalista.get(i).getPizzanimi(), pizzalista.get(i).getHinta(), pizzalista.get(i).getTaytteet(), pizzalista.get(i).isPiilossa());
				}
			
			}
			TilattuPizza tilPizza = new TilattuPizza(pizza, tilausnro, oregano, laktoositon, gluteeniton);
			tilPizzat.add(tilPizza);
			Tilaus tilaus = new Tilaus(tilausnro, tilaajatunnus, tilausaika, valmiina, toimitettu, toimitustapa, tilPizzat);
			tilauxet.add(tilaus);
		}			
		
		return tilauxet;
	}
	
	public Tilaus LisaaTilaus(Tilaus tilaus) {
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatTime = new SimpleDateFormat("hh:mm");
		System.out.println("ollaan LisaaTilaus()-metodissa tilaus sisältää: tilausnro=" + tilaus.getTilausnro() + ", valmiina=" + tilaus.isValmiina() + ", toimitettu=" + tilaus.isToimitettu() + ", toimitustapa=" + tilaus.getToimitustapa());
		System.out.println(tilaus.getTilausaika().toString());
		//String source = sdf.format(tilaus.getTilausaika());
		//TODO VIKA ON TÄÄLLÄ!
		java.util.Date aikaJava = new java.util.Date(); //luodaan java Date
		tilaus.setTilausaika(aikaJava);
		String tilausaika = formatDate.format(aikaJava);
		String tilausklo = formatTime.format(aikaJava);
		System.out.println("tilausaika: " + tilausaika + ", tilausklo: " + tilausklo);
		
		// TODO daten formatointi TAI IHAN VAAN SIMPPELI String tai jotainn..
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Tilaus (tilausaika, valmiina, toimitettu, toimitustapa, tilausklo) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);
			// täydennetään puuttuvat tiedot (eli käyttäjän tiedot)
			lause.setString(1, tilausaika);
			lause.setBoolean(2, tilaus.isValmiina());
			lause.setBoolean(3, tilaus.isToimitettu());
			lause.setString(4, tilaus.getToimitustapa());
			lause.setString(5,  tilausklo);
			System.out.println("testiiii");
			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			System.out.println("vaikutetutRowit: " + vaikutetutRowit);
			if (vaikutetutRowit == 0){
				throw new SQLException("Tilauksen luominen epäonnistui, kenttiä tyhjinä?");
			}
			System.out.println("palautettu sisältö: " + lause.getGeneratedKeys().toString());
			try (ResultSet generatedKeys = lause.getGeneratedKeys()) {
				
	            if (generatedKeys.next()) {
	                tilaus.setTilausnro(generatedKeys.getInt(1)); //tuodaan generoidut attribuutit
	                System.out.println("palautettiin tilaukselle tilausnro: " + tilaus.getTilausnro());
	                return tilaus;
	            }
	            else {
	                throw new SQLException("Tilauksen luominen epäonnistui, ei saatu tilausnroa");
	            }
			
			}
			
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Tilauksen lisäämisyritys aiheutti virheen lisäysvaiheessa!");
			System.out.println("tilausnro: " + tilaus.getTilausnro());
		}
		System.out.println("tilausnro: " + tilaus.getTilausnro());
		return tilaus;
	}
	
	public void LisaaPizzaTilaukseen(TilattuPizza tpizza, Tilaus tilaus) {
		System.out.println("Yritetï¿½ï¿½n lisï¿½tï¿½ pizzaid=" +tpizza.getPizza().getPizzaid() + " tilaukseen nro=" + tilaus.getTilausnro());
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizzantilaus(tilausnro, pizzaid, laktoositon, gluteeniton, oregano) VALUES(?,?,?,?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			
			//tï¿½ytetï¿½ï¿½n lausekkeen VALUES() kohdat.
			lause.setInt(1, tilaus.getTilausnro());
			lause.setInt(2, tpizza.getPizza().getPizzaid());
			lause.setBoolean(3, tpizza.isLaktoositon());
			lause.setBoolean(4, tpizza.isGluteeniton());
			lause.setBoolean(5, tpizza.isOregano());
			
			// suoritetaan lause
			lause.executeUpdate();
			System.out.println("Lisï¿½ttiin pizzaan: " + tpizza.getPizza().getPizzanimi() + " tilaukseen: " + tilaus.getTilausnro());
			
			System.out.println("Tilaukseen lisï¿½tty Pizza" + tpizza.getPizza().getPizzanimi() + "lisï¿½tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Tilauksen lisï¿½ï¿½misyritys aiheutti virheen LisaaPizzaTilaukseen() -vaiheessa!");
		}
	}
	
	public void muutaValmius(String[] valmisIdt, int valmis){
	    try {
	        String sql = "UPDATE Tilaus SET valmiina =" + valmis + " WHERE tilausnro =?";
	        PreparedStatement lause = yhteys.prepareStatement(sql); 
	            
	        for (String s : valmisIdt){
	            
	            lause.setInt(1,  Integer.parseInt(s));
	            lause.executeUpdate();
	            
	            System.out.println("Valmiin tiluaksen id: "+ s + " valmiutta muutettiin: " + valmis);
	        }
	    } catch (SQLException e) {
	        System.out.println("Tapahtui virhe tilauksen valmiuden muutossa!");
	        e.printStackTrace();
	    }
	}
	
	public void muutaToimitus(String[] toimiIdt, int toimitettu){
	    try {
	        String sql = "UPDATE Tilaus SET toimitettu =" + toimitettu + " WHERE tilausnro =?";
	        PreparedStatement lause = yhteys.prepareStatement(sql); 
	            
	        for (String s : toimiIdt){
	            
	            lause.setInt(1,  Integer.parseInt(s));
	            lause.executeUpdate();
	            
	            System.out.println("Valmiin tilauksen id: "+ s + " toimitustilaa muutettiin: " + toimitettu);
	        }
	    } catch (SQLException e) {
	        System.out.println("Tapahtui virhe tilauksen valmiuden muutossa!");
	        e.printStackTrace();
	    }
	}
	
}
