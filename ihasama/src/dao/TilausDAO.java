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
	
	public Tilaus haeTilaus(Tilaus tilaus) throws SQLException {
		SimpleDateFormat formatDateAndTime = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		
		if(tilaus.getTilausnro() > -1) {
			int tilausNro = tilaus.getTilausnro();
			
			//haetaan yksi tilaus tietokannasta ja palautetaan se valmiina Pizzaoliona
			String sql = "SELECT * FROM Tilaus WHERE tilausnro= '" + tilausNro + "';";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			ResultSet tulokset = lause.executeQuery();//haetaan tietokannasta tilausnro l�ytyv� Tilaus
			tulokset.next(); //mene ekalle riville
			
			if(tulokset.equals(null)) { //jos tilausta ei l�ydy tietokannasta palauta null
				return null;
			}
			
			//haetaan pizzan tiedot
			int tilausnro = tulokset.getInt("tilausnro");
			String tilaajatunnus = tulokset.getString("tilaajatunnus");
			String aika = tulokset.getString("tilausaika") + " " + tulokset.getString("tilausklo");
			java.util.Date tilausaika = new java.util.Date();
			try {
				tilausaika = formatDateAndTime.parse(aika); //TODO T�M� EI KAI TOIMI?
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
				
		return null; //tilausta ei l�ytynyt, palautetaan null	

	}
	
	public List<Tilaus> haeTilaukset(List<Pizza> pizzalista) throws NumberFormatException, SQLException {
		SimpleDateFormat formatDateAndTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		String sql = "SELECT pt.pizzatilausid, pt.tilausnro, (p.pizzaid) as pizzaid, (p.pizzanimi) as pizzanimi, (t.tilaajatunnus) as Tilaajatunnus, (t.tilausaika) as tilausaika, (t.tilausklo) as tilausklo, (t.valmiina) as valmiina, (t.toimitettu) as toimitettu, (t.toimitustapa) as toimitustapa, pt.laktoositon, pt.gluteeniton, pt.oregano FROM Pizzatilaus pt  LEFT JOIN Tilaus t ON pt.tilausnro = t.tilausnro LEFT JOIN Pizza p ON pt.pizzaid = p.pizzaid GROUP BY pt.pizzatilausid ORDER BY pt.tilausnro";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);		
		List<Tilaus>tilauxet = new ArrayList<Tilaus>();
		Pizza pizza = new Pizza();
		List<TilattuPizza> tilPizzat = new ArrayList<TilattuPizza>(); 
		HashMap<Integer,Integer> pizzantilausAvuste = new HashMap<Integer,Integer>();
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
			int pizzatilausId = tulokset.getInt("pizzatilausid");			
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
			TilattuPizza tilPizza = new TilattuPizza(pizza, pizzatilausId, pizzaid, tilausnro, oregano, laktoositon, gluteeniton);
			tilPizzat.add(tilPizza);
			System.out.println("Pizzan nimi tilauslistalla on " + pizzaid);
			System.out.println("Pizzan tilausid on " +pizzatilausId);			
					
			pizzantilausAvuste.put(pizzatilausId, pizzaid);			
			Tilaus tilaus = new Tilaus(tilausnro, tilaajatunnus, tilausaika, valmiina, toimitettu, toimitustapa, tilPizzat, pizzantilausAvuste);
			tilauxet.add(tilaus);
		}			
		
		return tilauxet;
	}
	
	public Tilaus LisaaTilaus(Tilaus tilaus) {
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
		System.out.println("ollaan LisaaTilaus()-metodissa tilaus sis�lt��: tilausnro=" + tilaus.getTilausnro() + ", valmiina=" + tilaus.isValmiina() + ", toimitettu=" + tilaus.isToimitettu() + ", toimitustapa=" + tilaus.getToimitustapa());
		System.out.println(tilaus.getTilausaika().toString());

		java.util.Date aikaJava = tilaus.getTilausaika();
		String tilausaika = formatDate.format(aikaJava);
		String tilausklo = formatTime.format(aikaJava);
		System.out.println("LisaaTilaus(): tilausaika: " + tilausaika + ", tilausklo: " + tilausklo);

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Tilaus(tilausaika, valmiina, toimitettu, toimitustapa, tilausklo) VALUES(?, ?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);
			// t�ydennet��n puuttuvat tiedot (eli k�ytt�j�n tiedot)
			lause.setString(1, tilausaika);
			lause.setBoolean(2, tilaus.isValmiina());
			lause.setBoolean(3, tilaus.isToimitettu());
			lause.setString(4, tilaus.getToimitustapa());
			lause.setString(5, tilausklo);
			System.out.println("testiiii");
			
			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate(); //T�M� EI TOIMI?
			System.out.println("execute update toimii jos t�m� teksti n�kyy!");
			
			System.out.println("vaikutetutRowit: " + vaikutetutRowit);
			if (vaikutetutRowit == 0){
				throw new SQLException("Tilauksen luominen ep�onnistui, kentti� tyhjin�?");
			}
			
			System.out.println("palautettu sis�lt�: " + lause.getGeneratedKeys().toString());
			try (ResultSet generatedKeys = lause.getGeneratedKeys()) {
				
	            if (generatedKeys.next()) {
	                tilaus.setTilausnro(generatedKeys.getInt("tilausnro")); //tuodaan generoidut attribuutit
	                System.out.println("palautettiin tilaukselle tilausnro: " + tilaus.getTilausnro());
	                return tilaus;
	            }
	            else {
	                throw new SQLException("Tilauksen luominen ep�onnistui, ei saatu tilausnroa");
	            }
			}
			
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Tilauksen lis��misyritys aiheutti virheen lis�ysvaiheessa!");
			System.out.println("tilausnro: " + tilaus.getTilausnro());
		}
		System.out.println("palautetaan tilaus kontrolleriin, tilausnro: " + tilaus.getTilausnro());
		return tilaus;
	}
	
	public void LisaaPizzaTilaukseen(TilattuPizza tpizza, Tilaus tilaus) {
		System.out.println("Yritet��n lis�t� pizzaid=" +tpizza.getPizza().getPizzaid() + " tilaukseen nro=" + tilaus.getTilausnro());
		System.out.println("tilausnro: " + tilaus.getTilausnro() + ", pizzaid: " + tpizza.getPizza().getPizzaid() + ", laktoositon: " + tpizza.isLaktoositon() + ", gluteeniton: " + tpizza.isGluteeniton() + ", oregano: " + tpizza.isOregano());
		
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizzatilaus(tilausnro, pizzaid, laktoositon, gluteeniton, oregano) VALUES(?,?,?,?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			
			//t�ytet��n lausekkeen VALUES() kohdat.
			lause.setInt(1, tilaus.getTilausnro());
			lause.setInt(2, tpizza.getPizza().getPizzaid());
			lause.setBoolean(3, tpizza.isLaktoositon());
			lause.setBoolean(4, tpizza.isGluteeniton());
			lause.setBoolean(5, tpizza.isOregano());
			
			// suoritetaan lause
			lause.executeUpdate();
			System.out.println("Lis�ttiin pizzaan: " + tpizza.getPizza().getPizzanimi() + " tilaukseen: " + tilaus.getTilausnro());
			
			System.out.println("Tilaukseen lis�tty Pizza" + tpizza.getPizza().getPizzanimi() + "lis�tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Tilauksen lis��misyritys aiheutti virheen LisaaPizzaTilaukseen() -vaiheessa!");
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
