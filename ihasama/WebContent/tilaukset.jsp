<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="luokat.Pizza"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="jquery-1.12.0.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Merienda:700' rel='stylesheet' type='text/css'>
<title>Tilauslista</title>

</head>
<body>
<c:if test="${!sessionScope.admin}"><c:redirect url="TiedoteKontrolleri"/></c:if>

<c:if test="${sessionScope.admin}">
	<nav class="navbar navbar-inverse">
  <div class="container-fluid">
  	<div class="navbar-header">
     <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
     	<span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>    
   </div><!-- navbar header loppuu tähän -->
    
   <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
      
     	<li><a  href="TiedoteKontrolleri">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<c:if test="${empty sessionScope.kayttajatunnus}">
			<li><a  href="rekisterointi.jsp">Rekisteröinti</a></li>
		</c:if>
		<li><a  href="yhteystiedot.jsp">Yhteystiedot</a></li>
		<li><a  href="TilausKontrolleri">Tilauslista</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<c:if test="${sessionScope.admin}"><li><a href="Kontrolleri">Admin</a></li></c:if>
      
<!-- Logout -->
      <li><a>Hei, <c:out value="${sessionScope.nimi}" /></a></li><li><a href="Logout">Logout</a></li>
     
<!-- Logout loppuu tähän -->

      </ul>
    </div><!-- collapse navbar-collapse loppuu tähän -->
  </div><!-- container fluid loppuu tähän -->
</nav>

	<h1>Castello é Fiore</h1>
  <c:if test="${paistoon}"><h3>Paistajan sivu</h3></c:if>
