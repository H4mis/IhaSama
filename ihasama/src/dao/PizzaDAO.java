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
	Connection yhteys = null;

	public void avaaYhteys() {
		// K‰ytt‰j‰tiedot ja DB:n osoite - lis‰‰ puuttuvat tiedot!
		String username = "a1500925";
		String password = "nySUxd46r";
		String url = "jdbc:mariadb://localhost/a1500925";

		try {
			// Yhdistet‰‰n tietokantaan
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
			System.out.println("Tietokantayhteys ei jostain syyst√§ suostu menem√§√§n kiinni.");
			e.printStackTrace();
		}
	}

	public List<Pizza> haePizzat() throws NumberFormatException, SQLException {
		String sql = "SELECT * FROM Pizza";
		Statement haku = yhteys.createStatement();
		ResultSet tulokset = haku.executeQuery(sql);

		while (tulokset.next()) {
			int id = tulokset.getInt("pizzaid");
			String nimi = tulokset.getString("pizzanimi");
			double hinta = tulokset.getDouble("hinta");
			// lis‰t‰‰n pizza listaan
			Pizza pizza = new Pizza(id, nimi, hinta);
			pizzalista.add(pizza);
		}

		return pizzalista;

	}

	public void lisaaPizza(Pizza p) {
		

		try {
			// alustetaan sql-lause
			String sql = "INSERT INTO Pizza(pizzanimi, hinta) VALUES(?,?)";
			PreparedStatement lause = yhteys.prepareStatement(sql);

			// t‰ydennet‰‰n puuttuvat tiedot (eli pizzan nimi ja hinta)			
			lause.setString(1, p.getPizzanimi());
			lause.setDouble(2, p.getHinta());

			// suoritetaan lause
			lause.executeUpdate();

			System.out.println("Pizza" + p + "lis‰tty tietokantaan");
		} catch (Exception e) {
			// Tapahtui jokin virhe
			System.out.println("Pizzan lis‰‰misyritys aiheutti virheen!");
		} 

	}

}
