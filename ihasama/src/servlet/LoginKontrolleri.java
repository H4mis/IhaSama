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
        	
			if(LDao.haeKayttaja(kayttaja, salasana) != null)
			{System.out.println("käyttäjä  löytytiawrjfa" + kayttaja);
			response.sendRedirect("loginKontrolleri?LoginSuccess=true");
			
			  //  RequestDispatcher rs = request.getRequestDispatcher("asiakasKontrolleri");
			 //   rs.forward(request, response);
			}
			else
			{
			   out.println("Username or Password incorrect");
			   response.sendRedirect("loginKontrolleri?LoginNoSuccess=true");
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
