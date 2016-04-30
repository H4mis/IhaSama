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
<link rel="stylesheet" type="text/css" href="tyylit/tyyli.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Merienda:700' rel='stylesheet' type='text/css'>
<title>Tilauslista</title>

</head>
<body>
<c:if test="${!sessionScope.admin}"><c:redirect url="TiedoteKontrolleri"/></c:if>

<c:if test="${sessionScope.admin}">
	<nav class="navbar navbar-inverse">

		<div>
			<ul class="nav navbar-nav">

				<li><a href="TiedoteKontrolleri">Etusivu</a></li>
				<li><a href="asiakasKontrolleri">Menu</a></li>				
				<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				 <c:if test="${sessionScope.admin}"><li><a href="Kontrolleri">Admin</a></li></c:if>
      <c:if test="${not empty sessionScope.kayttajatunnus}"><li><a>Hei, <c:out value="${sessionScope.nimi}" /></a>. <a href="Logout">Logout</a></li></c:if>
     <c:if test="${empty sessionScope.kayttajatunnus}"> <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Login <span class="glyphicon glyphicon-log-in"></span></a>
          <div class="dropdown-menu">
            <form id="formLogin" class="form container-fluid" method="post" action="LoginKontrolleri">
              <div class="form-group">
                <label for="usr">Käyttäjätunnus:</label>
                <input type="text" class="form-control" id="usr" name="kayttajatunnus">
              </div>
              <div class="form-group">
                <label for="pwd">Salasana:</label>
                <input type="password" class="form-control" id="pwd" name="salasana">
              </div>
              <input type="hidden" name="from" value="${kukkuluuruu}">
              <button type="submit" id="btnLogin" class="btn btn-block">Login</button>
            </form>
            	<c:if test="${not empty param.LoginSuccess}"><h3 style="color: green;">Kirjautuminen onnistui!</h3></c:if>
       <c:if test="${not empty param.LoginNoSuccess}"><h3 style="color: green;">Kirjautuminen epäonnistui!</h3></c:if>
          </div>
        </li>   
            	</c:if>
			</ul>
		</div>

	</nav>

	<h1>Castello é Fiore</h1>

	<div id="laatikko">
		<table>
			<tr>
				<td><p>Tilausnro</p></td>
				<td><p>Tilausaika</p></td>
				<td><p>Tilaajatunnus</p></td>				
				<td><p>Toimitustapa</p></td>
				<td><p>Pizzat</p></td>
				<td><p>Oregano</p></td>
				<td><p>Laktoositon</p></td>
				<td><p>Gluteeniton</p></td>
				<td><p>Tilan muutos</p></td>				
				<td><p>Palauta</p></td>
				<td><p>Tilauksen tila</p></td>
			</tr>
			<c:if test="${empty tilauslista}">
			</table>LISTA ON TYHJÄ!!!!!</c:if>
			<c:if test="${not empty tilauslista}">
			<c:forEach items="${tilauslista}" var="tilaus" varStatus="loop">
				<tr>
				
					<td>
						<c:if test="${tilaus.toimitettu}">
							<div style="text-decoration: line-through;">
								<c:out value="${tilaus.tilausnro}" />
							</div>
						</c:if>
						<c:if test="${!tilaus.toimitettu}">
							<c:out value="${tilaus.tilausnro}" />
						</c:if>
					</td>
					<td>
						
						<c:out value="${tilaus.tilausaika}" />
					</td>
					<td>
						<c:out value="${tilaus.tilaajatunnus}" />
					</td>
					
					<td>
						<c:out value="${tilaus.toimitustapa}" />
					</td>
				
					
					<c:forEach items="${tilaus.tilatutPizzat}" var="tilatut" varStatus="loop2">					
					
					
					key: <c:out value="${tilaus.tilausnro}" /> val: <c:out value="${tilaus.pizzantilausAvuste[loop.index]}" /> 
							<c:if test="${(tilaus.tilausnro eq tilatut.tilausnro) and (tilaus.pizzantilausAvuste[loop.index] eq tilatut.pizzatilausId)}">
						 		<td>
							 		<c:out value="${tilatut.pizza.pizzanimi}" />
								</td>
						 		<td>
									<c:if test="${tilatut.oregano}">KYLLÄ</c:if> 
									<c:if test="${!tilatut.oregano}">EI</c:if>
								</td>
								<td>
								<c:if test="${tilatut.laktoositon}">KYLLÄ</c:if> 
								<c:if test="${!tilatut.laktoositon}">EI</c:if>
								</td>
								<td>
								<c:if test="${tilatut.gluteeniton}">KYLLÄ</c:if> 
								<c:if test="${!tilatut.gluteeniton}">EI</c:if>
								</td>							
							</c:if>
							<form action="TilausKontrolleri" method="post">
							
	  <c:if test="${(tilaus.tilausnro == tilatut.tilausnro) and (tilaus.pizzantilausAvuste[loop.index] == tilatut.pizzatilausId)}">
	    							
	    							<c:if test="${!tilaus.valmiina}">
	    							<td>
	    							<input type="hidden" value="${tilaus.tilausnro}" name="valmisnro" />
	    							<input type="hidden" name="valmis" value="1" />
	    								<input type="submit" value="Valmis">
	    							</td>
	    							</c:if>
	    							<c:if test="${(tilaus.valmiina) && (!tilaus.toimitettu)}">
	    							<td>
	    							<input type="hidden" value="${tilaus.tilausnro}" name="toiminro" />
	    							<input type="hidden" name="toimitettu" value="1" />
	    								<input type="submit" value="Toimitettu"></td>							
	    							</c:if>      
                               </form>
                               <c:if test="${(tilaus.valmiina) && (tilaus.toimitettu)}">
	    							<td>
	    							N/A
	    							</td>
	    							</c:if>
                               
                               
                               <form action="TilausKontrolleri" method="post">
                                <td>
                                 <input type="hidden" value="${tilaus.tilausnro}" name="tilausnro" />                                 
                                 <input type="hidden" name="palautus" value="0" />
                                <input type="submit" value="Palauta" />
                                </td>
                                </form>
	    							
	    							
	    							
	    							
	    							<c:if test="${(!tilaus.valmiina) && (!tilaus.toimitettu)}">
	    							<td>
	    							VASTAANOTETTU
	    							</td>
	    							</c:if>
	    							
	    							<c:if test="${(tilaus.valmiina) && (!tilaus.toimitettu)}">
	    							<td>
	    							VALMIS TOIMITUKSEEN
	    							</td>
	    							</c:if>
	    							
	    							<c:if test="${(tilaus.valmiina) && (tilaus.toimitettu)}">
	    							<td>
	    							TOIMITETTU
	    							</td>
	    							</c:if>
	    							
	    						</c:if>
					
	
					</c:forEach>					
				</tr>
				
			</c:forEach>
			</c:if>
		</table>
	
	</div>	
	</c:if>
</body>
</html>