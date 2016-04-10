package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.KayttajaDAO;
import luokat.Kayttaja;

/**
 * Servlet implementation class UserDataServlet
 */
@WebServlet("/RekisterointiKontrolleri")
public class RekisterointiKontrolleri extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// haetaan responsesta tiedot asiakkaan rekister�innist�
		response.setContentType("text/html");
		String etunimi = request.getParameter("etunimi");
		String sukunimi = request.getParameter("sukunimi");
		String sahkoposti = request.getParameter("sahkoposti");
		String kayttajatunnus = request.getParameter("kayttajatunnus");
		String salasana = request.getParameter("salasana");
		
		System.out.println("Response palautti tiedot: etunimi: " + etunimi + ", sukunimi: " + sukunimi + ", s�hk�posti: " + sahkoposti + ", k�ytt�j�tunnus: " + kayttajatunnus + ", salasana: " + salasana);
		
		
		//TODO: chekkaa my�s ett� k�ytt�j�tunnus ei ole olemassa jo!
		
		if(etunimi.isEmpty()||sukunimi.isEmpty()||sahkoposti.isEmpty()||kayttajatunnus.isEmpty()||salasana.isEmpty())
		{
			response.sendRedirect("rekisterointi.jsp?registrationNoSuccess=true");
			RequestDispatcher rd = request.getRequestDispatcher("rekisterointi.jsp");
			rd.include(request, response);
		}
		else
		{
			//luodaan k�ytt�j�
			Kayttaja k = new Kayttaja(etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana);

			KayttajaDAO kDao = new KayttajaDAO();
			
			
			try {
				kDao.avaaYhteys();
				if(kDao.onkoKayttajatunnusOlemassa(k) == false) { //tarkistetaan onko k�ytt�j� jo olemassa
					kDao.lisaaKayttaja(k); //Lis�t��n k�ytt�j� tietokantaan
					kDao.suljeYhteys();
					response.sendRedirect("rekisterointi.jsp?registrationSuccess=true");
				}
				else { //k�ytt�j� on jo olemassa!
					kDao.suljeYhteys();
					response.sendRedirect("rekisterointi.jsp?userExists=true");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("joku errori SQL:ss�");
				e.printStackTrace();
			}
		}
	}
}
