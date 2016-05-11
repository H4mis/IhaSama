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
<title>Ostoskori</title>

</head>
<body>	<nav class="navbar navbar-inverse">

		<div>
			<ul class="nav navbar-nav">

				<li><a href="TiedoteKontrolleri">Etusivu</a></li>
				<li><a href="asiakasKontrolleri">Menu</a></li>
				<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>			
				<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				 <c:if test="${sessionScope.admin}"><li><a href="Kontrolleri">Admin</a></li></c:if>
				 
<!-- ostoskori dropdown -->
     <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-shopping-cart"></span>Ostoskori <fmt:formatNumber value="${sessionScope.yht}" type="number" minFractionDigits="2" maxFractionDigits="2" />€</a>
	      <div class="dropdown-menu">
	     	 <table>
	     	 	<c:set var="index" value="${0}" />
	      		<c:forEach items="${sessionScope.kori}" var="kori">
	      			<tr>
		      			<td><c:out value="${kori.pizza.pizzanimi}" /></td>
		      			<td><fmt:formatNumber value="${kori.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€</td>
		      			<td>
		      				<form action="KoriKontrolleri" method="post">
		      					<input type="hidden" value="KoriKontrolleri" name="taaltatulen" />
				            	<input type="hidden" value="${index}" name="poistopizza" />
				            	<input type="submit" value="Poista" />
				       		 </form>
		      			</td>
	      			</tr>
	      			<c:set var="index" value="${index+1}" />
	      		</c:forEach>
	      		<tr>
	      			<td>
		      			<c:if test="${not empty sessionScope.kori}">
		      				<form action="TilausKontrolleri">
		      					<input type="hidden" name="toiminto" value="Tilaa">
		      					<button type="submit">tilaa</button>
		      				</form>
		      			</c:if>
		      			<c:if test="${empty sessionScope.kori}">Ostoskori on tyhjä</c:if>
	      			</td>
	      		</tr>
	      	</table>
	      </div>
      <li>
<!-- ostoskori dropdown loppuu tähän -->
      
<!-- Login/logout -->
      <c:if test="${not empty sessionScope.kayttajatunnus}"><li><a>Hei, <c:out value="${sessionScope.nimi}" /></a></li><li><a href="Logout">Logout</a></li></c:if>
     <c:if test="${empty sessionScope.kayttajatunnus}"> <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Login <span class="glyphicon glyphicon-log-in"></span></a>
          <div class="dropdown-menu">
            <form id="formLogin" class="form container-fluid" method="post" action="LoginKontrolleri">
              <div class="form-group">
                <label for="usr">Käyttäjätunnus:</label>
                <input type="text" pattern='([a-z]|[A-Z]|[0-9]|(_-.+)).{8,45}' title='Kirjoita käyttäjätunnus oikein!' class="form-control" id="usr" name="kayttajatunnus">
              </div>
              <div class="form-group">
                <label for="pwd">Salasana:</label>
                <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title='Kirjoita salasana oikein!' class="form-control" id="pwd" name="salasana">
              </div>
              <input type="hidden" name="from" value="KoriKontrolleri">
              <button type="submit" id="btnLogin" class="btn btn-block">Login</button>
            </form>
            	<c:if test="${not empty param.LoginSuccess}"><h3 style="color: green;">Kirjautuminen onnistui!</h3></c:if>
       <c:if test="${not empty param.LoginNoSuccess}"><h3 style="color: green;">Kirjautuminen epäonnistui!</h3></c:if>
          </div>
        </li>   
      </c:if>
