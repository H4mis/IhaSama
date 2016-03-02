
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
<title>Pizzalistaussivu</title>

</head>
<body>



<h3>Uusi pizza</h3>

	<table>
		<tr>
			<td width="600">
				<div class="menu">
					<h1>Listaus</h1>
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
			<tr><td><c:out value="${pizza.id}"/> <td><c:out value="${pizza.nimi}"/></td><td><c:out value="${pizza.hinta}"/></td></tr>
			</c:forEach>		
		

	</table>
</body>
</html>