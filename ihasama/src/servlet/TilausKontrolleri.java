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
import luokat.Tilaus;
import dao.PizzaDAO;
import dao.TilausDAO;

/**
 * Servlet implementation class TilausKontrolleri
 */
@WebServlet("/TilausKontrolleri")
public class TilausKontrolleri extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TilausKontrolleri() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PizzaDAO pDAO = new PizzaDAO();
		TilausDAO tDAO = new TilausDAO();		
		pDAO.avaaYhteys();
		tDAO.avaaYhteys();
		List<Pizza> lista;
		List<Tilaus>lista2;
		 try {
	            lista = pDAO.haePizzat();
	            lista2 = tDAO.haeTilaukset(lista);	            
	            request.setAttribute("tilauslista", lista2);
	            
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	        	tDAO.suljeYhteys();
	            pDAO.suljeYhteys();
	            
	        }
		 
		 RequestDispatcher disp = request.getRequestDispatcher("tilaukset.jsp");
			disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
