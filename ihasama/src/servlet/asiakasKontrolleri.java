
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
	}
}


