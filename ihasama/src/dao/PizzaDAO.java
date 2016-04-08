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
import luokat.Tayte;



public class PizzaDAO {

	// Tietokanta-ajurin lataus siirretty constructoriin

	public PizzaDAO() {

		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (java.lang.ClassNotFoundException ex) {
			System.out.print("ClassNotFoundException: ");
			System.out.println(ex.getMessage());
		}
	}

	public ArrayList<Pizza> pizzalista = new ArrayList<Pizza>();
	public ArrayList<Tayte> taytelista = new ArrayList<Tayte>();
	Connection yhteys = null;

	public void avaaYhteys() {
		// K�ytt�j�tiedot ja DB:n osoite - lis�� puuttuvat tiedot!
		String username = "a1500925";
		String password = "syKA4t68r";
		String url = "jdbc:mariadb://localhost/a1500925?useUnicode=true&characterEncoding=utf-8";

		try {
			// Yhdistet��n tietokantaan
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
			System.out.println("Tietokantayhteys ei jostain syystä suostu menemään kiinni.");
			e.printStackTrace();
		}
	}

	public List<Pizza> haePizzat() throws NumberFormatException, SQLException {
		String sql = "SELECT p.pizzaid, p.pizzanimi, p.hinta, GROUP_CONCAT(t.tayteid) as tayteidt, GROUP_CONCAT(t.taytenimi) as taytenimet FROM Pizza p LEFT JOIN Pizzantaytteet pt ON p.pizzaid = pt.pizzaid LEFT JOIN Tayte t ON t.tayteid = pt.tayteid GROUP BY p.pizzanimi order by pizzanimi, null";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);

		while (tulokset.next()) {
			int id = tulokset.getInt("pizzaid");
			String nimi = tulokset.getString("pizzanimi");
			double hinta = tulokset.getDouble("hinta");
			String taytteet = tulokset.getString("taytenimet");
			// lis�t��n pizza listaan
			Pizza pizza = new Pizza(id, nimi, hinta, taytteet);
			pizzalista.add(pizza);
		}

		return pizzalista;

	}
	
	public List<Tayte> haeTaytteet() throws NumberFormatException, SQLException {
		String sql = "SELECT * FROM Tayte ORDER BY taytenimi";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);

		while (tulokset.next()) {
			int tayteid = tulokset.getInt("tayteid");
			String taytenimi = tulokset.getString("taytenimi");
			boolean saatavilla = tulokset.getBoolean("saatavilla");
			// lis�t��n pizza listaan
			Tayte tayte = new Tayte(tayteid, taytenimi, saatavilla);
			taytelista.add(tayte);
		}

		return taytelista;

	}

	public void lisaaPizza(Pizza p) {

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizza(pizzanimi, hinta) VALUES(?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// t�ydennet��n puuttuvat tiedot (eli pizzan nimi ja hinta)
			lause.setString(1, p.getPizzanimi());
			lause.setDouble(2, p.getHinta());

			// suoritetaan lause
			
			int vaikutetutrowit = lause.executeUpdate();
			
			if (vaikutetutrowit == 0){
				throw new SQLException("Pizzan luominen epäonnistui, mihinkään rowiin ei tullut mitään");
			}
			try (ResultSet generatedKeys = lause.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                p.setPizzaid(generatedKeys.getInt(1));
	            }
	            else {
	                throw new SQLException("Pizzan luominen epäonnistui, ei saatu ID:tä");
	            }
			
			}
			System.out.println("Pizza" + p + "lisätty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("Pizzan lisäämisyritys aiheutti virheen pizzanlisaysvaiheessa!");
		}
		
	}
	
	public void lisaaTayte(Tayte t) {

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Tayte(taytenimi, saatavilla) VALUES(?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql);

			// t�ydennet��n puuttuvat tiedot (eli pizzan nimi ja hinta)
			lause.setString(1, t.getTaytenimi());
			lause.setBoolean(2, t.isSaatavilla());

			// suoritetaan lause
			lause.executeUpdate();

			
			System.out.println("Tayte" + t.getTaytenimi() + "lis�tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("T�ytteen lis��misyritys aiheutti virheen t�ytteenlisaysvaiheessa!");
		}
		
	}

	public void lisaaPizzantaytteet(Pizza a, String[] taytteidenIdt) {
		// T�� TEHD��N LOPPUUN KUN SAADAN ARRAYLISTIT TOIMIMAAN
		// heheh

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizzantaytteet(pizzaid, tayteid) VALUES(?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql);

			for (String s : taytteidenIdt) {

				System.out.println("toimii for-loopin alussa");
				// t�ydennet��n puuttuvat tiedot (eli pizzan nimi ja hinta)
				lause.setInt(1, a.getPizzaid());
				lause.setInt(2, Integer.parseInt(s));
				System.out.println("toimi kun lis�ttiin lauseeseen juttuja");
				// suoritetaan lause
				lause.executeUpdate();
				System.out.println("Toimi kun teloitettiin update");
			}
			System.out.println("Pizza" + a + "lis�tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("Pizzan lis��misyritys aiheutti virheen pizzantaytevaiheessa!");
		}
	}

	public void poistaPizza(String[] poistop) {
		
		
		try {
			String sql = "DELETE FROM Pizza WHERE pizzaid=?";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			for (String s : poistop){
				lause.setInt(1, Integer.parseInt(s));
				lause.executeUpdate();
				System.out.println("Pizza id: "+ s + " poistettiin listalta.");
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe poistossa!");
			e.printStackTrace();
		}
		
		
		
	}

	public void poistaTayte(String[] poistot) {
		try {
			String sql = "DELETE FROM Tayte WHERE tayteid=?";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			for (String s : poistot){
				lause.setInt(1, Integer.parseInt(s));
				lause.executeUpdate();
				System.out.println("Tayte id: "+ s + " poistettiin listalta.");
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe poistossa!");
			e.printStackTrace();
		}
	}
public void muutaSaatavuus(String[] tayteIdt, int saatavilla){
			
			try {
				String sql = "UPDATE Tayte SET saatavilla ="+saatavilla +" WHERE tayteid =?";
				PreparedStatement lause = yhteys.prepareStatement(sql);	
					
				for (String s : tayteIdt){
					
					lause.setInt(1,  Integer.parseInt(s));
					
					lause.executeUpdate();
					
					
					System.out.println("Tayte id: "+ s + " saatavuutta muutettiin");
				
					
				}
			} catch (SQLException e) {
			    System.out.println("Tapahtui virhe muuttamisessa!");
				e.printStackTrace();
			}}
			
			
		
	}
