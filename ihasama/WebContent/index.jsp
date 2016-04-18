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
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="tyylit/Index.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<title>Index</title>

</head>
<body>

<nav class="navbar navbar-inverse">
 
    <div>
      <ul class="nav navbar-nav">
      
     	<li><a class="active" href="index.jsp">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>
		<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Login <span class="glyphicon glyphicon-log-in"></span></a>
          <div class="dropdown-menu">
            <form id="formLogin" class="form container-fluid">
              <div class="form-group">
                <label for="usr">Sähköposti:</label>
                <input type="text" class="form-control" id="usr">
              </div>
              <div class="form-group">
                <label for="pwd">Salasana:</label>
                <input type="password" class="form-control" id="pwd">
              </div>
              <button type="button" id="btnLogin" class="btn btn-block">Login</button>
            </form>
            	
          </div>
        </li>
      </ul>
    </div>
 
</nav>

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