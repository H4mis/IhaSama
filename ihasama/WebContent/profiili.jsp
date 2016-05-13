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
		<li><a href="asiakasKontrolleri">Menu</a></li>
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
		      			<td><c:out value="${kori.pizza.pizzanimi}" />&nbsp;</td>
		      			<td><fmt:formatNumber value="${kori.pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€</td>
		      			<td>
		      				<form action="KoriKontrolleri" method="post">
		      					<input type="hidden" value="asiakasKontrolleri" name="taaltatulen" />
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
      <c:if test="${not empty sessionScope.kayttajatunnus}"><li><a class="active" href="Profiili">Hei, <c:out value="${sessionScope.nimi}" /></a></li><li><a href="Logout">Logout</a></li></c:if>
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
    </div><!-- collapse navbar-collapse loppuu tähän -->
  </div><!-- container fluid loppuu tähän -->
</nav>

<c:if test="${empty sessionScope.kayttajatunnus}"><c:redirect url="TiedoteKontrolleri"/></c:if>

<c:if test="${not empty sessionScope.kayttajatunnus}">
<div class="marginblock">
 	<div id="laatikko">
		<form action="Profiili" method="post" accept-charset="utf-8">
		
					<h2>Käyttäjän tiedot</h2>
				
			
			<table>
				
				<tr>
					<th style="vertical-align:top;">käyttäjätunnus</th>
					<td style="color:lightgrey;"><c:out value="${sessionScope.kayttajatunnus}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">etunimi</th>
					<td><input type="text" name="etunimi" pattern='([a-z]|[A-Z]){1,60}' value="${etunimi}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">sukunimi</th>
					<td><input type="text" name="sukunimi" pattern='([a-z]|[A-Z]){1,60}' value="${sukunimi}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">sähköposti&nbsp;</th>
					<td><input type="text" name="sahkoposti" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" value="${sahkoposti}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">katuosoite&nbsp;</th>
					<td><input type="text" name="osoite" pattern='([a-z]|[A-Z]|[ ]|[0-9]){1,60}' value="${osoite}"/></td>
				</tr>
				<tr>
					<th style="vertical-align:top;">postinumero</th>
					<td>
						<input type="text" name="postinro" pattern="\d{5,5}" maxlength="5" value="${postinro}"/>
					</td>
				</tr>
				<tr>
					<th style="vertical-align:top;">postitoimipaikka</th>
					<td><input type="text" name="postitmp" value="${postitmp}"/></td>
				</tr>
				<tr>
					<td></td>
					<td><button type="submit" name="toiminto" value="muutaTietoja">muuta</button></td>
				</tr>
			</table>
		</form>
		<c:if test="${not empty param.changedProfile}"><h3 style="color: green;">Muokkaus onnistui!</h3></c:if>
		</div>
		
		</div>
	</c:if>


</body>
</html>