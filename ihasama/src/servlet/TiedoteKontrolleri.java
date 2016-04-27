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

import dao.PizzaDAO;
import dao.TiedoteDAO;
import luokat.Pizza;
import luokat.Tayte;
import luokat.Tiedote;



/**
 * Servlet implementation class TiedoteKontrolleri
 */
@WebServlet("/TiedoteKontrolleri")
public class TiedoteKontrolleri extends HttpServlet {

		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		
		protected void doGet(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			// Luodaan oliolista tietokannan tiedoista

			TiedoteDAO tDAO = new TiedoteDAO();
			tDAO.avaaYhteys();
			List<Tiedote> lista = new ArrayList<Tiedote>();
			
			
	        try {
	            lista = tDAO.haeTiedotteet();
	            request.setAttribute("tiedotelista", lista);
	            request.setAttribute("kukkuluuruu", request.getServletPath());
	            
	            
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            tDAO.suljeYhteys();
	        }

			// Pistet��n tieto eteenp�in list.jsp:lle

			RequestDispatcher disp = request.getRequestDispatcher("index.jsp");
			disp.forward(request, response);
		}
		
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			// haetaan responsesta tiedot asiakkaan rekister�innist�
			response.setContentType("text/html");
			String tiedote = request.getParameter("tiedote");
			System.out.println("Response palautti tiedot: tiedote: " + tiedote);
		
				//luodaan tiedote
				
				if(tiedote != null && !tiedote.isEmpty()){
					Tiedote t = new Tiedote(tiedote);
					TiedoteDAO tDao = new TiedoteDAO();
					tDao.avaaYhteys();
					tDao.muokkaaTiedote(t);
					tDao.suljeYhteys();
					response.sendRedirect("TiedoteKontrolleri?sentTiedote=true");
					
				}
				
			}
		}

		
	

