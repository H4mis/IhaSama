package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import luokat.Tilaus;
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
		TilausDAO tDAO = new TilausDAO();
		tDAO.avaaYhteys();
		
		List<Tilaus>tilauslista;	
		List<Tilaus>varalista;
		HttpSession sessio = request.getSession(false);
		
		 try {			
			 	int tilnum = 0;
			 	if(request.getAttribute("tilnum") != null){
			 	tilnum = (int) request.getAttribute("tilnum");}
	            tilauslista = tDAO.HaeTilaukset1();	            
	            request.setAttribute("tilauslista", tilauslista);
	            request.setAttribute("poistalista", false);
	            if(tilnum != 0){
	        	   varalista = tDAO.haeTilaukset(tilnum);
	        	   request.setAttribute("varalista", varalista);
	        	   request.setAttribute("poistalista", true);
	           }
	            
	            
	        	if (sessio != null && sessio.getAttribute("kayttajatunnus") != null) {

	        		
	        		
					String nimi = (String) sessio.getAttribute("nimi");
					String kayttajatunnus = (String) sessio.getAttribute("kayttajatunnus");
					boolean admin = (Boolean) sessio.getAttribute("admin");
					request.setAttribute("kayttaja", kayttajatunnus);
					request.setAttribute("nimi", nimi);
					request.setAttribute("admin", admin);

				}
	            
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
	        	tDAO.suljeYhteys();
	            
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
        String tilnum2=request.getParameter("tilnum");
        int tilnum = 0;
        
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
	        response.sendRedirect("TilausKontrolleri?changedToimitus=true");
    }
        if(palautus !=null && !palautus.isEmpty()){
	        TilausDAO tDao = new TilausDAO();
	        tDao.avaaYhteys();
	        tDao.muutaToimitus(tilausIDt, palaa);
	        tDao.muutaValmius(tilausIDt, palaa);
	        tDao.suljeYhteys();
	        response.sendRedirect("TilausKontrolleri?changedPalautus=true");
    }
       
     if(tilnum2 != null && !tilnum2.isEmpty()){
    	 tilnum = Integer.parseInt(tilnum2);
    	 request.setAttribute("tilnum", tilnum);    	
    	 doGet(request,response);
	        
     }
        
	}

}
