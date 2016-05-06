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
import luokat.TilattuPizza;

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

public Pizza haePizza(String pizzaid) throws SQLException {
		
		String pizza = pizzaid;
		int parsepizzaid = -1;
		List<Pizza> pizzalista = haePizzat(); //haetaan kaikki pizzat pizzalistaan
		if(pizza != null) {
			parsepizzaid = Integer.parseInt(pizza);
			System.out.println("parsetettiin koska ei ollut null, pizzaid=" +pizzaid);
		}
		
		for(int i = 0; i < pizzalista.size(); i++){ //k�yd��n l�pi haettu pizzalista
			if(pizzalista.get(i).getPizzaid() == parsepizzaid) { //jos pizzaid:ll� l�ytyi vastaava
				System.out.println("Pizza pizzaid:ll� " + pizzaid + " l�ytyi pizzalistalta!");
				return pizzalista.get(i); //palautetaan se pizzana takaisin.
			}
		}
		System.out.println("pizzaa ei l�ytynyt listalta!");
		return null; //jos lista k�ytiin l�pi ja siell� ei ollut kyseist� pizzaa palautetaan null!
	}
	
	public List<Pizza> haePizzat() throws NumberFormatException, SQLException {
		String sql = "SELECT p.pizzaid, p.pizzanimi, p.hinta, p.piilossa, GROUP_CONCAT(t.tayteid) as tayteidt, GROUP_CONCAT(t.taytenimi) as taytenimet FROM Pizza p LEFT JOIN Pizzantaytteet pt ON p.pizzaid = pt.pizzaid LEFT JOIN Tayte t ON t.tayteid = pt.tayteid GROUP BY p.pizzanimi order by pizzanimi, null";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);

		while (tulokset.next()) {
			int id = tulokset.getInt("pizzaid");
			String nimi = tulokset.getString("pizzanimi");
			double hinta = tulokset.getDouble("hinta");
			String taytteet = tulokset.getString("taytenimet");
			// lis�t��n pizza listaan
			boolean piilossa = tulokset.getBoolean("piilossa");
			Pizza pizza = new Pizza(id, nimi, hinta, taytteet, piilossa);
			pizzalista.add(pizza);
			System.out.println("Tietokannasta haettu pizza: " + pizza.getPizzanimi());
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
			System.out.println("Tietokannasta haettu t�yte: " + tayte.getTaytenimi());
		}

		return taytelista;

	}

	public void lisaaPizza(Pizza p) {

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizza(pizzanimi, hinta, piilossa) VALUES(?,?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS);

			// täydennetään puuttuvat tiedot (eli pizzan nimi ja hinta)
			lause.setString(1, p.getPizzanimi());
			lause.setDouble(2, p.getHinta());
			lause.setBoolean(3, p.isPiilossa());
			
			// suoritetaan lause
			
			int vaikutetutrowit = lause.executeUpdate();
			
			if (vaikutetutrowit == 0){
				throw new SQLException("Pizzan luominen ep�nnistui, mihink��n rowiin ei tullut mit��n");
			}
			try (ResultSet generatedKeys = lause.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                p.setPizzaid(generatedKeys.getInt(1));
	            }
	            else {
	                throw new SQLException("Pizzan luominen ep�onnistui, ei saatu ID:t�");
	            }
			
			}
			System.out.println("Pizza" + p.getPizzanimi() + "lis�tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("Pizzan lis��misyritys aiheutti virheen pizzanlis�ysvaiheessa!");
		}
		
	}
	
	public double LaskeYhteishinta(List<TilattuPizza> kori) { //laskee tilattujen pizzojen yhteishinnan ja palauttaa sen.
		double yhteishinta = 0;
		for(int i = 0; i < kori.size(); i++) {
			yhteishinta += kori.get(i).getPizza().getHinta();
		}
		return yhteishinta;
	}
	
	public List<Pizza> haeAsiakasPizzat(List<Pizza> pizzalista) throws NumberFormatException, SQLException {
        String sql = "SELECT p.pizzaid, p.pizzanimi, p.hinta, GROUP_CONCAT(t.tayteid) as tayteidt, GROUP_CONCAT(t.taytenimi) as taytenimet FROM Pizza p  LEFT JOIN Pizzantaytteet pt ON pt.pizzaid = p.pizzaid  LEFT JOIN Tayte t ON t.tayteid = pt.tayteid  WHERE pt.pizzaid = p.pizzaid and t.saatavilla IS FALSE GROUP BY p.pizzanimi order by pizzanimi";
        Statement haku = yhteys.createStatement();
        ResultSet tulokset = haku.executeQuery(sql);
        while (tulokset.next()) {
            int id = tulokset.getInt("pizzaid");
            
            // k�yd��n l�pi listalta pizzat          
            for (int i = 0; i < pizzalista.size(); i++) {
                if(pizzalista.get(i).getPizzaid() == id){
                    pizzalista.remove(i); //poistetaan menulistasta pizzat joissa on t�yte joka ei ole saatavilla.
                }
            }   
        }
        //toinen luuppi testataan, jos pizza on piilotus listalla, poistetaan se menu-listalta.
        for(int i = 0; i <pizzalista.size(); i++) {
        	if(pizzalista.get(i).isPiilossa() == true) {
        		pizzalista.remove(i);
        	}
        }
        
        System.out.println("Luotu asiakkaille menu!");
        return pizzalista;
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
					.println("T�ytteen lis��misyritys aiheutti virheen t�ytteenlis�ysvaiheessa!");
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
				lause.setInt(1, a.getPizzaid());
				lause.setInt(2, Integer.parseInt(s));
				// suoritetaan lause
				lause.executeUpdate();
				System.out.println("Lis�ttiin pizzaan: " + a.getPizzanimi() + " t�yte: " + s);
			}
			System.out.println("Pizza" + a.getPizzanimi() + "lis�tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out
					.println("Pizzan lis��misyritys aiheutti virheen pizzant�ytevaiheessa!");
		}
	}

	public void poistaPizza(String[] poistop) {
			
		try {
			String sql = "DELETE FROM Pizza WHERE pizzaid=?";
			PreparedStatement lause = yhteys.prepareStatement(sql);
			for (String s : poistop){
				lause.setInt(1, Integer.parseInt(s));
				lause.executeUpdate();
				System.out.println("Pizza id: "+ s + " poistettiin pizzalistalta.");
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe pizzan poistossa!");
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
				System.out.println("Tayte id: "+ s + " poistettiin t�ytelistalta.");
			}
		} catch (SQLException e) {
		    System.out.println("Tapahtui virhe t�ytteen poistossa!");
			e.printStackTrace();
		}
	}
	
	public void muutaPiilotus(String[] pizzaIDt, int piilossa){
	    try {
	        String sql = "UPDATE Pizza SET piilossa =" + piilossa + " WHERE pizzaid =?";
	        PreparedStatement lause = yhteys.prepareStatement(sql); 
	            
	        for (String s : pizzaIDt){
	            
	            lause.setInt(1,  Integer.parseInt(s));
	            lause.executeUpdate();
	            
	            System.out.println("Pizzaid id: "+ s + " piiloisuutta muutettiin: " + piilossa);
	        }
	    } catch (SQLException e) {
	        System.out.println("Tapahtui virhe pizzan piilotuksen muutossa!");
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

					System.out.println("Tayte id: "+ s + " saatavuutta muutettiin: " + saatavilla);
				}
			} catch (SQLException e) {
			    System.out.println("Tapahtui virhe muuttamisessa!");
				e.printStackTrace();
			}
	}

}
