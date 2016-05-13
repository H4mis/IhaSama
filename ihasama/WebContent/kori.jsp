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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

 <!-- Custom styles for this template -->
    <link href="sticky-footer-navbar.css" rel="stylesheet">
    
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="tyylit/Index.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- sosiaalinen media kuvat -->
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">

<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Merienda:700' rel='stylesheet' type='text/css'>
<title>Index</title>
<title>Ostoskori</title>

</head>
<body><nav class="navbar navbar-inverse">
 <div class="container-fluid">
  <div class="navbar-header">
     <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
     <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>    
   </div>
    
    <div class="collapse navbar-collapse" id="myNavbar">
    
      <ul class="nav navbar-nav">
      
     	<li><a class="active" href="TiedoteKontrolleri">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<c:if test="${empty sessionScope.kayttajatunnus}"><li><a  href="rekisterointi.jsp">Rekisteröinti</a></li></c:if>
		<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${sessionScope.admin}"><li><a href="Kontrolleri">Admin</a></li></c:if>
     
     
<!-- ostoskori dropdown -->
     <li class="dropdown" ><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-shopping-cart"></span>Ostoskori <fmt:formatNumber value="${sessionScope.yht}" type="number" minFractionDigits="2" maxFractionDigits="2" />€</a>
	      <div class="dropdown-menu">
	     	 <table>
	     	 	<c:set var="index" value="${0}" />
	      		<c:forEach items="${sessionScope.kori}" var="kori">
	      			<tr>
		      			<td><div id="koriDrop">${kori.pizza.pizzanimi}</div>&nbsp;</td>
		      			<td><fmt:formatNumber value="${kori.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€</td>
		      			<td>
		      				<form action="KoriKontrolleri" method="post">
		      					<input type="hidden" value="TiedoteKontrolleri" name="taaltatulen" />
				            	<input type="hidden" value="${index}" name="poistopizza" />
				            	<button id="buttonPoista" type="submit" value="Poista">X</button>
				       		 </form>
		      			</td>
	      			</tr>
	      			<c:set var="index" value="${index+1}" />
	      		</c:forEach>
	      		<tr>
	      			<td id="puhelinKori" colspan="2">
		      			<c:if test="${not empty sessionScope.kori}">
		      				<form action="KoriKontrolleri">
		      					<input type="hidden" name="toiminto" value="Tilaa">
		      					<button id="buttonTilaa" type="submit">Siirry tilaamaan!</button>
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
              <input type="hidden" name="from" value="${mistatulen}">
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
 </div> 
</nav>

	<h1  style="font-family: 'Dancing Script', cursive;font-size:100px;">Castello é Fiore</h1>
	
	<div class="marginblock">
 	<div id="laatikko">
 	
	<h2 style="font-family: 'Merienda', cursive;">Ostoskorisi <hr></h2>
	<br>
 
	<form action='asiakasKontrolleri'>Lisää pizzoja listaan <button type='submit' value='tästä'>Tästä</button></form>
	<br>
	<br>
	
	<div class="marginblock">
	
	<table>
	
		<tr>
		<td></td>
		</tr>
		<c:if test="${empty korilista}">Ostoskorisi on tyhjä!</c:if>
		<c:if test="${not empty korilista}">
			<c:set var="index" value="${0}" />
		<c:forEach items="${korilista}" var="kori" varStatus="loop">
			<tr>
			
				<td style="color:lightgrey;">
					<c:out value="${kori.pizza.pizzanimi}" />
					<br>
					<p style="color:orange;">
						<c:if test="${kori.oregano}">&nbsp;Oregano,&nbsp; </c:if> 
						<c:if test="${kori.laktoositon}">Lakt,&nbsp; </c:if> 
						<c:if test="${kori.gluteeniton}">Glut&nbsp; </c:if>
					</p> 
				</td>
				<td style="color:lightgrey;">
					<fmt:setLocale value="fi"/>
					<fmt:formatNumber value="${kori.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
				</td>
				<td style="color:lightgrey;">
					<form action="KoriKontrolleri" method="post">
						<input type="hidden" value="KoriKontrolleri" name="taaltatulen" />
			            <input type="hidden" value="${index}" name="poistopizza" />
			            <button id="buttonPoista" type="submit" value="Poista" >X</button>
			        </form>
			    </td>
			</tr>
			<c:set var="index" value="${index+1}" />
		</c:forEach>	
	</table>
