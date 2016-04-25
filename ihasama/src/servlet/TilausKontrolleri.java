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
		String[]toimiIDt=request.getParameterValues("toiminro");		
		String[]valmisIDt=request.getParameterValues("valmisnro");
		String[]tilausIDt=request.getParameterValues("tilausnro");
        String valmis =request.getParameter("valmis");
        String toimitettu =request.getParameter("toimitettu");
        String palautus =request.getParameter("palautus");
        int valmish = 0;
        int toimitus = 0;
        int palaa = 0;
        System.out.println("Valmis arvo on: " + valmis);
        
        if(valmis != null && !valmis.isEmpty()){
            valmish=Integer.parseInt(valmis);
        }
        if(toimitettu != null && !toimitettu.isEmpty()){
            toimitus=Integer.parseInt(toimitettu);
        }
        if(palautus != null && !palautus.isEmpty()){
            palaa=Integer.parseInt(palautus);
        }
        
        if(valmis !=null && !valmis.isEmpty()){
	        TilausDAO tDao = new TilausDAO();
	        tDao.avaaYhteys();
	        tDao.muutaValmius(valmisIDt, valmish);
	        tDao.suljeYhteys();
	        response.sendRedirect("TilausKontrolleri?changedValmis=true");
	    }
        if(toimitettu !=null && !toimitettu.isEmpty()){
	        TilausDAO tDao = new TilausDAO();
	        tDao.avaaYhteys();
	        tDao.muutaToimitus(toimiIDt, toimitus);
	        tDao.suljeYhteys();
	        response.sendRedirect("TilausKontrolleri?changedValmis=true");
    }
        if(palautus !=null && !palautus.isEmpty()){
	        TilausDAO tDao = new TilausDAO();
	        tDao.avaaYhteys();
	        tDao.muutaToimitus(tilausIDt, palaa);
	        tDao.muutaValmius(tilausIDt, palaa);
	        tDao.suljeYhteys();
	        response.sendRedirect("TilausKontrolleri?changedValmis=true");
    }
        
	}

}
