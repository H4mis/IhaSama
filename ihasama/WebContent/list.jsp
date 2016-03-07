
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

	<div id=taulukko>
		<table>
			<tr>
				<td width="600">
					<div class="menu">
						<h2>Listaus</h2>
					</div>
				</td>
				<td></td>
		</table>
	</div>
	
	<br>
	<div id="container">
		<div id=taulukko2>
			<table>
				<tr>
					<td><p>#</p></td>
					<td><p>Pizzalista</p></td>
				</tr>
					<c:forEach items="${pizzalista}" var="pizza">
					<tr><td><c:out value="${pizza.pizzaid}"/> <td><c:out value="${pizza.pizzanimi}"/></td><td><c:out value="${pizza.hinta}"/></td></tr>
					</c:forEach>		
			</table>
		</div>
	
		<br>
		
		<div id=taulukko3>
			<table>
				<tr>
					<td><p>#</p></td>
					<td><p>Täytelista</p></td>
				</tr>
					<c:forEach items="${taytelista}" var="tayte">
					<tr><td><c:out value="${tayte.tayteid}"/> <td><c:out value="${tayte.taytenimi}"/></td><td><c:out value="${tayte.saatavilla}"/></td></tr>
					</c:forEach>
			</table>
		</div>	
	</div>
	
	<div id=Lisauslomake> <!-- Pizzan lisäys lomake -->
		<form action="Kontrolleri" method="post">
			Pizzan nimi:<br>
			<input type="text" name="nimi" required>
				<br>
				Hinta:<br>
			<input type="number" pattern="([0-9]{1-2}|[0-9]{1-2}[,|.][0-9]{1-2})" title="Laita numeroita muodossa 00.00" name="hinta" required>
				<br>
				
				<dl class="dropdown"> 				  
				    <dd>
			            <ul>
			            	<!-- hakee täytteet valinnoiksi-->
			                <c:forEach items="${taytelista}" var="tayte">
				                <li>
					                <input type="checkbox" value="${tayte.taytenimi}" name="taytteet" />
									<c:out value="${tayte.taytenimi}"/>
								</li>
							</c:forEach>
			            </ul>
				    </dd>
				</dl>
				
				<br>
				<br>
			<input type="submit" value="Lisää pizza">
		</form>
				
		<c:if test="${not empty param.added}">Uuden pizzan lisääminen onnistui</c:if>	
	</div>
	
	<div id=Lisauslomake> <!-- Täytteen lisäys lomake -->
		<form action="Kontrolleri" method="post">
			Täytteen nimi:<br>
			<input type="text" name="nimi" required>
				<br>
			<input type="submit" value="Lisää täyte">
		</form>
				
		<c:if test="${not empty param.added}">Uuden täytteen lisääminen onnistui</c:if>	
	</div>
	

</body>
</html>
