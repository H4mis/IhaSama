package servlet;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;

import com.oracle.webservices.internal.api.message.PropertySet.Property;


/**
 * Servlet implementation class PalauteKontrolleri
 */
@WebServlet("/PalauteKontrolleri")
public class PalauteKontrolleri extends HttpServlet {
	private static final long serialVersionUID = 1L;
public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		
		String aihe = request.getParameter("aihe");
		String email = request.getParameter("email");
		String palaute = request.getParameter("palaute");
		
		if(!palaute.isEmpty()){
			String host = "smtp.gmail.com";
	    		int port = 587;
	    		final String username = "Ihasamapizza@gmail.com";
	    		final String password = "ihasama123";
	    	
			Properties props = new Properties();
			
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			Session session = Session.getInstance(props,
					  new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(username, password);
						}
					  });
			try {
	         		Message m = new MimeMessage(session);
	       			m.setFrom(new InternetAddress(email, null));
	        		m.addRecipient(Message.RecipientType.TO, new InternetAddress("ihasamapizza@gmail.com", "me"));
	        		m.setSubject(aihe);
	          		m.setText(palaute);
	            
	          		Transport.send(m);

	    			System.out.println("Done");
	     
	    	 		
	        	} catch (AddressException e) {
	        		e.printStackTrace();
	        	} catch (javax.mail.MessagingException e) {
				e.printStackTrace();
			}
	        
			RequestDispatcher view = request.getRequestDispatcher("yhteystiedot.jsp");
			view.forward(request, response);
		}else{
			request.setAttribute("error", "Message is empty");
			
			RequestDispatcher view = request.getRequestDispatcher("yhteystiedot.jsp");  // return to contact form
			view.forward(request, response);
			
		}
	}
}