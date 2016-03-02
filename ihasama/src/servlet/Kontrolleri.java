package servlet;

import java.io.IOException;
import java.sql.SQLException;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import luokat.Pizza;
import dao.PizzaDAO;



/**
 * Servlet implementation class Kontrolleri
 */
@WebServlet("/Kontrolleri")
public class Kontrolleri extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Kontrolleri() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Luodaan oliolista tietokannan tiedoista

				PizzaDAO pDAO = new PizzaDAO();
				pDAO.avaaYhteys();
				List<Pizza> lista;
				try {
					lista = pDAO.haePizzat();
					request.setAttribute("pizzalista", lista);
				} catch (NumberFormatException e) {

					e.printStackTrace();
				} catch (SQLException e) {

					e.printStackTrace();
				} finally {
					pDAO.suljeYhteys();
				}

				// Pistet‰‰n tieto eteenp‰in list.jsp:lle
				
				RequestDispatcher disp = request.getRequestDispatcher("list.jsp");
				disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
