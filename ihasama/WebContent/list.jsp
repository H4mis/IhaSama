
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
					<tr><td><c:out value="${pizza.pizzaid}"/> <td><c:out value="${pizza.pizzanimi}"/><br><div class="taytenimi"><c:out value="${pizza.taytteet}"/></div></td><td><c:out value="${pizza.hinta}"/></td></tr>
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
					<tr><td><c:out value="${tayte.tayteid}"/> <td><div class="taytenimi"><c:out value="${tayte.taytenimi}"/></div></td><td><c:if test="${tayte.saatavilla}"><c:out value="kyllä"/></c:if><c:if test="${!tayte.saatavilla}"><c:out value="ei"/></c:if></td></tr>
					</c:forEach>
			</table>
		</div>	
		<div id=taulukko5>
		<div id=Lisauslomake> <!-- Pizzan lisäys lomake -->
		<form action="Kontrolleri" method="post">
		
			<td><p>Lisää uusi pizza</p></td>
			<h3>Pizzan nimi:</h3>
			<input type="text" name="nimi" required>
				<br>
				<h3>Hinta:</h3>
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
	</div>
	<div id=taulukko4>
	<div id=Lisauslomake> <!-- Täytteen lisäys lomake -->
		<form action="Kontrolleri" method="post">
		<td><p>Lisää uusi täyte</p></td>
			<h3>Täytteen nimi:</h3>
			<input type="text" name="nimi" required>
				<br>
				<br>
			<input type="submit" value="Lisää täyte">
		</form>
				
		<c:if test="${not empty param.added}">Uuden täytteen lisääminen onnistui</c:if>	
	</div>
	</div>
		
	</div>
	
	
	

</body>
</html>
