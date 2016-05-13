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
<link rel="stylesheet" type="text/css" href="tyylit/tilauslista.css">
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
      <li><a href="Profiili">Hei, <c:out value="${sessionScope.nimi}" /></a></li><li><a href="Logout">Logout</a></li>
     
<!-- Logout loppuu tähän -->

      </ul>
    </div><!-- collapse navbar-collapse loppuu tähän -->
  </div><!-- container fluid loppuu tähän -->
</nav>

	<h1>Castello é Fiore / tilauslista</h1>
  <c:if test="${paistoon}"><h3>Paistajan sivu</h3></c:if>
<c:if test="${toimitukseen}"><h3>Toimittajan sivu</h3></c:if>

	<table><!-- tilauslistan valinta -->
		<tr>
			<td>
				<form action="TilausKontrolleri" method="post">
					<input type="hidden" name="tilnum"" value="0" />
					<button type="submit" value="Reset">Kaikki tilaukset</button>&nbsp;
				</form>
			</td>
			<td>
				<form action="TilausKontrolleri" method="post">
					<input type="hidden" name="paistoon" value="1" />
					<input style=" background-color: rgba(255,255,50,0.4);" type="submit" value="Paistajalle" />&nbsp;
				</form>
			</td>
			<td>
				<form action="TilausKontrolleri" method="post">
					<input type="hidden" name="toimitus" value="1" />
					<input style=" background-color: rgba(50,255,50,0.4);" type="submit" value="Toimittajalle" />&nbsp;
				</form>	
			</td>
		</tr>
	</table><!-- tilauslistan valinta loppuu tähän-->
