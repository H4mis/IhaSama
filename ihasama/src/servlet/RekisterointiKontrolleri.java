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
		String sahkoposti = request.getParameter("sähköposti");
		String kayttajatunnus = request.getParameter("käyttäjätunnus");
		String salasana = request.getParameter("salasana");
		
		if(etunimi.isEmpty()||sukunimi.isEmpty()||sahkoposti.isEmpty()||kayttajatunnus.isEmpty()||salasana.isEmpty())
		{
			RequestDispatcher rd = request.getRequestDispatcher("rekisterointi.jsp");
			out.println("<font color=red>Täytä kaikki kentät</font>");
			rd.include(request, response);
		}
		else
		{
			RequestDispatcher rd = request.getRequestDispatcher("asiakas.jsp");
			rd.forward(request, response);
		}
		
		if (kayttajatunnus != null && !kayttajatunnus.isEmpty()) {
			Kayttaja k = new Kayttaja(etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana);

			
			KayttajaDAO pDao = new KayttajaDAO();
			pDao.avaaYhteys();
			pDao.lisaaKayttaja(k);
			pDao.suljeYhteys();
			response.sendRedirect("Kontrolleri?registrationSuccess=true");
		}
	}
}
