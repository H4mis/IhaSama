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
<title>Index</title>

</head>
<body>

<ul>
<li><a class="active" href="index.jsp">Etusivu</a></li>
<li><a href="asiakasKontrolleri">Menu</a></li>
<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>
<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>

<li>
	<form method="post" action="login.jsp">
		<div class="login">
		Käyttäjätunnus
		<input type="text" name="uname" value="" />
		</div>
	</li>
	
	<li>
		<div class="login">
		Salasana
		<input type="password" name="pass" value="" />
		
		</div>
	</li>
	
	<li>
		<div class="login">
	    <input type="submit" value="Login" />
	    </div>
	    
	</form>
</li>

</ul>

<h1>Castello é Fiore</h1>

 <div id="laatikko">
    <h2>Tervetuloa</h2>
    
    <p>
    Castello é Fiore on laatuun ja hyvään tunnelmaan erikoistunut ravintola. Tavoitteemme on
    taata asiakkaille korkealaatuista palvelua, ja tuoreista raaka-aineista tehtyä gourmet-ruokaa.
    Olemme perheyritys, joten ystävällisyys ja mukava ilmapiiri ovat arvoja, jonka mukaan 
    työskentelemme joka ikinen päivä.
     
     <br>
     <br>
     <br>
      ~henkilökunta   </p>
    
    
 </div>

<div id="footer"><li><a href="Kontrolleri">Admin</a></li></div>

</body>

</html>