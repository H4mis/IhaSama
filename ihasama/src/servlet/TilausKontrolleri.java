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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Luodaan TilausDAO-olio		
		TilausDAO tDAO = new TilausDAO();
		
		// Avataan yhteys TilausDAO-oliolla
		tDAO.avaaYhteys();
		
		// Luodaan Arraylistit, joilla listataan tilattuja pizzoja ja niiden ominaisuuksia (gluteeniton, laktoositon, oregano)
		List<Tilaus>tilauslista;	
		List<Tilaus>varalista;
		
		// Luodaan HttpSession-olio olemassaolevasta sessiosta		
		HttpSession sessio = request.getSession(false);
		
		try {  
			 
			 	// Luodaan integerit, joilla varmistetaan, mikä muoto tilaus.jsp:stä avataan
			 	int tilnum = 0;
			 	int paistoon = 0;
			 	int toimitus = 0;
			 	
			 	// Jos sivulta tullut tieto "tilnum" ei ole null,
			 	if(request.getAttribute("tilnum") != null){
			 		
			 		// laitetaan integeriin tilnum kyseinen tieto
			 		tilnum = (int) request.getAttribute("tilnum");}
			 	
			 		// ArrayList tilauslista täytetään TilausDAO-olion HaeTilaukset1-metodilla (metodi hakee kaikki tilaukset)
			 		tilauslista = tDAO.HaeTilaukset1();
	            
			 		// Lähetetään ArrayList tilauslista sivulle
			 		request.setAttribute("tilauslista", tilauslista);
	            
			 		// Asetetaan sivulle lähetettävät booleanit muotoon, joka jättää tavallisen tilauslistauksen auki
	            
			 		request.setAttribute("poistalista", false); // Tavallista tilauslistaa ei suljeta
			 		request.setAttribute("toimitus", false); // Toimittaja-listaa ei haluta auki
			 		request.setAttribute("paistoon", false); // Paistaja-listaa ei haluta auki
	            
			 		// Jos tilnum oli muutettu joksikin muuksi kuin 0
	            
			 		if(tilnum != 0){
	            	
			 			// ArrayList varalistalle täytetään yhdellä tilauksella, 
			 			// joka vastaa tilnum-muuttujan avulla tuotua yhtä tilausta
			 			varalista = tDAO.haeTilaukset(tilnum);   
	        	   
			 			request.setAttribute("varalista", varalista);   // Lähetetään ArrayList varalista sivulle
			 			request.setAttribute("poistalista", true); // Poistetaan tavallinen tilauslista näkymästä
			 		}
	            
			 		// Jos paisto-attribuutti ei ollut null,
	            
			 		if(request.getAttribute("paisto") != null){
	            	
	            	// Laitetaan paistoon-muuttujaan sen sisältö	            	
	            
	            	paistoon = (int) request.getAttribute("paisto");
	            	}
	            
			 		// Kun halutaan avata Paistaja-sivu, paistoon-muuttuja on muuta kuin 0
	            
			 		if(paistoon != 0){
	            	
	            	// Jolloin muokataan sivulle vietävät booleanit muotoon:
	            	
			 			request.setAttribute("paistoon", true); // tämä aktivoi Paistaja-sivun
			 			request.setAttribute("poistalista", true); // Tämä sulkee tavallisen tilauslistauksen
			 		}
	            
			 		// Jos toimitukseen-attribuutti ei ollut null,
	            
			 		if(request.getAttribute("toimitukseen") != null){
	            	
			 			// Laitetaan toimitus-muuttujaan sen sisältö
	            	
			 			toimitus = (int)request.getAttribute("toimitukseen");
	            	}
	            
			 		// Jos halutaan "Toimittajan" sivu auki, toimitus-muuttuja on jotain muuta kuin 0
	            
			 		if(toimitus != 0){
	            	
			 			// Jolloin muokataan sivulle vietävät booleanit muotoon: 
	            	
			 			request.setAttribute("toimitukseen", true); // Tämä aktivoi Toimittaja-sivun
			 			request.setAttribute("paistoon", false); // Tällä varmistetaan, että Paistaja-sivu ei aukea
			 			request.setAttribute("poistalista", true); // Poistetaan tavallinen tilauslista
			 		}	 
	            
			 		// Jos sessio ei ole tnull ja käyttäjätunnus ei ole null
			 		if (sessio != null && sessio.getAttribute("kayttajatunnus") != null) {

	        		
			 			// Otetaan käyttäjän nimi, tunnus ja admin-boolean sessiosta 
			 			String nimi = (String) sessio.getAttribute("nimi");
			 			String kayttajatunnus = (String) sessio.getAttribute("kayttajatunnus");
			 			boolean admin = (Boolean) sessio.getAttribute("admin");
					
			 			// Ja lisätään ne requestiin
					
			 			request.setAttribute("kayttaja", kayttajatunnus);
			 			request.setAttribute("nimi", nimi);
			 			request.setAttribute("admin", admin);

			 		}
	            // Automaattisesti luodut try-catch osuudet
	        	} catch (NumberFormatException e) {
	            e.printStackTrace();
	        	} catch (SQLException e) {
	            e.printStackTrace();
	        	} catch (ParseException e) { 
				e.printStackTrace();
	        	} finally {	
	        		// Lopulta suljetaan aiemmin TilausDAO-oliolla luotu yhteys 	
	        		tDAO.suljeYhteys();
	            
	    }
		
		// Lähetetään tiedot doGetistä tilaukset.jsp-sivulle
		 
		RequestDispatcher disp = request.getRequestDispatcher("tilaukset.jsp");
		disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// String arrayt, joilla hankitaan tiedot tilausnumeroista, valmiiden tilausten tilausnumeroista ja
		// toimitettujen tilausten tilausnumeroista
		 
		
		String[]toimiIDt=request.getParameterValues("toiminro");		
		String[]valmisIDt=request.getParameterValues("valmisnro");
		String[]tilausIDt=request.getParameterValues("tilausnro");
		
		// Jos joku tilaus on valmis tai toimitettu, tama String palautuu muuna kuin nullina tai tyhjana
	    String valmis =request.getParameter("valmis");
        String toimitettu =request.getParameter("toimitettu");
        
        // Jos halutaan palauttaa tilaus tilanteeseen jossa se on vasta vastaanotettu, tama palautuu muuna kuin nullina tai tyhjana 
        String palautus =request.getParameter("palautus");
        
        // Toisessa kohdassa kaytetty tilausnumero
        
        String tilnum2=request.getParameter("tilnum");
        
        // paisto on paistajan sivun esille tuova, toimitetaan on toimittajan sivun tuova osa
        
        String paisto=request.getParameter("paistoon");
        String toimitetaan=request.getParameter("toimitus");
        int tilnum = 0;
        int paistoon = 0;        
        int toimitukseen = 0;
        
        int valmish = 0;
        int toimitus = 0;
        int palaa = 0;
        System.out.println("Valmis arvo on: " + valmis);
        System.out.println("Toimitetaan arvo on "+ toimitetaan);
        if(valmis != null && !valmis.isEmpty()){
            valmish=Integer.parseInt(valmis);
        }
        if(paisto != null && !paisto.isEmpty()){
        	paistoon = Integer.parseInt(paisto);
        	request.setAttribute("paisto", paistoon);
        	if(valmish == 0){
        	doGet(request,response);}
        }
       
        
        if(toimitettu != null && !toimitettu.isEmpty()){
            toimitus=Integer.parseInt(toimitettu);
        }
        
        if(toimitetaan != null && !toimitetaan.isEmpty()){
        	toimitukseen = Integer.parseInt(toimitetaan);
        	System.out.println("Toimitukseen arvo on " +toimitukseen);
        	
        	request.setAttribute("toimitukseen",toimitukseen);
        	if(toimitus == 0){        		
        		doGet(request,response);}
        	
        }
        
        if(palautus != null && !palautus.isEmpty()){
            palaa=Integer.parseInt(palautus);
        }
        
        if(valmis !=null && !valmis.isEmpty()){
	        TilausDAO tDao = new TilausDAO();
	        tDao.avaaYhteys();
	        tDao.muutaValmius(valmisIDt, valmish);
	        tDao.suljeYhteys();
	        if(paistoon == 1){
	        	doGet(request,response);
	        }else{	        
	        response.sendRedirect("TilausKontrolleri?changedValmis=true");}
	    }
        if(toimitettu !=null && !toimitettu.isEmpty()){
	        TilausDAO tDao = new TilausDAO();
	        tDao.avaaYhteys();
	        tDao.muutaToimitus(toimiIDt, toimitus);
	        tDao.suljeYhteys();
	        if(toimitukseen == 1){
	        	doGet(request,response);
	        }else{	        
	        response.sendRedirect("TilausKontrolleri?changedToimitus=true");}
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
