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
<link rel="stylesheet" type="text/css" href="tyylit/Index.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<title>Menu</title>

</head>
<body>

<ul>
<li><a  href="index.jsp">Etusivu</a></li>
<li><a class="active" href="asiakas.jsp">Menu</a></li>
<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>
<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
<li>
	<form method="post" action="login.jsp">
		<div class="login">
		Käyttäjätunnus
		<input type="text" name="kayttajatunnus" value="" />
		</div>
	</li>
	
	<li>
		<div class="login">
		Salasana
		<input type="password" name="salasana" value="" />
		
		</div>
	</li>
	
	<li>
		<div class="login">
	    <input type="submit" value="Kirjaudu" />
	    </div>
	
	</form>
</li>
</ul>

<h1>Castello é Fiore</h1>
  	<div id="laatikko">
		<table>
			<tr>
				<td><p>Pizzat</p></td>
				<td><p>Hinta</p></td>
				<td><p>Tilaa</p></td>
			</tr>
			<c:forEach items="${menulista}" var="pizza">
			<tr>
				<td>
					<form action="asiakasKontrolleri" method="post">
					<c:out value="${pizza.pizzanimi}"/>
					<br>
					<div class="taytenimi"><c:out value="${pizza.taytteet}"/></div>
					<input type="checkbox" value="1" name="oregano"/> oregano 
					<input type="checkbox" value="1" name="laktoositon"/> lakt.
					<input type="checkbox" value="1" name="gluteeniton"/> glut.
					<br><br>
				</td>
				<td>
					<fmt:setLocale value="fi"/>
					<fmt:formatNumber value="${pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" />€
				</td>
				<td>
                    <input type="hidden" value="${pizza.pizzaid}" name="tilaapizza" />
                    <input type="submit" value="Tilaa" />
                    </form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<c:if test="${not empty param.orderedPizza}"><h3 style="color: green;">Pizza lisätty ostoskoriin!</h3></c:if>
	</div>
<div id="footer"><li><a href="Kontrolleri">Admin</a></li></div>
</body>
</html>
