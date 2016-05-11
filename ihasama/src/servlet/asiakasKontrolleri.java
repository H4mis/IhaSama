
package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import luokat.Kayttaja;
import luokat.Pizza;
import luokat.TilattuPizza;
import luokat.Tilaus;
import dao.KayttajaDAO;
import dao.KoriDAO;
import dao.PizzaDAO;
import dao.TilausDAO;

/**
 * Servlet implementation class asiakasKontrolleri
 */
@WebServlet("/asiakasKontrolleri")
public class asiakasKontrolleri extends HttpServlet {
	
	//lis�t��n decimal formatti ett� n�kyy nolla hinnan per�ss�
		DecimalFormat f = new DecimalFormat("0.00");
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public asiakasKontrolleri() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Luodaan oliolista tietokannan tiedoista

		PizzaDAO pDAO = new PizzaDAO();
		pDAO.avaaYhteys(); //avataan yhteys tietokantaan
		List<Pizza> lista; //luodaan lista ja lista2 jotka tulee sisältämään Pizzoja
		List<Pizza> lista2; //lista2 on asiakas menua varten
		HttpSession sessio = request.getSession(false);
		
		try {
			lista = pDAO.haePizzat(); //haetaan tietokannasta pizzat ja lisätään listaan
			request.setAttribute("pizzalista", lista); //annetaan requestille lista pizzoista
			
			lista2 = pDAO.haeAsiakasPizzat(lista); //luodaan menu asiakkaille
            request.setAttribute("menulista", lista2); //annetaan requestille menu lista pizzoista
            request.setAttribute("mistatulen", request.getServletPath());
            
            if (sessio != null && sessio.getAttribute("kayttajatunnus") != null) {

				String nimi = (String) sessio.getAttribute("nimi");
				String kayttajatunnus = (String) sessio
						.getAttribute("kayttajatunnus");
				boolean admin = (Boolean) sessio.getAttribute("admin");				
				request.setAttribute("kayttaja", kayttajatunnus);
				request.setAttribute("nimi", nimi);
				request.setAttribute("admin", admin);

			}
            
            
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pDAO.suljeYhteys(); //lopuksi suljetaan yhteys
		}

		// Pistet��n tieto eteenp�in asiakas.jsp:lle
		RequestDispatcher disp = request.getRequestDispatcher("asiakas.jsp");
		disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO: hae asiakkaalta tilatut pizzat.
		PizzaDAO pDao = new PizzaDAO();
		TilausDAO tDao = new TilausDAO();
		KayttajaDAO kaDao = new KayttajaDAO();
		
		HttpSession sessio = request.getSession(false);
		String kayttajatunnus = null;
		if (sessio != null && sessio.getAttribute("kayttajatunnus") != null){
			kayttajatunnus = (String) sessio.getAttribute("kayttajatunnus");}
		request.setCharacterEncoding("UTF-8"); //skandit toimimaan
		String tilattupizza = request.getParameter("tilaapizza");
		List<TilattuPizza> kori;
		kori = (List<TilattuPizza>) sessio.getAttribute("kori");
		KoriDAO kDao = new KoriDAO();
		double yhteishinta;
		
		if(kori == null){
			kori = new ArrayList<TilattuPizza>();
			sessio.setAttribute("kori", kori);
			yhteishinta = 0; 
		}
		
		String toiminto = request.getParameter("toiminto");
		
		if(toiminto != null && toiminto.equals("vahvistaTilaus")) { //tilauspainiketta painettu ostoskorissa
			System.out.println("toiminto on vahvista tilaus");
			String toimitustapa;
			String toimitus  = request.getParameter("toimitus");
			//String maksutapa  = request.getParameter("maksu");
			if(toimitus.equals("1")) {
				toimitustapa = "nouto";
			} else {
				toimitustapa = "kotiinkuljetus";
			}
			String osoite = request.getParameter("katuosoite");
			if(osoite == null || osoite.isEmpty()) {
				osoite = "";
			}
			String postinro = request.getParameter("posti");
			if(postinro == null || postinro.isEmpty()) {
				postinro = "00000";
			}
			//int postinroInt = Integer.parseInt(postinro);
			String postitmp = request.getParameter("postitmp");
			if(postitmp == null || postitmp.isEmpty()) {
				postitmp = "";
			}
			
			String kayttajatunnus1 = (String) sessio.getAttribute("kayttajatunnus");
			kaDao.avaaYhteys();
			Kayttaja kayttaja = new Kayttaja();
			try {
				kayttaja = kaDao.HaeKayttaja(kayttajatunnus1);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			kaDao.lisaaOsoiteKayttajalle(kayttaja, osoite, postinro, postitmp);
			tDao.avaaYhteys();
			Date tilausaika = new Date();
			boolean valmiina = false;
			boolean toimitettu = false;
			List<TilattuPizza> tilatutPizzat = (List<TilattuPizza>) sessio.getAttribute("korilista");
			Tilaus tilaus = new Tilaus(kayttajatunnus, tilausaika, valmiina, toimitettu, toimitustapa, tilatutPizzat);
			tDao.LisaaTunnistettuTilaus(tilaus, kayttajatunnus1);
			tDao.LisaaPizzaTilaukseen(tilatutPizzat, tilaus);
			tDao.suljeYhteys();
			kaDao.suljeYhteys();
			
			response.sendRedirect("TiedoteKontrolleri?TilausTehty=true");
		}
		
		Tilaus tilaus = new Tilaus(); //luodaan uusi tilaus olio
		
		
		String koripizza = request.getParameter("tilaapizza");
		
		if(koripizza != null && !koripizza.isEmpty()){
		try {
			pDao.avaaYhteys();			
			Pizza pizza = pDao.haePizza(koripizza);
			
			if(!pizza.equals(null)) // jos pizza l�ytyy tietokannasta
			{
				System.out.println("ollaa tääl");

				boolean oregano = false; //asetetaan oregano aluksi falseksi.
				String oreganoB = request.getParameter("oregano");
				if(oreganoB != null) { //jos oregano checkbox on ruksattu
					oregano = true; //oregano on true
				}
				
				boolean laktoositon = false;
				String laktoositonB = request.getParameter("laktoositon");
				if(laktoositonB != null) { //jos oregano checkbox on ruksattu
					laktoositon = true; //oregano on true
				}
				
				boolean gluteeniton = false;
				String gluteenitonB = request.getParameter("gluteeniton");
				if(gluteenitonB != null) { //jos oregano checkbox on ruksattu
					gluteeniton = true; //oregano on true
				}
				
				System.out.println("oregano: " + oregano + ", laktoositon: "+ laktoositon + ", gluteeniton: " + gluteeniton);
				
				Pizza tilPizza = pDao.haePizza(koripizza);
				TilattuPizza tpizza = new TilattuPizza(tilPizza, oregano, laktoositon, gluteeniton);//luodaa uusi tilattu pizza
				
				kori = kDao.lisaaKoriin(tpizza, kori); //lisätään tilattu pizza niine hyvineen koriin				
				
				sessio.setAttribute("kori", kori);
				
				yhteishinta = pDao.LaskeYhteishinta(kori);				
				
				
				sessio.setAttribute("yht", yhteishinta);
				response.sendRedirect("asiakasKontrolleri?addedPizzatoKori=true");
				
			
		}} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			pDao.suljeYhteys();
		}
		
		
		}
		
		
	
	}
}


