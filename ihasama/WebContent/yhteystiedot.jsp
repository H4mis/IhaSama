<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="luokat.Pizza"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="jquery-1.12.0.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- sosiaalinen media kuvat -->
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="tyylit/Index.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Merienda:700' rel='stylesheet' type='text/css'>
<title>Yhteystiedot</title>

<!--
  <style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
    margin-left:auto;
    margin-right:auto;
}
th, td {
    padding: 5px;
    text-align: left; 
     
}
</style>
-->
</head>
<body>

<nav class="navbar navbar-inverse">
 
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
      
     	<li><a  href="TiedoteKontrolleri">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<c:if test="${empty sessionScope.kayttajatunnus}"><li><a  href="rekisterointi.jsp">Rekisteröinti</a></li></c:if>
		<li><a class="active" href="yhteystiedot.jsp">Yhteystiedot</a></li>
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
		      			<td ><c:out value="${kori.pizza.pizzanimi}" />&nbsp;</td>
		      			<td ><fmt:formatNumber value="${kori.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€</td>
		      			<td>
		      				<form action="KoriKontrolleri" method="post">
		      					<input type="hidden" value="yhteystiedot.jsp" name="taaltatulen" />
				            	<input type="hidden" value="${index}" name="poistopizza" />
				            	<button id="buttonPoista" type="submit" value="Poista">X</button>
				       		 </form>
		      			</td>
	      			</tr>
	      			<c:set var="index" value="${index+1}" />
	      		</c:forEach>
	      		<tr>
	      			<td colspan="2">
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
              <input type="hidden" name="from" value="${pageContext.request.requestURI}">
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
<h1>Castello é Fiore</h1>
 <div class="marginblock">  
 <div id="laatikko">
 
<br>
 <br> 
 <br> 

    <h2>Ota yhteyttä<hr></h2>
     <br>
    <table style="width:100%;">
    
  <tr>
    <th style="text-align:right;vertical-align:top;">Email:</th>
    <td style="text-align:left;color:orange;"> &nbsp;castelloefiore@castello.fi</td>
  </tr>
  <tr>
    <th style="text-align:right;vertical-align:top;">Puh:</th>
    <td style="text-align:left;color:orange;">&nbsp;+35850667832</td>
  </tr>

  <tr>
    <th style="text-align:right;vertical-align:top;">Osoite:</th>
    <td style="text-align:left;color:orange;">&nbsp;Sibeliuksenkatu 7, Hämeenlinna</td>
  </tr> 
</table>
            </textarea>
            <br>
            <br>    

            
<h3>Kartta</h3>
 <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2466.028070132561!2d24.461779116511266!3d60.99617808330837!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x468e5d970c10edb3%3A0xa654c8617544564e!2sSibeliuksenkatu+7%2C+13100+H%C3%A4meenlinna!5e1!3m2!1sfi!2sfi!4v1459936427659" width="300" height="300" frameborder="0" style="border:0"  allowfullscreen></iframe>
 <br> 
 <br> 
 <h2>Anna meille palautetta!</h2>
  <form action="PalauteKontrolleri" method="POST">

Sähköpostiosoite: <br>
<input type="text" name="email"><br>
<br>

Aihe: <br>
<input type="text" name="aihe"><br>
<br>

Palaute: <br>
<textarea name="palaute" rows="10" width=100%></textarea><br><br>

<button type="submit" value="Lähetä">Lähetä</button>
 </div>
</div>
  
 
</form>

 <footer class="footer">
     <div class="container">
        <ul id="sosiaalinenmedia">
        
			<li id="facebook"><a href="http://facebook.com/"><i class="fa fa-facebook"></i></a></li>
			<li id="linkedin"><a href="http://linkedin.com/"><i class="fa fa-linkedin"></i></a></li>
			<li id="twitter"><a href="http://twitter.com/"><i class="fa fa-twitter"></i></a></li>
	
			<div class="clr"></div>

		</ul>
 	 </div>
   
 </footer>
</body>

</html>