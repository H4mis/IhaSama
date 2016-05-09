package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();       
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		
		// Luodaan HttpSession-olio, mutta vain jos sessio voidaan saada requestista. Jos ei, ei luoda uutta sessiota
		
		HttpSession sessio=request.getSession(false);
		
		// Jos sessio ei ole tyhja eika session kayttajatunnus-attribuutti ole tyhja, invalidoidaan sessio
		
		if(sessio != null && sessio.getAttribute("kayttajatunnus") != null){
		sessio.invalidate();}
		
		// Siirrytaan logout.jsp-sivulle
		
		RequestDispatcher disp = request.getRequestDispatcher("logout.jsp");
		disp.forward(request, response);		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
	}

}