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
	
	
	
	
	   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	
			// Jos doPostia ei kaytetty, edetaan login.jsp:lle (kaien pitaisi kayttaa doPostia)
					RequestDispatcher disp = request.getRequestDispatcher("login.jsp");
					disp.forward(request, response);
		}
	    
	
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
	 
	 // String, johon tuodaan tieto sivun sijainnista
	 
	 String sivu = "login.jsp";	 
	
	 PrintWriter out = response.getWriter();
	 
 	LoginDAO LDao= new LoginDAO ();
 	
 	// Maaritetaan ContentType UTF-8:ksi
 	
     response.setContentType("text/html;charset=UTF-8");
     
     // Haetaan .jsp:lta tuotu kayttajatunnus ja salasana ja maaritellaan ne Stringeiksi
     
     String kayttaja = request.getParameter("kayttajatunnus");
     String salasana = request.getParameter("salasana");
     
     // Aiemmin maariteltyyn Stringiin laitetaan tieto sivun nimesta
     
     sivu = request.getParameter("from");     
     
     // Jos sivu ei ole tyhja, poistetaan sen alusta ihasama/
     
     if(!sivu.equals(null)){
         sivu.replaceFirst("ihasama/","");
         
         System.out.println(sivu);}
       
     // Jos sivun sisalto on /asiakasKontrolleri, lisataan sen alkuun /ihasama/ 
     // Yhta hyvin voitaisiin poistaa / samalla tavalla kuin ylemmassa poistetaan ihasama/.
     // Huomaa: ihasama/ ja /ihasama/ ovat kaksi eri asiaa
     
     if(sivu.equals("/asiakasKontrolleri")){
    	 sivu = "/ihasama" + request.getParameter("from");
    	 System.out.println("Kun yritetaan muuttaa asiakas.jspta:" + sivu);
     }
     
     // Sama kuin ylempana, vain jos sivu sisaltaa tekstin /TiedoteKontrolleri
     
     if(sivu.equals("/TiedoteKontrolleri")){
    	 sivu = "/ihasama" + request.getParameter("from");
    	 System.out.println("Kun yritetaan muuttaa index.jspta:" + sivu);
     }
     
     
     // Jos salasana ei ole null eika kayttajatunnus ole null 
     
     if(salasana !=null && kayttaja !=null){
     try {
     	LDao.avaaYhteys();
     	Kayttaja kayttajaotus = LDao.haeKayttaja(kayttaja, salasana);        	
     	
     	
     	// Jos kayttajatunnus tai salasana oli virheellinen (kayttajatunnus maaritelty N/A:ksi), ilmoita virheesta
     	
     	if(kayttajaotus.getKayttajatunnus().equals("N/A")){
			   out.println("Username or Password incorrect");
			   response.sendRedirect(sivu+"?LoginNoSuccess=true");			  
			}
			
     	
     	// Jos kayttajatunnus/salasana-yhdistelma loytyi (eli kayttajatunnus ei ole N/A) 
     	
     	if(!kayttajaotus.getKayttajatunnus().equals("N/A"))
			{System.out.println("Kayttaja loytyi: " + kayttaja);
			
			// Maaritellaan sessio
			
			HttpSession sessio=request.getSession();
			
			// Lisataan sessioon kayttajan etunimi, kayttajatunnus ja se, onko kayttaja admin
			
			sessio.setAttribute("nimi", kayttajaotus.getEtunimi());
			sessio.setAttribute("kayttajatunnus", kayttajaotus.getKayttajatunnus());
			sessio.setAttribute("admin",kayttajaotus.isAdmin());			
			
			// Lahetetaan tieto eteenpain sivulle, jolta pyynto tuli. Lisataan ?LoginSuccess=true URL:n paatteeksi
			
			response.sendRedirect(sivu+"?LoginSuccess=true");
			
			  
			}		
		} catch (SQLException e) {			
			e.printStackTrace();
		}
     LDao.suljeYhteys();
 }  
 
 }
}