<!-- Login/logout loppuu tähän -->

			</ul>
		</div>

	</nav>

	<h1>Castello é Fiore</h1>
	
	<h1>Ostoskorisi</h1>
	<form action='asiakasKontrolleri'>Lisää pizzoja listaan <input type='submit' value='tästä'></form>
	Ostoskori:
	<table border="1">
		<tr>
			<td>Pizzan nimi</td>
			<td>Hinta</td>
			<td>Oregano</td>
			<td>Laktoositon</td>
			<td>Gluteeniton</td>			
		</tr>
		<c:if test="${empty korilista}"></table>Ostoskorisi on tyhjä!</c:if>
		<c:if test="${not empty korilista}">
			<c:set var="index" value="${0}" />
		<c:forEach items="${korilista}" var="kori" varStatus="loop">
			<tr>
				<td>
					<c:out value="${kori.pizza.pizzanimi}" />
				</td>
				<td>
					<fmt:setLocale value="fi"/>
					<fmt:formatNumber value="${kori.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
				</td>
				<td>
			    	<c:if test="${kori.oregano}">Oreganoa</c:if> 
					<c:if test="${!kori.oregano}">Ei oreganoa</c:if>
				</td>
				<td>
					<c:if test="${kori.laktoositon}">Laktoositon</c:if> 
					<c:if test="${!kori.laktoositon}">Ei laktoositon</c:if>
				</td>
				<td>
					<c:if test="${kori.gluteeniton}">Gluteeniton</c:if> 
					<c:if test="${!kori.gluteeniton}">Ei gluteeniton</c:if>
				</td>
				<td>
					<form action="KoriKontrolleri" method="post">
						<input type="hidden" value="KoriKontrolleri" name="taaltatulen" />
			            <input type="hidden" value="${index}" name="poistopizza" />
			            <input type="submit" value="Poista" />
			        </form>
			    </td>
			</tr>
			<c:set var="index" value="${index+1}" />
		</c:forEach>	
	</table>
	<form action="asiakasKontrolleri" method="post">
	   <input type="hidden" value="${korilista}" name="tilattavat" />
      <br>
   yhteensä: <fmt:setLocale value="fi"/>
			<fmt:formatNumber value="${yht}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
	 <br> 		
 <br> <select id="toimitus" name="toimitus">
            <option value="1">Nouto</option>
            <option value="2">Kotiinkuljetus</option>
        
        </select>
  <div id="maksutapa">
  <br><input type="radio" name="maksu" value="Korttimaksu"> Verkkopankki<br>
  <input type="radio" name="maksu" value="Verkkomaksu"> Maksu toimituksen yhteydessä(käteinen tai kortti)<br>
  <br>
  Katuosoite: <input type="text" name="katuosoite" value="${osoite}"><br>
  <c:if test="${postinro == -1}">
   Postinumero: <input type="text" name="posti" value=""/><br>
  </c:if>
  <c:if test="${postinro != -1}">
   Postinumero: <input type="text" name="posti" value="${postinro}"/><br>
  </c:if>
  Toimipaikka:<input type="text" name="postitmp" value="${postitmp}"/><br>


  </div>
  <br>
   <br> 
  <c:if test="${not empty sessionScope.kayttajatunnus}">
  	<input hidden="true" name="kayttajatunnus" value="${sessionScope.kayttajatunnus}" />
  	<button type="submit" name="toiminto" value="vahvistaTilaus">vahvista tilaus</button>
  </c:if>
</form>
<c:if test="${empty sessionScope.kayttajatunnus}">
 	<a href="rekisterointi.jsp">Rekisteröidy</a> tai Kirjaudu sisään.
 	<form method="post" action="LoginKontrolleri">
      	<table>
	       	<tr>
	       		<td>
	       			Käyttäjätunnus: 
	       		</td>
	       		<td>
	       			<input type="text" pattern='([a-z]|[A-Z]|[0-9]|(_-.+)).{8,45}' title='Kirjoita käyttäjätunnus oikein!' name="kayttajatunnus"/>
	       		</td>
	       	</tr>
			<tr>
	       		<td>
	       			Salasana: 
	       		</td>
	       		<td>
				<input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title='Kirjoita salasana oikein!' name="salasana"/>
	       		</td>
	       	</tr>
	       	<tr>
	       		<td>
	       			Kirjaudu
	       		</td>
	       		<td>
	       		<input type="hidden" name="from" value="KoriKontrolleri">
				<input type="submit" value="Kirjaudu" />
	       		</td>
	       	</tr>
   		</table>	
	</form>
</c:if>
  
    
	</c:if>



</body>
<script>
$(document).ready(function () {
    toggleFields(); //call this first so we start out with the correct visibility depending on the selected form values
    //this will call our toggleFields function every time the selection value of our underAge field changes
    $("#toimitus").change(function () {
        toggleFields();
    });

});
//this toggles the visibility of our parent permission fields depending on the current selected value of the underAge field
function toggleFields() {
    if ($("#toimitus").val() == 2)
        $("#maksutapa").show();
   
    else
        $("#maksutapa").hide();
   
}
</script>
</body>
</html>