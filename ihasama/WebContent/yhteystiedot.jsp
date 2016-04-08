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
<title>Yhteystiedot</title>
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
    margin-left:auto;
    margin-right:auto;
}
th, td {
    padding: 5px;
    text-align: left; 
     
}
</style>
</head>
<body>

<ul>
<li><a href="index.jsp">Etusivu</a></li>
<li><a href="asiakasKontrolleri">Menu</a></li>
<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>
<li><a class="active"  href="yhteystiedot.jsp">Yhteystiedot</a></li>
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
    <h2>Ota yhteyttä</h2>
    
    <table style="width:100%">
  <tr>
    <th>Sähköposti</th>
    <td>castelloefiore@castello.fi</td>
  </tr>
  <tr>
    <th rowspan="2">Puh:</th>
    <td>+35850667832</td>
  </tr>
  <tr>
    <td>09557334</td>
  </tr>
  <tr>
    <th>Osoite</th>
    <td>Sibeliuksenkatu 7, Hämeenlinna</td>
  </tr>
</table>
<br>
 <br> 
 <br> 

<h3>Kartta</h3>
 <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2466.028070132561!2d24.461779116511266!3d60.99617808330837!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x468e5d970c10edb3%3A0xa654c8617544564e!2sSibeliuksenkatu+7%2C+13100+H%C3%A4meenlinna!5e1!3m2!1sfi!2sfi!4v1459936427659" width="300" height="300" frameborder="0" style="border:0"  allowfullscreen></iframe>
 <br> 
 <br> 
 </div>

<div id="footer"><li><a href="Kontrolleri">Admin</a></li></div>

</body>

</html>