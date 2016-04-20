
package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import luokat.Pizza;
import luokat.TilattuPizza;
import luokat.Tilaus;
import dao.PizzaDAO;
import dao.TilausDAO;

/**
 * Servlet implementation class asiakasKontrolleri
 */
@WebServlet("/asiakasKontrolleri")
public class asiakasKontrolleri extends HttpServlet {
	
	//lis‰t‰‰n decimal formatti ett‰ n‰kyy nolla hinnan per‰ss‰
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
		List<Pizza> lista; //luodaan lista ja lista2 jotka tulee sis‰lt‰m‰‰n Pizzoja
		List<Pizza> lista2; //lista2 on asiakas menua varten
		try {
			lista = pDAO.haePizzat(); //haetaan tietokannasta pizzat ja lis‰t‰‰n listaan
			request.setAttribute("pizzalista", lista); //annetaan requestille lista pizzoista
			
			lista2 = pDAO.haeAsiakasPizzat(lista); //luodaan menu asiakkaille
            request.setAttribute("menulista", lista2); //annetaan requestille menu lista pizzoista
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pDAO.suljeYhteys(); //lopuksi suljetaan yhteys
		}

		// Pistet‰‰n tieto eteenp‰in asiakas.jsp:lle
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
		
		request.setCharacterEncoding("UTF-8"); //skandit toimimaan
		String tilattupizza = request.getParameter("tilaapizza");
		
		Tilaus tilaus = new Tilaus(); //luodaan uusi tilaus olio
		if(tilaus.getTilausaika().equals(null)) { //jos tilausaikaa ei olla viel‰ m‰‰ritelty
			Date tilausaika = new Date(); //luodaan aika
			tilaus.setTilausaika(tilausaika); //asetetaan tilauksen tilausaika
		}
		
		
		if(tilattupizza.length() > 0) //jos tilauskentt‰ ei ole tyhj‰, eli asiakas haluaa lis‰t‰ pizzan tilaukseensa
		{
			try {
				pDao.avaaYhteys();
				if(pDao.haePizza(tilattupizza) != null) // jos pizza lˆytyy tietokannasta
				{
					boolean oregano = false; //asetetaan oregano aluksi falseksi.
					if(request.getParameter("oregano").contentEquals("1")) { //jos oregano checkbox on ruksattu
						oregano = true; //oregano on true
					}
					boolean laktoositon = false;
					if(request.getParameter("laktoositon").contentEquals("1")) {
						laktoositon = true;
					}
					boolean gluteeniton = false;
					if(request.getParameter("gluteeniton").contentEquals("1")) {
						gluteeniton = true;
					}
					Pizza tilPizza = pDao.haePizza(request.getParameter("pizzaid"));
					TilattuPizza tpizza = new TilattuPizza(tilPizza, oregano, laktoositon, gluteeniton);//luodaa uusi tilattu pizza
					
					try {
						tDao.avaaYhteys();
						if(tDao.haeTilaus(tilaus).equals(null)) { //jos tilaus ei ole olemassa
							//luodaan tilaus
							tDao.LisaaTilaus(tilaus);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					tDao.LisaaPizzaTilaukseen(tpizza, tilaus);//lis‰t‰‰n tilattu pizza tilaukseen
				}
				
				tDao.suljeYhteys(); //suljetaan yhteydet! Mik‰‰n Dao komento ei toimi n‰iden j‰lkeen ellei avata yhteytt‰ uudelleen!
				pDao.suljeYhteys();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}