<c:if test="${toimitukseen}"><h3>Toimittajan sivu</h3></c:if>

	<div id="laatikko">
		<table border="1">
			<tr>
				<th>Tilausnro</th>
				<th>Tilausaika</th>
				<th>Tilaajatunnus</th>				
				<th>Toimitustapa</th>
				<th>Pizzat</th>
				<th>Oregano</th>
				<th>Laktoositon</th>
				<th>Gluteeniton</th>
				<th>Tilan muutos</th>				
				<th>Palauta</th>
				<th>Tilauksen tila</th>
			</tr>
		<c:if test="${!poistalista}" >	
				<c:forEach items="${tilauslista}" var="tilaus">
				<c:if test="${tilaus.toimitettu}"><tr style="text-decoration: line-through;"></c:if>
				<c:if test="${!tilaus.toimitettu}"><tr></c:if>
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="6"></td>
					<td>
						<c:if test="${(!tilaus.valmiina) && (!tilaus.toimitettu)}">
							VASTAANOTETTU
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (!tilaus.toimitettu)}">
							VALMIS TOIMITUKSEEN
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (tilaus.toimitettu)}">
							TOIMITETTU
						</c:if>
					</td>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tpizza">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><c:out value="${tpizza.pizza.pizzanimi}" /></td>
						<td>
							<c:if test="${tpizza.oregano}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.oregano}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.laktoositon}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.gluteeniton}">EI</c:if>
						</td>
						<td>
							<form action="TilausKontrolleri" method="post">
								<c:if test="${!tilaus.valmiina && !tilaus.toimitettu}">
									<input type="hidden" value="${tilaus.tilausnro}" name="valmisnro" />
	    							<input type="hidden" name="valmis" value="1" />
	    							<input type="submit" value="Valmis">
								</c:if>
								<c:if test="${tilaus.valmiina && !tilaus.toimitettu}">
									<input type="hidden" value="${tilaus.tilausnro}" name="toiminro" />
	    							<input type="hidden" name="toimitettu" value="1" />
	    							<input type="submit" value="Toimitettu">
								</c:if>
								<c:if test="${tilaus.valmiina && tilaus.toimitettu}">
									N/A
								</c:if>
							
							</form>
						</td>				
						<td>
							<form action="TilausKontrolleri" method="post">
                                 <input type="hidden" value="${tilaus.tilausnro}" name="tilausnro" />                                 
                                 <input type="hidden" name="palautus" value="0" />
                                <input type="submit" value="Palauta" />
                            </form>
						</td>
					</tr>
					</c:forEach>	
				</tr>
			</c:forEach>
			</c:if>
			
			<!--  vanhan hirvityksen alku ja uuden version loppu -->
			
			<c:if test="${poistalista}" >
			<c:if test="${!paistoon}">
			<c:if test="${!toimitus}" >	
			<c:if test="${empty tilauslista}">
			</table>LISTA ON TYHJÄ!!!!!</c:if>
			<c:if test="${not empty tilauslista}">
						
			<c:forEach items="${varalista}" var="tilaus" varStatus="loop">
				<c:if test="${loop.index <= 0 }">
				
				<c:if test="${tilaus.toimitettu}"><tr style="text-decoration: line-through;"></c:if>
				<c:if test="${!tilaus.toimitettu}"><tr></c:if>
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="6"></td>
					<td>
						<c:if test="${(!tilaus.valmiina) && (!tilaus.toimitettu)}">
							VASTAANOTETTU
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (!tilaus.toimitettu)}">
							VALMIS TOIMITUKSEEN
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (tilaus.toimitettu)}">
							TOIMITETTU
						</c:if>
					</td>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tpizza">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><c:out value="${tpizza.pizza.pizzanimi}" /></td>
						<td>
							<c:if test="${tpizza.oregano}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.oregano}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.laktoositon}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.gluteeniton}">EI</c:if>
						</td>
						<td>
							<form action="TilausKontrolleri" method="post">
								<c:if test="${!tilaus.valmiina && !tilaus.toimitettu}">
									<input type="hidden" value="${tilaus.tilausnro}" name="valmisnro" />
	    							<input type="hidden" name="valmis" value="1" />
	    							<input type="submit" value="Valmis">
								</c:if>
								<c:if test="${tilaus.valmiina && !tilaus.toimitettu}">
									<input type="hidden" value="${tilaus.tilausnro}" name="toiminro" />
	    							<input type="hidden" name="toimitettu" value="1" />
	    							<input type="submit" value="Toimitettu">
								</c:if>
								<c:if test="${tilaus.valmiina && tilaus.toimitettu}">
									N/A
								</c:if>
							
							</form>
						</td>				
						<td>
							<form action="TilausKontrolleri" method="post">
                                 <input type="hidden" value="${tilaus.tilausnro}" name="tilausnro" />                                 
                                 <input type="hidden" name="palautus" value="0" />
                                <input type="submit" value="Palauta" />
                            </form>
						</td>
					</tr>
					</c:forEach>
					
				</tr>
				</c:if>
			</c:forEach>
			</c:if>
			</c:if>
			</c:if>
			</c:if><!--  Vanhan hirvityksen loppu -->
		<!--  Paistajan osuus alkaa -->
		
		<c:if test="${paistoon}">			
				<c:forEach items="${tilauslista}" var="tilaus">				
				<c:if test="${tilaus.valmiina}"><tr></c:if>
				<c:if test="${!tilaus.valmiina}">
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="6"></td>
					<td>
						<c:if test="${(!tilaus.valmiina) && (!tilaus.toimitettu)}">
							VASTAANOTETTU
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (!tilaus.toimitettu)}">
							VALMIS TOIMITUKSEEN
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (tilaus.toimitettu)}">
							TOIMITETTU
						</c:if>
					</td>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tpizza">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><c:out value="${tpizza.pizza.pizzanimi}" /></td>
						<td>
							<c:if test="${tpizza.oregano}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.oregano}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.laktoositon}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.gluteeniton}">EI</c:if>
						</td>
						<td>
							<form action="TilausKontrolleri" method="post">
								<c:if test="${!tilaus.valmiina && !tilaus.toimitettu}">
									<input type="hidden" value="${tilaus.tilausnro}" name="valmisnro" />
	    							<input type="hidden" name="valmis" value="1" />
	    							<input type="hidden" name="paistoon" value="1" />
	    							<input type="submit" value="Valmis">
								</c:if>								
								<c:if test="${tilaus.valmiina}">
									N/A
								</c:if>
							
							</form>
						</td>				
						<td>
							<form action="TilausKontrolleri" method="post">
                                 <input type="hidden" value="${tilaus.tilausnro}" name="tilausnro" />                                 
                                 <input type="hidden" name="palautus" value="0" />
                                 <input type="hidden" name="paistoon" value="1" />
                                <input type="submit" value="Palauta" />
                            </form>
						</td>
					</tr>
					</c:forEach>	
				</tr>
				</c:if>
			</c:forEach>
			</c:if> <!--  Paistajan osuus loppuu -->
			
			<!--  Toimittajan osuus alkaa -->
	
	
	<c:if test="${toimitukseen}">	
				<c:forEach items="${tilauslista}" var="tilaus">				
				<c:if test="${tilaus.toimitettu}"><tr></c:if>
				<c:if test="${tilaus.valmiina}"><c:if test="${!tilaus.toimitettu}">
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="6"></td>
					<td>
						<c:if test="${(!tilaus.valmiina) && (!tilaus.toimitettu)}">
							VASTAANOTETTU
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (!tilaus.toimitettu)}">
							VALMIS TOIMITUKSEEN
						</c:if>
						
						<c:if test="${(tilaus.valmiina) && (tilaus.toimitettu)}">
							TOIMITETTU
						</c:if>
					</td>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tpizza">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><c:out value="${tpizza.pizza.pizzanimi}" /></td>
						<td>
							<c:if test="${tpizza.oregano}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.oregano}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.laktoositon}">EI</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">KYLLÄ</c:if> 
							<c:if test="${!tpizza.gluteeniton}">EI</c:if>
						</td>
						<td>
							<form action="TilausKontrolleri" method="post">
								<c:if test="${!tilaus.valmiina && !tilaus.toimitettu}">
									N/A
								</c:if>								
								<c:if test="${tilaus.valmiina}">
									<input type="hidden" value="${tilaus.tilausnro}" name="toiminro" />
	    							<input type="hidden" name="toimitettu" value="1" />
	    							<input type="hidden" name="toimitus" value="1" />
	    							<input type="submit" value="Toimitettu">
								</c:if>
							
							</form>
						</td>				
						<td>
							<form action="TilausKontrolleri" method="post">
                                 <input type="hidden" value="${tilaus.tilausnro}" name="tilausnro" />                                 
                                 <input type="hidden" name="palautus" value="0" />
                                 <input type="hidden" name="toimitus" value="1" />
                                <input type="submit" value="Palauta" />
                            </form>
						</td>
					</tr>
					</c:forEach>	
				</tr>
				</c:if>
				</c:if>
			</c:forEach>			
			</c:if> <!--  Toimittajan osuus loppuu -->
	
		
	</div>			
		</table>
		<table><!--  Vanhan jutun alakontrolleri -->
		<tr>
		 <form action="TilausKontrolleri" method="post">
		<c:forEach items="${tilauslista}" var="tilaus" varStatus="loop">
		<td>
		<input type="radio" name="tilnum" value="${tilaus.tilausnro}" required><c:out value="${tilaus.tilaajatunnus}" />
		</td>
		</c:forEach>
		</tr>
		<tr>
		<td>
		<input type="submit" value="Valitse tilaus" />
		</td>
		</form>
	<form action="TilausKontrolleri" method="post">
		
		<td>
		<input type="hidden" name="tilnum"" value="0" />
		<input type="submit" value="Reset" />
		</td>
		</tr>
	</form>
	</table><!-- Vanhan jutun alakontrollerin loppu, jälkeen  -->
	
		
	<table>
	<tr>
	<td>
	<form action="TilausKontrolleri" method="post">
	<input type="hidden" name="paistoon" value="1" />
		<input type="submit" value="Paistajalle" />
	</form>
	<form action="TilausKontrolleri" method="post">
	<input type="hidden" name="toimitus" value="1" />
		<input type="submit" value="Toimittajalle" />
	</form>	
	
	</td>
	</tr>
	
	
	</table>
	
	
	</c:if> <!-- näytä vain jos sessio on admin iffi loppuu tähän -->
</body>
</html>