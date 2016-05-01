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
       <input type="submit" value="Tilaa" />
    </form>
    yhteensä: <fmt:setLocale value="fi"/>
			<fmt:formatNumber value="${yht}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
	</c:if>
</body>
</html>