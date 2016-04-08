package servlet;

import java.io.IOException;
import java.io.PrintWriter;

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
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String etunimi = request.getParameter("etunimi");
		String sukunimi = request.getParameter("sukunimi");
		String sahkoposti = request.getParameter("sahkoposti");
		String kayttajatunnus = request.getParameter("kayttajatunnus");
		String salasana = request.getParameter("salasana");
		
		System.out.println("etunimi: " + etunimi + " sukunimi: " + sukunimi + " sähköposti: " + sahkoposti + " käyttäjätunnus: " + kayttajatunnus + " salasana: " + salasana);
		
		if(etunimi.isEmpty()||sukunimi.isEmpty()||sahkoposti.isEmpty()||kayttajatunnus.isEmpty()||salasana.isEmpty())
		{
			RequestDispatcher rd = request.getRequestDispatcher("rekisterointi.jsp");
			response.sendRedirect("RekisterointiKontrolleri?registrationNoSuccess=true");
			rd.include(request, response);
		}
		else
		{
			//luodaan käyttäjä
			Kayttaja k = new Kayttaja(etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana);

			KayttajaDAO kDao = new KayttajaDAO();
			kDao.avaaYhteys();
			kDao.lisaaKayttaja(k);
			kDao.suljeYhteys();
			//response.sendRedirect("RekisterointiKontrolleri?registrationSuccess=true");
			
			//ohjataan sivulle asiakas.jsp
			RequestDispatcher rd = request.getRequestDispatcher("asiakas.jsp");
			rd.forward(request, response);
		}
	}
}
