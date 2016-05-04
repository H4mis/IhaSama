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
import luokat.Pizza;
import luokat.TilattuPizza;
import luokat.Tilaus;

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
		
		HttpSession sessio = request.getSession();
		
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

		
		String poistop = request.getParameter("poistopizza");
		int poisto = -1;
		if(poistop != null && !poistop.isEmpty()){
			System.out.println("poistop:ssa lukee" + poistop.toString());
			poisto = Integer.parseInt(poistop);
			
		}
		PizzaDAO pDao = new PizzaDAO();
		KoriDAO kDao = new KoriDAO();
		response.setContentType("text/html;charset=UTF-8");
		HttpSession sessio = request.getSession();
		List<TilattuPizza> kori;
		double yhteishinta;
		
		kori = (List<TilattuPizza>) sessio.getAttribute("kori");
		
		if(poistop != null && !poistop.equals(null)){
			kDao.PoistaKorista(poisto, kori);	
			
			//p�ivit� ostoskorin yht hinta!
			yhteishinta = pDao.LaskeYhteishinta(kori);
			sessio.setAttribute("yht", yhteishinta);
			
		}
		
		
		if(kori == null){
			kori = new ArrayList<TilattuPizza>();
			sessio.setAttribute("kori", kori);
		}
		
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
				
			
		}} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			pDao.suljeYhteys();
		}
		
		
		}
		doGet(request, response);
	}

}
