package servlet;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class VahvariKontrolleri
 */
@WebServlet("/VahvariKontrolleri")
public class VahvariKontrolleri extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException{
		HttpSession sessio = request.getSession(false);
		
		String email = null;	
		if (sessio != null && sessio.getAttribute("email") != null){
			email = (String) sessio.getAttribute("email");}
		
			
			
			if(!email.isEmpty()){
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
	        		m.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
	        		m.setSubject("Tilausvahvistus");
	          		m.setText("Kiitos tilauksestasi!");
	        		
	          		Transport.send(m);

	    			System.out.println("Done");
	     
	    	 		
	        	} catch (AddressException e) {
	        		e.printStackTrace();
	        	} catch (javax.mail.MessagingException e) {
				e.printStackTrace();
			}
	        
			RequestDispatcher view = request.getRequestDispatcher("vahvistus.jsp");
			view.forward(request, response);
		}else{
			request.setAttribute("error", "Message is empty");
			
			RequestDispatcher view = request.getRequestDispatcher("kori.jsp");  // return to contact form
			view.forward(request, response);
			
		}
	}}
	

