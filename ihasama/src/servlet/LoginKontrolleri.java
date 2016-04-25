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

import luokat.Kayttaja;
import dao.LoginDAO;



@WebServlet("/LoginKontrolleri")
public class LoginKontrolleri extends HttpServlet {
	
	   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	
			// Pistetään tieto eteenpäin asiakas.jsp:lle
					RequestDispatcher disp = request.getRequestDispatcher("login.jsp");
					disp.forward(request, response);
		}
	    
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	LoginDAO LDao= new LoginDAO ();
    	
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String kayttaja = request.getParameter("kayttajatunnus");
        String salasana = request.getParameter("salasana");
        
        if(salasana !=null && kayttaja !=null){ 
        try {
        	LDao.avaaYhteys();
        	Kayttaja kayttajaotus = LDao.haeKayttaja(kayttaja, salasana);
        	
			if(!kayttajaotus.equals(null))
			{System.out.println("käyttäjä  löytyi: " + kayttaja);
			response.sendRedirect("LoginKontrolleri?LoginSuccess=true");
			
			  //  RequestDispatcher rs = request.getRequestDispatcher("asiakasKontrolleri");
			 //   rs.forward(request, response);
			}
			else
			{
			   out.println("Username or Password incorrect");
			   response.sendRedirect("LoginKontrolleri?LoginNoSuccess=true");
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
