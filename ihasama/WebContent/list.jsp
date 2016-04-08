
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
<link rel="stylesheet" type="text/css" href="tyylit/tyyli.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<title>Pizzalistaussivu</title>

</head>
<body>

<ul id="navul">
<li id="navli"><a href="index.jsp">Etusivu</a></li>
<li id="navli"><a href="asiakasKontrolleri">Menu</a></li>
<li id="navli"><a href="rekisterointi.jsp">Rekisteröinti</a></li>
<li id="navli"><a href="yhteystiedot.jsp">Yhteystiedot</a></li>

</ul>

<h1>Castello é Fiore</h1>

	<div class="laatikko">
		<h2>Pizzojen ja täytteiden muokkaus</h2>
	</div>
	
	<br>
	<div id="container">
		<div class=laatikko>
			<form action="Kontrolleri" method="post">
				<table style="width: 100%;">
					<tr>
						<td><p>Pizzat</p></td>
						<td><p>Hinta</p></td>
						<td><p>Poisto</p></td>
					</tr>
					<c:forEach items="${pizzalista}" var="pizza">
					<tr>
						<td>
							<c:out value="${pizza.pizzanimi}"/><br>
							<div class="taytenimi"><c:out value="${pizza.taytteet}"/></div>
						</td>
						<td>
							<fmt:setLocale value="fi"/>
							<fmt:formatNumber value="${pizza.hinta}" type="number" minFractionDigits="2" maxFractionDigits="2" /> €
							
						</td>
						<td>
							<input type="checkbox" value="${pizza.pizzaid}" name="poistopizza" />
		   				</td>
					</tr>
					</c:forEach>
					
					<tr>
						<td></td>
						<td></td>
						<td>
							<input type="submit" value="Poista pizzat">
						</td>
					</tr>
				</table>
			</form>
			<c:if test="${not empty param.removedPizza}"><h3>Pizzan poisto onnistui!</h3></c:if>	
		</div>
		<br>
		
		<div class=laatikko>
			
				<table style="width: 100%;">
					<tr>
						<td><p>Täytelista</p></td>
						<td><p>Saatavilla</p></td>
						<td><p>Poista</p></td>
					</tr>
						<c:forEach items="${taytelista}" var="tayte">
					<tr>
						<td>
							<div class="taytenimi">
								<c:out value="${tayte.taytenimi}"/>
							</div>
						</td>
						<td>
						<form action="Kontrolleri" method="post">
						<input type="hidden" name="tid" value="${tayte.tayteid}" />
						<input type="radio" name="saatavilla" value="1" /> Kyllä
						<input type="radio" name="saatavilla" value="0" /> Ei
						<input type="submit" value="Muuta">
						</form>
						</td>
						
						<td>
		
							<c:if test="${tayte.saatavilla}"><c:out value="kyllä"/></c:if>
							<c:if test="${!tayte.saatavilla}"><c:out value="ei"/></c:if>
						</td>
						<td>
										<form action="Kontrolleri" method="post">
							<input type="hidden" value="${tayte.tayteid}" name="poistotayte" />
							<input type="submit" value="Poista">
							</form>
		    			</td>
		    		</tr>
		    									
					</c:forEach>

						<td></td>
						<td></td>
						<td>
							
						</td>
					</tr>
				</table>
			</form>
			<c:if test="${not empty param.removedTayte}"><h3>Täytteen poisto onnistui!</h3></c:if>
		</div>
		<br>
		<div class=laatikko>
			<p style="text-align: center;">Lisää uusi pizza</p>
				<form action="Kontrolleri" method="post" style="text-align: center;" accept-charset="UTF-8">
					<table style="width: 100%;">
					<tr>
						<td style="text-align: right;">
							Pizzan nimi:
						</td>
						<td>
							<input type="text" name="nimi" required>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">
							Hinta:
						</td>
						<td>
							<input type="number" step="0.01" title="Laita numeroita muodossa 00.00" name="hinta" required>
						</td>
					</tr>
					</table>
					
					<br>
					<br>
						
					<dl class="dropdown"> 				  
					    <dd>
				            <ul>
				            	<!-- hakee täytteet valinnoiksi-->
				                <c:forEach items="${taytelista}" var="tayte">
					                <li>
						                <input type="checkbox" value="${tayte.tayteid}" name="taytteet" />
										<c:out value="${tayte.taytenimi}"/>
									</li>
								</c:forEach>
				            </ul>
					    </dd>
					</dl>
						
						<br>
						<br>
					<input type="submit" value="Lisää pizza">
					<br>
					<br>
				</form>
				
				<c:if test="${not empty param.addedPizza}"><h3>Uuden pizzan lisääminen onnistui</h3></c:if>	
			</div>
		</div>
		<br>
		<div class=laatikko><!-- Täytteen lisäys lomake -->
			<p style="text-align: center;">Lisää uusi täyte</p>
			<form action="Kontrolleri" method="post" accept-charset="UTF-8">
				<table style="width: 100%;">
					<tr>
						<td style="text-align: right;">
							Täytteen nimi:
						</td>
						<td>
							<input type="text" name="taytenimi" required>
						</td>
					</tr>
				</table>
				<br>
				<input type="submit" value="Lisää täyte">
				<c:if test="${not empty param.addedTayte}"><h3>Uuden täytteen lisääminen onnistui</h3></c:if>	
				<br>
				<br>
			</form>
		</div>
		
	
	
	


</body>
</html>
