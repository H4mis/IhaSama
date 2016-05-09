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
      
     	<li><a class="active" href="TiedoteKontrolleri">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<c:if test="${empty sessionScope.kayttajatunnus}"><li><a  href="rekisterointi.jsp">Rekisteröinti</a></li></c:if>
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
		      			<td id="koriDrop"><c:out value="${kori.pizza.pizzanimi}" /></td>
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
	      			<td>
		      			<c:if test="${not empty sessionScope.kori}">
		      				<form action="KoriKontrolleri">
		      					<input type="hidden" name="toiminto" value="Tilaa">
		      					<button id="buttonTilaa" type="submit">tilaa</button>
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



<h1 style="font-family: 'Dancing Script', cursive;font-size:100px;">Castello é Fiore</h1>
<div class="marginblock">
 <div id="laatikko">
    <h2 style="font-family: 'Merienda', cursive;">Tervetuloa</h2>
    
    <p>
    <p style="color:orange;">Tervetuloa Castello é Fiore- ravintolan kotisivuille! </p>
    <br>
    
    <p>Olemme pieni perheyritys, arvojamme ovat mm. upeiden makuelämysten tarjoaminen sekä hyvä tunnelma. Tavoitteemme on
    taata asiakkaille korkealaatuista palvelua, ja korkealuokkaisista raaka-aineista tehtyjä gourmet- pizzoja.
    Laadukkaat raaka-aineet, ekologisuus, ystävällisyys ja mukava ilmapiiri ovat arvoja, joita noudattaen 
    työskentelemme joka ikinen päivä.
    <br>
    <br>
    Sivuiltamme voit tilata haluamiasi pizzoja valitsemaasi osoitteeseen ja nauttia upeista makuelämyksistä siellä missä itse haluat. 
    Menu- välilehdeltä voit valita haluamasi pizzat ja tilata ne kotiinkuljetettuina haluamaasi osoitteeseen. 
    Voit myös soittaa suoraan ravintolaamme ja tehdä pöytävarauksen.
    <br>
    <br>
    Siirry tilaamaan <a href="asiakasKontrolleri">tästä</a>.
     
     <br>
     <br>
     <br>
     </p>
   
 <p style="color:orange;"> ~henkilökunta </p>
     <br>
     <br>
     <p>
     <table >
     <c:forEach items="${tiedotelista}" var="tiedote">
                    
        
                        	<c:if test="${!tiedote.piilossa}">
                                
                            </c:if>                            
                            <c:if test="${tiedote.piilossa}">
                            <tr>
                            <td id="tiedotelaatikko">
                                <c:out value="${tiedote.tiedote}" />
                                </td>
                                </tr>
                            </c:if>                            
                        
                        
                        </c:forEach>
                        </table>
  
    
 </div>
</div> 
<br>


<!-- Myynti kikka laatikot alkavat täsäää!!!! -->

<div class="usp">
	<div class="marginblock">
	   <div id="laatikko1">
	   <img src="kuvat/autojpg.jpg" alt="AutoKuljetus" style="width:150px;height:75px;border-radius:60%;opacity:0.9;">
	 		<p> NOPEAT KULJETUKSET
	 			<br> & <br>Yli 20 € tilauksille ilmainen kotiin kuljetus</p>
	 	</div>
	 	
	  	<div id="laatikko1">
	  		<img src="kuvat/tomaatti.jpg" alt="AutoKuljetus" style="width:75px;height:75px;border-radius:60%;opacity:0.9;">
	  		<p> 100% TYYTYVÄISYYSTAKUU,<br> jos et pidä tuotteesta palautamme rahanne
	  		<br><br>
	  		 </p>
	 	</div>
	 	
	  <!--  	<div id="laatikko1">
	  		<img src="kuvat/autojpg.jpg" alt="AutoKuljetus" style="width:150px;height:75px;border-radius:60%;">
	  		<p> Unique Selling Proposition (USP)</p>
	  </div> -->
  </div>	
</div>
<!-- loppuu tähän -->














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
  
     <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    
    
</body>

</html>