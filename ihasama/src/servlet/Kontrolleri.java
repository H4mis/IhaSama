package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import luokat.Pizza;
import luokat.Tayte;
import dao.PizzaDAO;

/**
 * Servlet implementation class Kontrolleri
 */
@WebServlet("/Kontrolleri")
public class Kontrolleri extends HttpServlet {

	// lis�t��n decimal formatti ett� n�kyy nolla hinnan per�ss�
	DecimalFormat f = new DecimalFormat("0.00");

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Kontrolleri() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// Luodaan oliolista tietokannan tiedoista

		PizzaDAO pDAO = new PizzaDAO();
		pDAO.avaaYhteys();
		List<Pizza> lista;
		List<Tayte> lista2;
		try {
			lista = pDAO.haePizzat();
			request.setAttribute("pizzalista", lista);

			lista2 = pDAO.haeTaytteet();

			request.setAttribute("taytelista", lista2);

		} catch (NumberFormatException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			pDAO.suljeYhteys();
		}

		// Pistet��n tieto eteenp�in list.jsp:lle

		RequestDispatcher disp = request.getRequestDispatcher("list.jsp");
		disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// luodaan pizzalista
		List<Pizza> lista = new ArrayList<Pizza>();
		String taytteet = "hahaa";
		// haetaan parametrit k�ytt�j�lt�(submitista) ja lis�t��n nelopuksi
		// pizza-olioon
		String nimi = request.getParameter("nimi");
		String tnimi = request.getParameter("taytenimi");
		String[] poistop = request.getParameterValues("poistopizza");
		String[] poistot = request.getParameterValues("poistotayte");
		
		
		if(poistop != null && !poistop.equals(null)){
			PizzaDAO pDao = new PizzaDAO();
			pDao.avaaYhteys();
			pDao.poistaPizza(poistop);
			response.sendRedirect("Kontrolleri?removed=true");
			
		}
		
		if(poistot != null && !poistot.equals(null)){
			PizzaDAO pDao = new PizzaDAO();
			pDao.avaaYhteys();
			pDao.poistaTayte(poistot);
			response.sendRedirect("Kontrolleri?removed=true");
			
		}
		
		if (nimi != null && !nimi.isEmpty()) {
			double hinta = Double.parseDouble(request.getParameter("hinta"));
			int id = lista.size() + 1;
			String[] taytteidenIdt = request.getParameterValues("taytteet");
			// taytteet = taytteidenIdt.length;

			Pizza a = new Pizza(id, nimi, hinta, taytteet);

			// lis�t��n pizza-olio tietokantaan PizzaDAO-java luokan avulla.
			PizzaDAO pDao = new PizzaDAO();
			pDao.avaaYhteys();
			pDao.lisaaPizza(a);
			pDao.lisaaPizzantaytteet(a, taytteidenIdt);
			pDao.suljeYhteys();

			response.setContentType("text/html");
			// java.io.PrintWriter wout = response.getWriter();
			System.out.println("T�ytteet:" + a.getTaytteet());
			System.out.println("<b>Nimi:</b> " + a.getPizzanimi());
			System.out.println("<br>");
			System.out.println("<b>Hinta:</b> " + f.format(a.getHinta()));

			// ohjataan takaisin alkuun
			response.sendRedirect("Kontrolleri?added=true");
		}
		if (tnimi != null && !tnimi.isEmpty()) {
			Tayte t = new Tayte(1, tnimi, true);
			PizzaDAO pDao = new PizzaDAO();
			pDao.avaaYhteys();
			pDao.lisaaTayte(t);
			pDao.suljeYhteys();
			response.sendRedirect("Kontrolleri?added=true");
		}

	}

}
