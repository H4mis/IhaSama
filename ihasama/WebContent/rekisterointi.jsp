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
<title>Rekisteröinti</title>

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
		<li><a class="active" href="rekisterointi.jsp">Rekisteröinti</a></li>
		<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${sessionScope.admin}"><li><a href="Kontrolleri">Admin</a></li></c:if>
      <li></li>
      
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
		      				<form action="TilausKontrolleri">
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
              <input type="hidden" name="from" value="/TiedoteKontrolleri">
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
</nav> <!--  ylä-navi loppuu tähän -->

<!-- varsinainen sivu alkaa tästä -->
<h1>Castello é Fiore</h1>

	
	
        <!-- Rekisteröitymis lomake -->
    <div class="marginblock">    
    <div id="laatikko">
    	<c:if test="${empty param.registrationSuccess}">
	    <h2 style="color:lightgrey;">Rekisteröinti</h2>
	    <hr>
	         <form method="post" action="RekisterointiKontrolleri">
	            <table>
	                <thead>
	                    <tr>
	                        <th colspan="2" style="color:orange">Täytä tietosi tähän, * on pakollinen kohta</th>
	                        
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td style="text-align:right;color:lightgrey;">Etunimi *</td>
	                        <td><input required type="text" pattern='([a-z]|[A-Z]){1,60}' title='Käytä vain aakkosia!'  name="etunimi" value="" /></td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:right;color:lightgrey;"> Sukunimi *</td>
	                        <td><input required type="text" pattern='([a-z]|[A-Z]){1,60}' title='Käytä vain aakkosia!' name="sukunimi" value="" /></td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:right;color:lightgrey;">Sähköposti *</td>
	                        <td><input required type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" title='Kirjoita sähköposti oikein! esim: esimerkki@esimerkkimaili.fi' name="sahkoposti" value="" /></td>
	                    </tr>
	                    <tr>
	                        <td><br></td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:right;color:lightgrey;">Käyttäjätunnus *</td>
	                        <td><input required type="text" pattern='([a-z]|[A-Z]|[0-9]|(_-.+)).{8,45}' title='Käyttäjätunnus voi sisältää vain merkkejä "A-Z", "a-z", "_" tai "-" ja käyttäjätunnuksen pitää olla vähintään 8 merkkiä!' name="kayttajatunnus" value="" /></td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:right;color:lightgrey;">Salasana *</td>
	                        <td><input required type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title='Salasana pitää sisältää yhden numeron, ison ja pienen kirjaimen ja sen pitää ollä vähintään 8 merkkiä pitkä!' name="salasana" value="" /></td>
	                    </tr>
	                    <tr>
	                        <td><br></td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                    	<td><button type="reset" value="Tyhjennä">Tyhjennä</button></td>  
	                    	<td><button type="submit" value="Vahvista">Vahvista</button></td>
	                    	                   
	                    </tr>
	                </tbody>
	            </table>
	        </form>
        </c:if>
        <c:if test="${not empty param.registrationNoSuccess}"><h3 style="color: red;">Täytä kaikki kentät!</h3><br></c:if>
     	<c:if test="${not empty param.userExists}"><h3 style="color: red;">Käyttäjätunnus on jo olemassa, kokeile jotain muuta!</h3><br></c:if>
     
        <c:if test="${not empty param.registrationSuccess}"><h3 style="color: green; text-align: center;">Rekisteröinti onnistui! </h3><br>
	        
	        <form method="post" action="LoginKontrolleri">
	        	<table>
		        	<tr>
		        		<td>
		        			Käyttäjätunnus: 
		        		</td>
		        		<td>
		        			<input type="text" name="kayttajatunnus" value="" />
		        		</td>
		        	</tr>
					<tr>
		        		<td>
		        			Salasana: 
		        		</td>
		        		<td>
						<input type="password" name="salasana" value="" />
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			Kirjaudu
		        		</td>
		        		<td>
		        		<input type="hidden" name="from" value="/TiedoteKontrolleri">
						<input type="submit" value="Kirjaudu" />
		        		</td>
		        	</tr>
		    	</table>
			</form>
        </c:if>
	</div>
</div>

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
