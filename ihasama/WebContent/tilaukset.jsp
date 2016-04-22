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
<link rel="stylesheet" type="text/css" href="tyylit/Index.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script'
	rel='stylesheet' type='text/css'>
<title>Menu</title>

</head>
<body>
	<nav class="navbar navbar-inverse">

		<div>
			<ul class="nav navbar-nav">

				<li><a href="index.jsp">Etusivu</a></li>
				<li><a class="active" href="asiakasKontrolleri">Menu</a></li>
				<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>
				<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Login <span
						class="glyphicon glyphicon-log-in"></span></a>
					<div class="dropdown-menu">
						<form id="formLogin" class="form container-fluid">
							<div class="form-group">
								<label for="usr">Sähköposti:</label> <input type="text"
									class="form-control" id="usr">
							</div>
							<div class="form-group">
								<label for="pwd">Salasana:</label> <input type="password"
									class="form-control" id="pwd">
							</div>
							<button type="button" id="btnLogin" class="btn btn-block">Login</button>
						</form>

					</div></li>
			</ul>
		</div>

	</nav>

	<h1>Castello é Fiore</h1>

	<div id="laatikko">
		<table>
			<tr>
				<td><p>Tilausnro</p></td>
				<td><p>Tilaajatunnus</p></td>
				<td><p>Valmiina</p></td>
				<td><p>Toimitustapa</p></td>
				<td><p>Pizzat</p></td>
				<td><p>Oregano</p></td>
				<td><p>Laktoositon</p></td>
				<td><p>Gluteeniton</p></td>
			</tr>
			<c:forEach items="${tilauslista}" var="tilaus">
				<tr>
					<form action="TilausKontrolleri" method="post">
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
						<c:out value="${tilaus.tilaajatunnus}" />
					</td>
					<td>
						<c:if test="${tilaus.valmiina}">KYLLÄ</c:if>
						<c:if test="${!tilaus.valmiina}">EI</c:if>
					</td>
					<td>
						<c:out value="${tilaus.toimitustapa}" />
					</td>


					</form>
					<c:forEach items="${tilaus.tilatutPizzat}" var="tilatut">
						<form action="TilausKontrolleri" method="post">
							<c:if test="${tilaus.tilausnro == tilatut.tilausnro}">
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
						</form>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="footer">
		<li><a href="Kontrolleri">Admin</a></li>
	</div>
</body>
</html>