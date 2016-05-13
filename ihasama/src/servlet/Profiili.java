package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import luokat.Kayttaja;
import dao.KayttajaDAO;
import dao.TietojenMuokkausDAO;

/**
 * Servlet implementation class Profiili
 */
@WebServlet("/Profiili")
public class Profiili extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Profiili() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		KayttajaDAO kaDao = new KayttajaDAO();
		HttpSession sessio = request.getSession(false);
		Kayttaja kayttaja = new Kayttaja();
		
		if(sessio != null && sessio.getAttribute("kayttajatunnus") != null) {
			System.out.println("loydettiin kayttajatunnus doGetissa");
			String kayttajatunnus = (String) sessio.getAttribute("kayttajatunnus");
			kaDao.avaaYhteys();
			try {
				kayttaja = kaDao.HaeKayttaja(kayttajatunnus);
				request.setAttribute("osoite", kayttaja.getOsoite());
				request.setAttribute("postinro", kayttaja.getPostinro());
				request.setAttribute("postitmp", kayttaja.getPostitmp());
				request.setAttribute("etunimi", kayttaja.getEtunimi());
				request.setAttribute("sukunimi", kayttaja.getSukunimi());
				request.setAttribute("sahkoposti", kayttaja.getSahkoposti());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			kaDao.suljeYhteys();
		}
		RequestDispatcher disp = request.getRequestDispatcher("profiili.jsp");
		disp.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String toiminto = request.getParameter("toiminto");
		TietojenMuokkausDAO TMDao =  new TietojenMuokkausDAO();
		HttpSession sessio = request.getSession(false);
		
		if(toiminto != null && toiminto.equals("muutaTietoja")) {
			String kayttajatunnus = (String) sessio.getAttribute("kayttajatunnus");
			String etunimi  = request.getParameter("etunimi");
			String sukunimi  = request.getParameter("sukunimi");
			String sahkoposti  = request.getParameter("sahkoposti");
			String osoite  = request.getParameter("osoite");
			String postinro  = request.getParameter("postinro");
			String postitmp  = request.getParameter("postitmp");
			System.out.println("postinumero on: "+postinro);
			Kayttaja kayttaja = new Kayttaja(etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, postitmp);
			
			TMDao.avaaYhteys();
			
			TMDao.muokkaaTietoja(kayttaja);
			
			TMDao.suljeYhteys();
			
			response.sendRedirect("Profiili?changedProfile=true");
		}
	}

}
