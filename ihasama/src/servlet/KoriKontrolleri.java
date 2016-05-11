package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.KoriDAO;
import dao.PizzaDAO;
import dao.KayttajaDAO;
import dao.TietojenMuokkausDAO;
import luokat.Pizza;
import luokat.TilattuPizza;
import luokat.Tilaus;
import luokat.Kayttaja;

/**
 * Servlet implementation class KoriKontrolleri
 */
@WebServlet("/KoriKontrolleri")
public class KoriKontrolleri extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public KoriKontrolleri() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		KayttajaDAO kaDao = new KayttajaDAO();
		HttpSession sessio = request.getSession();
		Kayttaja kayttaja = new Kayttaja();
		
		if(sessio.getAttribute("kayttajatunnus") != null) {
			System.out.println("löydettiin käyttäjätunnus sessiosta dogetissa");
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
		
		
		try{
		request.setAttribute("korilista", sessio.getAttribute("kori"));  
		
		  if (sessio != null && sessio.getAttribute("kayttajatunnus") != null) {

				String nimi = (String) sessio.getAttribute("nimi");
				String kayttajatunnus = (String) sessio
						.getAttribute("kayttajatunnus");
				boolean admin = (Boolean) sessio.getAttribute("admin");				
				request.setAttribute("kayttaja", kayttajatunnus);
				request.setAttribute("nimi", nimi);
				request.setAttribute("admin", admin);
			}
          
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("kori.jsp");
		disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String sivu = (String) request.getParameter("taaltatulen");
		String poistop = request.getParameter("poistopizza");
		int poisto = -1;
		if(poistop != null && !poistop.isEmpty()){
			System.out.println("poistop:ssa lukee" + poistop.toString());
			poisto = Integer.parseInt(poistop);
			
		}
		PizzaDAO pDao = new PizzaDAO();
		KoriDAO kDao = new KoriDAO();
		TietojenMuokkausDAO TMDao =  new TietojenMuokkausDAO();
		response.setContentType("text/html;charset=UTF-8");
		HttpSession sessio = request.getSession();		
		List<TilattuPizza> kori;
		double yhteishinta;
		
		kori = (List<TilattuPizza>) sessio.getAttribute("kori");
		
		String toiminto = request.getParameter("toiminto");
		
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
			
			sivu = "KoriKontrolleri";
		}
		
		if(poistop != null && !poistop.equals(null)){
			kDao.PoistaKorista(poisto, kori);	
			
			//pÃ¤ivitÃ¤ ostoskorin yhteishinta
			yhteishinta = pDao.LaskeYhteishinta(kori);
			sessio.setAttribute("yht", yhteishinta);
			
		}
		
		
		if(kori == null){
			kori = new ArrayList<TilattuPizza>();
			sessio.setAttribute("kori", kori);
		}
		
		
		response.sendRedirect(sivu);
	}

}
