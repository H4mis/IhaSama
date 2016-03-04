
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
<link rel="stylesheet" type="text/css" href="tyylit/tyyli.css">
<title>Pizzalistaussivu</title>

</head>
<body>



<h1>Castello é Fiore</h1>

	<table>
		<tr>
			<td width="600">
				<div class="menu">
					<h2>Listaus</h2>
				</div>
			</td>
			<td></td>
			
	</table>
	<table>
		<tr>
			<td><p>#</p></td>
			<td><p>Pizzalista</p></td>
		</tr>

		
			

			<c:forEach items="${pizzalista}" var="pizza">
			<tr><td><c:out value="${pizza.pizzaid}"/> <td><c:out value="${pizza.pizzanimi}"/></td><td><c:out value="${pizza.hinta}"/></td></tr>
			</c:forEach>		
		

	</table>
	
	
	<div id="Lisauslomake">
		<form action="Kontrolleri" method="post">
			Pizzan nimi:<br>
			<input type="text" name="nimi" required>
				<br>
				Hinta:<br>
			<input type="number" name="hinta" size="6" required>
				<br>
			<input type="submit" value="Lisää pizza">
		</form>
				
		<c:if test="${not empty param.added}">Uuden pizzan lisääminen onnistui</c:if>
				
	</div>
	
</body>
</html>