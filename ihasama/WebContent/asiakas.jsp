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
<title>Menu</title>

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
   </div><!-- navbar header loppuu tähän -->
    
   <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
      
     	<li><a  href="TiedoteKontrolleri">Etusivu</a></li>
		<li><a class="active" href="asiakasKontrolleri">Menu</a></li>
		<c:if test="${empty sessionScope.kayttajatunnus}">
			<li><a  href="rekisterointi.jsp">Rekisteröinti</a></li>
		</c:if>
		<li><a  href="yhteystiedot.jsp">Yhteystiedot</a></li>
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
				            	<input type="hidden" value="${index}" name="poistopizza" />
				                <button type="submit" value="Poista">Poista</button>
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
                <input type="text" class="form-control" id="usr" name="kayttajatunnus">
              </div>
              <div class="form-group">
                <label for="pwd">Salasana:</label>
                <input type="password" class="form-control" id="pwd" name="salasana">
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
    </div><!-- collapse navbar-collapse loppuu tähän -->
  </div><!-- container fluid loppuu tähän -->
</nav>

<h1>Castello é Fiore</h1>
  <div class="marginblock">
  	<div id="laatikko">
  	
		<table>
			<tr>
				<th style="text-align: left;">Pizzat</th>
				<th>Hinta</th>
				<th>Tilaa</th>
				
			</tr>
			
			<c:if test="${empty menulista}"><c:out value="</table>"/> Pizzalista on tyhjä!</c:if>
		
			<c:if test="${not empty menulista}">
			<c:forEach items="${menulista}" var="pizza">
			<form action="KoriKontrolleri" method="post">
				<tr>
					<td style="text-align: left;color:lightgrey;">
						
						<c:out value="${pizza.pizzanimi}"/>
						<br>
						<div class="taytenimi"><c:out value="${pizza.taytteet}"/></div>
						<input type="checkbox" value="1" name="oregano"/> oregano 
						<input type="checkbox" value="1" name="laktoositon"/> lakt.
						<input type="checkbox" value="1" name="gluteeniton"/> glut.
						<br><br>
					</td>
					<td style="color:lightgrey;">
						<fmt:setLocale value="fi"/>
						<fmt:formatNumber value="${pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
					</td>
					<td>
	                    <input type="hidden" value="${pizza.pizzaid}" name="tilaapizza" />
	                    <button type="submit" value="Tilaa" > Tilaa</button>
	                    
					</td>
				</tr>
			</form>
			</c:forEach>
			</c:if>
		</table>
		
		</div>
		<c:if test="${not empty param.orderedPizza}"><h3 style="color: green;">Pizza lisätty ostoskoriin!</h3></c:if>
	
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