</div>	
	<form action="asiakasKontrolleri" method="post">
	   <input type="hidden" value="${korilista}" name="tilattavat" />
      <br>
   yhteensä: <fmt:setLocale value="fi"/>
			<fmt:formatNumber value="${yht}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
	 <br> 		
 <br> <select style="color:black;" id="toimitus" name="toimitus">
            <option value="1">Nouto</option>
            <option value="2">Kotiinkuljetus</option>
        
        </select>
        <br>
         <br>
         <div id="maksutapa">
         <table>
        <tr>
        <th></th>
        <td style="color:lightgrey; text-align:left;"><input type="radio" name="maksu" value="Korttimaksu"> Verkkopankki</td>
        </tr>
        <tr>
        <th></th>
        <td style="color:lightgrey; text-align:left;" ><input type="radio" name="maksu" value="Verkkomaksu"> Maksu toimituksen yhteydessä (käteinen tai kortti)</td>
        </tr>
        <tr>
        <th style="vertical-align:top;">Katuosoite:</th>
        <td><input type="text" name="katuosoite" value="${osoite}"></td>
        </tr>
        <tr>
        <th style="vertical-align:top;"> Postinumero:</th>
        <td><input type="text" name="posti" value="${postinro}"/></td>
        </tr>
        <tr>
        <th style="vertical-align:top;"> Toimipaikka:</th>
        <td><input type="text" name="postitmp" value="${postitmp}"/></td>
        </tr>
        </table>
 </div>

  <br>
   <br> 
  <c:if test="${not empty sessionScope.kayttajatunnus}">
  	<input hidden="true" name="kayttajatunnus" value="${sessionScope.kayttajatunnus}" />
  	<button type="submit" name="toiminto" value="vahvistaTilaus">vahvista tilaus</button>
  </c:if>
</form>
<c:if test="${empty sessionScope.kayttajatunnus}">
 	<a href="rekisterointi.jsp" style="color:Lightgrey; text-decoration:bold; text-decoration:underline;">Rekisteröidy</a> <p style="color:orange;">tai Kirjaudu sisään.</p>
 	<form method="post" action="LoginKontrolleri">
      	<table>
	       	<tr>
	       		<td style="color:lightgrey;">
	       			Käyttäjätunnus: 
	       		</td>
	       		<td>
	       			<input type="text" pattern='([a-z]|[A-Z]|[0-9]|(_-.+)).{8,45}' title='Kirjoita käyttäjätunnus oikein!' name="kayttajatunnus"/>
	       		</td>
	       	</tr>
			<tr>
	       		<td style="color:lightgrey;">
	       			Salasana: 
	       		</td>
	       		<td>
				<input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title='Kirjoita salasana oikein!' name="salasana"/>
	       		</td>
	       	</tr>
	       	<tr>
	       		<td>
	       			
	       		</td>
	       		<td>
	       		<input type="hidden" name="from" value="KoriKontrolleri">
				<button id="buttonTilaa" type="submit" value="Kirjaudu">Kirjaudu</button>
	       		</td>
	       	</tr>
   		</table>	
	</form>
</c:if>
  
    
	</c:if>
	<br>
	<br>
	
	<c:if test="${not empty sessionScope.kayttajatunnus}">
		<form action="KoriKontrolleri" method="post" accept-charset="utf-8">
		<h2 style="font-family: 'Merienda', cursive;">Tilaajan Tiedot</h2><hr>
			<table>
				<tr>
					<th style="vertical-align:top;">käyttäjätunnus</th>
					<td style="color:lightgrey;"><c:out value="${sessionScope.kayttajatunnus}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">etunimi&nbsp;</th>
					<td><input type="text" name="etunimi" value="${etunimi}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">sukunimi&nbsp;</th>
					<td><input type="text" name="sukunimi" value="${sukunimi}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">sähköposti&nbsp;</th>
					<td><input type="text" name="sahkoposti" value="${sahkoposti}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">katuosoite&nbsp;</th>
					<td><input type="text" name="osoite" value="${osoite}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">postinumero&nbsp;</th>
					<td>
						<input type="text" name="postinro" value="${postinro}"/>
					</td>
				</tr>
				<tr>
					<th style="vertical-align:top;">postitoimipaikka&nbsp;</th>
					<td><input type="text" name="postitmp" value="${postitmp}"/></td>
				</tr>
				<tr>
					<td></td>
					<td><button type="submit" name="toiminto" value="muutaTietoja">muuta</button></td>
				</tr>
			</table>
		</form>
	</c:if>
</div>
</div>

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
<br>
<br>
<br>
<footer class="footer">
     <div class="container">
        <ul id="sosiaalinenmedia">
        
			<li id="facebook"><a href="http://facebook.com/"><i class="fa fa-facebook"></i></a></li>
			<li id="linkedin"><a href="http://linkedin.com/"><i class="fa fa-linkedin"></i></a></li>
			<li id="twitter"><a href="http://twitter.com/"><i class="fa fa-twitter"></i></a></li>
			
			

		</ul>
 	 </div>
   
 </footer>
</body>
</html>