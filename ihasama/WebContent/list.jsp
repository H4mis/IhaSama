
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
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<title>Pizzalistaussivu</title>

</head>
<body>



<h1>Castello é Fiore</h1>

	<div id=taulukko><table>
		<tr>
			<td width="600">
				<div class="menu">
					<h2>Listaus</h2>
				</div>
			</td>
			<td></td>
			
	</table></div>
	<br>
	<div id=taulukko2><table>
		<tr>
			<td><p>#</p></td>
			<td><p>Pizzalista</p></td>
		</tr>

		
			

			<c:forEach items="${pizzalista}" var="pizza">
			<tr><td><c:out value="${pizza.pizzaid}"/> <td><c:out value="${pizza.pizzanimi}"/></td><td><c:out value="${pizza.hinta}"/></td></tr>
			</c:forEach>		
		


	</table></div>


	
	
	<div id=Lisauslomake>
		<form action="Kontrolleri" method="post">
			Pizzan nimi:<br>
			<input type="text" name="nimi" required>
				<br>
				Hinta:<br>
			<input type="number" pattern="([0-9]{1-2}|[0-9]{1-2}[,|.][0-9]{1-2})" title="Laita numeroita muodossa 00.00" name="hinta" required>
				<br>
				<br>
			<input type="submit" value="Lisää pizza">
		</form>
				
		<c:if test="${not empty param.added}">Uuden pizzan lisääminen onnistui</c:if>
				
	</div>
	

</body>
</html>
