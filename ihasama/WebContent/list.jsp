
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
		<div class=laatikko><!-- pizzalista -->
				<table style="width: 100%;">
					<tr>
						<td><p>Pizzat</p></td>
						<td><p>Hinta</p></td>
						<td><p>Piilotus</p></td>
						<td><p>Piilossa</p></td>
						<td><p>Poisto</p></td>
					</tr>
					<!-- pizzalistan tulostus -->
					<c:forEach items="${pizzalista}" var="pizza">
                    <tr>
                        <td>
                        	<c:if test="${pizza.piilossa}">
                                <div style="text-decoration: line-through;"><c:out value="${pizza.pizzanimi}" /></div>
                            </c:if>
                            <c:if test="${!pizza.piilossa}">
                                <c:out value="${pizza.pizzanimi}" />
                            </c:if>
                            <div class="taytenimi">
                                <c:out value="${pizza.taytteet}" />
                            </div>
                        </td>
                        <td>
                        	<fmt:setLocale value="fi" />
                        	<fmt:formatNumber
                                value="${pizza.hinta}" type="number" minFractionDigits="2"
                                maxFractionDigits="2"
                            	/>€
                        </td>
                        <td>
                            <form action="Kontrolleri" method="post">
                                <input type="hidden" name="pid" value="${pizza.pizzaid}" /> 
                                <input type="radio" name="piilossa" value="1" />K 
                                <input type="radio" name="piilossa" value="0" />E 
                                <input type="submit" value="Muuta" />
                            </form>
                        </td>
                        <td>
                        	<c:if test="${pizza.piilossa}">
                                <c:out value="Kyllä" />
                            </c:if>
                            <c:if test="${!pizza.piilossa}">
                                <c:out value="Ei" />
                            </c:if>
                       </td>
                       <td>
                        	<form action="Kontrolleri" method="post">
                                <input type="hidden" value="${pizza.pizzaid}" name="poistopizza" />
                                <input type="submit" value="Poista" />
                            </form>
                        </td>
                    </tr>
                	</c:forEach>
				</table>
			
			<c:if test="${not empty param.removedPizza}"><h3>Pizzan poisto onnistui!</h3></c:if>	
		</div>
		<br>
		
		<div class=laatikko><!-- täytelista -->
			
				<table style="width: 100%;">
					<tr>
						<td><p>Täytelista</p></td>
						<td><p>Saatavuus</p></td>
						<td><p>Saatavilla</p></td>
						<td><p>Poisto</p></td>
					</tr>
						<!-- täytelistan tulostus -->
						<c:forEach items="${taytelista}" var="tayte">
					<tr>
						<td>
							<c:out value="${tayte.taytenimi}"/>
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
				</table>
			</form>
			<c:if test="${not empty param.removedTayte}"><h3>Täytteen poisto onnistui!</h3></c:if>
		</div>
		<br>
		<div class=laatikko>
			<p style="text-align: center;">Lisää uusi pizza</p>
				<!-- pizza lisäys formi -->
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
		<div class=laatikko>
			<p style="text-align: center;">Lisää uusi täyte</p>
			<!-- Täytteen lisäys lomake -->
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