<br>
<div>
	<div class="laatikko">
		<table border="1">
			<tr>
				<th>Tilausnro</th>
				<th>Tilausaika</th>
				<th>Tilaajatunnus</th>				
				<th>Toimitustapa</th>
				<th>Pizzat</th>
				<th>Oreg.</th>
				<th>Lakt.</th>
				<th>Glut.</th>
				<th>Hinta</th>
				<th>Tilan muutos</th>				
				<th>Palauta</th>
				<th>Tilauksen tila</th>
			</tr>
		<c:if test="${!poistalista}" >	
				<c:forEach items="${tilauslista}" var="tilaus">
				<c:if test="${tilaus.toimitettu}"><tr style="text-decoration: line-through; background-color: rgba(150,150,150,0.4);"></c:if>
				<c:if test="${!tilaus.toimitettu}"><tr style=" background-color: rgba(50,255,50,0.4);"></c:if>
				<c:if test="${!tilaus.valmiina}"><tr style=" background-color: rgba(255,255,50,0.4);"></c:if>
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:if test="${tilaus.toimitustapa == 'kotiinkuljetus'}">&#9936;</c:if><c:if test="${tilaus.toimitustapa == 'nouto'}">&#9977;</c:if> <c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="5"></td>
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
							<c:if test="${tpizza.oregano}">&#10004;</c:if> 
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">&#10004;</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">&#10004;</c:if>
						</td>
						<td style="text-align: right;">
							<fmt:setLocale value="fi" />
                        	<fmt:formatNumber value="${tpizza.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
						</td>
						<td>
						</td>				
						<td>
						</td>
					</tr>
					</c:forEach>	
				
			</c:forEach>
			</c:if>
			
			<!--  vanhan hirvityksen alku ja uuden version loppu -->
			
			<c:if test="${poistalista && !paistoon && !toimitus}">
			<c:if test="${empty tilauslista}"></table>LISTA ON TYHJÄ!</c:if>
			<c:if test="${not empty tilauslista}">
						
			<c:forEach items="${varalista}" var="tilaus" varStatus="loop">
				<c:if test="${loop.index <= 0 }">
				
				<c:if test="${tilaus.toimitettu}"><tr style="text-decoration: line-through; background-color: rgba(150,150,150,0.4);"></c:if>
				<c:if test="${!tilaus.toimitettu}"><tr style=" background-color: rgba(50,255,50,0.4);"></c:if>
				<c:if test="${tilaus.valmiina && !tilaus.toimitettu}"><tr style=" background-color: rgba(255,255,50,0.4);"></c:if>
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:if test="${tilaus.toimitustapa == 'kotiinkuljetus'}">&#9936;</c:if><c:if test="${tilaus.toimitustapa == 'nouto'}">&#9977;</c:if> <c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="7"></td>
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
							<c:if test="${tpizza.oregano}">&#10004;</c:if> 
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">&#10004;</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">&#10004;</c:if>
						</td>
						<td style="text-align: right;">
							<fmt:setLocale value="fi" />
                        	<fmt:formatNumber value="${tpizza.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
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
				</c:if>
			</c:forEach>
			</c:if>
			</c:if><!--  Vanhan hirvityksen loppu -->
		<!--  Paistajan osuus alkaa -->
		
		<c:if test="${paistoon}">			
				<c:forEach items="${tilauslista}" var="tilaus">				
				<tr style=" background-color: rgba(255,255,50,0.4);">
				<c:if test="${!tilaus.valmiina}">
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:if test="${tilaus.toimitustapa == 'kotiinkuljetus'}">&#9936;</c:if><c:if test="${tilaus.toimitustapa == 'nouto'}">&#9977;</c:if> <c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="5"></td>
					<td>
						<form action="TilausKontrolleri" method="post">
							<c:if test="${!tilaus.valmiina && !tilaus.toimitettu}">
								<input type="hidden" value="${tilaus.tilausnro}" name="valmisnro" />
    							<input type="hidden" name="valmis" value="1" />
    							<input type="hidden" name="paistoon" value="1" />
    							<input type="submit" value="Valmis">
							</c:if>
						</form>
					</td>
					<td>
					
					</td>
					<td>
						VASTAANOTETTU
					</td>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tpizza">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>
							&#9832; <b><c:out value="${tpizza.pizza.pizzanimi}" /></b>
							<br>
							<c:forEach items="${tpizza.pizza.taytteet}" var="tayte">
								<c:out value="${tayte}" />
							</c:forEach>
						</td>
						<td>
							<c:if test="${tpizza.oregano}">&#10004;</c:if>
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">&#10004;</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">&#10004;</c:if>
						</td>
						<td style="text-align: right;">
							<fmt:setLocale value="fi" />
                        	<fmt:formatNumber value="${tpizza.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
						</td>
						<td>
						</td>				
					</tr>
					</c:forEach>	
				</c:if>
			</c:forEach>
			</c:if> <!--  Paistajan osuus loppuu -->
			
			<!--  Toimittajan osuus alkaa -->
	
	
	<c:if test="${toimitukseen}">	
				<c:forEach items="${tilauslista}" var="tilaus">				
				<tr style=" background-color: rgba(50,255,50,0.4);">
				<c:if test="${tilaus.valmiina}"><c:if test="${!tilaus.toimitettu}">
					<td><c:out value="${tilaus.tilausnro}" /></td>
					<td><c:out value="${tilaus.tilausaika}" /></td>
					<td><c:out value="${tilaus.tilaajatunnus}" /></td>				
					<td><c:if test="${tilaus.toimitustapa == 'kotiinkuljetus'}">&#9936;</c:if><c:if test="${tilaus.toimitustapa == 'nouto'}">&#9977;</c:if> <c:out value="${tilaus.toimitustapa}" /></td>
					<td colspan="5"></td>
					<td>
						<form action="TilausKontrolleri" method="post">
							<input type="hidden" value="${tilaus.tilausnro}" name="toiminro" />
   							<input type="hidden" name="toimitettu" value="1" />
   							<input type="hidden" name="toimitus" value="1" />
   							<input type="submit" value="Toimitettu">
						</form>
					</td>
					<td></td>
					<td>
						VALMIS TOIMITUKSEEN
					</td>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tpizza">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><c:out value="${tpizza.pizza.pizzanimi}" /></td>
						<td>
							<c:if test="${tpizza.oregano}">&#10004;</c:if>
						</td>
						<td>
							<c:if test="${tpizza.laktoositon}">&#10004;</c:if>
						</td>
						<td>
							<c:if test="${tpizza.gluteeniton}">&#10004;</c:if>
						</td>
						<td style="text-align: right;">
							<fmt:setLocale value="fi" />
                        	<fmt:formatNumber value="${tpizza.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
						</td>
						<td>
						</td>				
						<td>
						</td>
					</tr>
					</c:forEach>	
				</c:if>
				</c:if>
			</c:forEach>			
			</c:if> <!--  Toimittajan osuus loppuu -->
	
		</table>
	</div>
	
	<div class="laatikko">
		<form action="TilausKontrolleri" method="post">
			<table><!--  Vanhan jutun alakontrolleri -->
				<tr>
					<th><h3>Tilaajat</h3></th>
					<td style="vertical-align: middle;">
						<input type="submit" value="Valitse tilaus" />
					</td>
				</tr>
				<c:forEach items="${tilauslista}" var="tilaus" varStatus="loop">
					<tr>
						<td>
							<input type="radio" name="tilnum" value="${tilaus.tilausnro}" required><c:out value="${tilaus.tilaajatunnus}" />
						</td>
					</tr>
				</c:forEach>
			</table><!-- Vanhan jutun alakontrollerin loppu, jälkeen  -->
		</form>
	</div>		
</div>	
	

	
	
	</c:if> <!-- näytä vain jos sessio on admin iffi loppuu tähän -->
</body>
</html>
