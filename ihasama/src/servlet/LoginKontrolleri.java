package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import luokat.Kayttaja;
import dao.LoginDAO;



@WebServlet("/LoginKontrolleri")
public class LoginKontrolleri extends HttpServlet {
	
	private String sivu = "login.jsp";
	
	
	   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	
			// Tieto eteenpäin sivulle, jolle login tehty
					RequestDispatcher disp = request.getRequestDispatcher(sivu);
					disp.forward(request, response);
		}
	    
	
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
 	
 	LoginDAO LDao= new LoginDAO ();
 	
     response.setContentType("text/html;charset=UTF-8");
     PrintWriter out = response.getWriter();
     
     String kayttaja = request.getParameter("kayttajatunnus");
     String salasana = request.getParameter("salasana");
     sivu = request.getParameter("from");
    
     
     
     if(!sivu.equals(null)){
         sivu.replaceFirst("ihasama/","");
         
         System.out.println(sivu);}
       
     
     if(sivu.equals("/asiakasKontrolleri")){
    	 sivu = "/ihasama" + request.getParameter("from");
    	 System.out.println("Kun yritetÃ¤Ã¤n muuttaa asiakas.jsptÃ¤:" + sivu);
     }
     
     if(sivu.equals("/TiedoteKontrolleri")){
    	 sivu = "/ihasama" + request.getParameter("from");
    	 System.out.println("Kun yritetÃ¤Ã¤n muuttaa index.jsptÃ¤:" + sivu);
     }
     
     
     if(salasana !=null && kayttaja !=null){
     try {
     	LDao.avaaYhteys();
     	Kayttaja kayttajaotus = LDao.haeKayttaja(kayttaja, salasana);        	
     	
     	if(kayttajaotus.getKayttajatunnus().equals("N/A")){
			   out.println("Username or Password incorrect");
			   response.sendRedirect(sivu+"?LoginNoSuccess=true");
			  // RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
			  // rs.include(request, response);
			}
			
     	if(!kayttajaotus.getKayttajatunnus().equals("N/A"))
			{System.out.println("Käyttäjä löytyi: " + kayttaja);
			response.sendRedirect(sivu+"?LoginSuccess=true");
			HttpSession sessio=request.getSession(); 
			sessio.setAttribute("nimi", kayttajaotus.getEtunimi());
			sessio.setAttribute("kayttajatunnus", kayttajaotus.getKayttajatunnus());
			sessio.setAttribute("admin",kayttajaotus.isAdmin());
			// RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
			  // rs.include(request, response);
			  
			}		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
     LDao.suljeYhteys();
 }  
 
 }
}
