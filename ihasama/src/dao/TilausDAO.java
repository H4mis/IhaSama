package dao;

import java.sql.Connection;
import java.sql.Date;
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
			Date tilausaika = tulokset.getDate("tilausaika");
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
		String sql = "SELECT pt.tilausnro, GROUP_CONCAT(p.pizzaid) as pizzaid, GROUP_CONCAT(t.tilaajatunnus) as Tilaajatunnus, GROUP_CONCAT(t.tilausaika) as tilausaika, GROUP_CONCAT(t.valmiina) as valmiina, GROUP_CONCAT(t.toimitettu) as toimitettu, GROUP_CONCAT(t.toimitustapa) as toimitustapa, pt.laktoositon, pt.gluteeniton, pt.oregano FROM Pizzatilaus pt LEFT JOIN Tilaus t ON pt.tilausnro = t.tilausnro LEFT JOIN Pizza p ON pt.pizzaid = p.pizzaid GROUP BY pt.tilausnro ORDER BY pt.tilausnro";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);		
		List<Tilaus>tilauxet = new ArrayList<Tilaus>();
		Pizza pizza = new Pizza();
		List<TilattuPizza> tilPizzat = new ArrayList<TilattuPizza>(); 
		while (tulokset.next()) {
			int tilausnro = tulokset.getInt("tilausnro");
			String tilaajatunnus = tulokset.getString("tilaajatunnus");
			Date tilausaika = tulokset.getDate("tilausaika");
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
	
	public void LisaaTilaus(Tilaus tilaus) {
		System.out.println("ollaan LisaaTilaus()-metodissa tilaus sisältää: tilausnro=" + tilaus.getTilausnro() + ", valmiina=" + tilaus.isValmiina() + ", toimitettu=" + tilaus.isToimitettu() + ", toimitustapa=" + tilaus.getToimitustapa());
		System.out.println(tilaus.getTilausaika().toString());
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		//String source = sdf.format(tilaus.getTilausaika());
		//TODO VIKA ON TÄÄLLÄ!
		java.sql.Date aika = new java.sql.Date(0l);
		try {
			aika = new java.sql.Date(sdf.parse(tilaus.getTilausaika().toString()).getTime());
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println(aika.toString());
		// TODO daten formatointi TAI IHAN VAAN SIMPPELI String tai jotainn..
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Tilaus (tilausaika, valmiina, toimitettu, toimitustapa) VALUES (?, ?, ?, ?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// täydennetään puuttuvat tiedot (eli käyttäjän tiedot)
			lause.setDate(1, aika);
			lause.setBoolean(2, tilaus.isValmiina());
			lause.setBoolean(3, tilaus.isToimitettu());
			lause.setString(4, tilaus.getToimitustapa());
			
			// suoritetaan lause
			int vaikutetutRowit = lause.executeUpdate();
			
			if (vaikutetutRowit == 0){
				throw new SQLException("Tilauksen luominen epäonnistui, kenttiä tyhjinä?");
			}
			try (ResultSet generatedKeys = lause.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                tilaus.setTilausnro(generatedKeys.getInt(1)); //tuodaan generoidut attribuutit
	            }
	            else {
	                throw new SQLException("Tilauksen luominen epäonnistui, ei saatu tilausnroa");
	            }
			
			}
			
			System.out.println("Tilaus " + tilaus.getTilausnro() + " lisätty tietokantaan.");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Tilauksen lisäämisyritys aiheutti virheen lisäysvaiheessa!");
			System.out.println(tilaus.toString());
		}
	}
	
	public void LisaaPizzaTilaukseen(TilattuPizza tpizza, Tilaus tilaus) {
		System.out.println("Yritetään lisätä pizzaid=" +tpizza.getPizza().getPizzaid() + " tilaukseen nro=" + tilaus.getTilausnro());
		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizzantilaus(tilausnro, pizzaid, laktoositon, gluteeniton, oregano) VALUES(?,?,?,?,?)";
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
			System.out.println("Tilauksen lisäämisyritys aiheutti virheen LisaaPizzaTilaukseen() -vaiheessa!");
		}
	}
	
}
