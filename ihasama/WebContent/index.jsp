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

 <!-- Custom styles for this template -->
    <link href="sticky-footer-navbar.css" rel="stylesheet">
    
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="tyylit/Index.css">

<!-- sosiaalinen media kuvat -->
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">

<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Merienda:700' rel='stylesheet' type='text/css'>
<title>Index</title>

</head>
<body>

<nav class="navbar navbar-inverse">
 <div class="container-fluid">
  <div class="navbar-header">
     <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
     <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>    
   </div>
    
    <div class="collapse navbar-collapse" id="myNavbar">
    
      <ul class="nav navbar-nav">
      
     	<li><a class="active" href="TiedoteKontrolleri">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<li><a href="rekisterointi.jsp">Rekisteröinti</a></li>
		<li><a href="yhteystiedot.jsp">Yhteystiedot</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      <li><a href="Kontrolleri">Admin</a></li>
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Login <span class="glyphicon glyphicon-log-in"></span></a>
          <div class="dropdown-menu">
            <form id="formLogin" class="form container-fluid" method="post" action="LoginKontrolleri">
              <div class="form-group">
                <label for="usr">Käyttäjätunnus:</label>
                <input type="text" class="form-control" id="usr" name="kayttajatunnus">
              </div>
              <div class="form-group">
                <label for="pwd">Salasana:</label>
                <input type="password" class="form-control" id="pwd" name="salasana">
              </div>
              <input type="hidden" name="from" value="${kukkuluuruu}">
              <button type="submit" id="btnLogin" class="btn btn-block">Login</button>
            </form>
            	<c:if test="${not empty param.LoginSuccess}"><h3 style="color: green;">Kirjautuminen onnistui!</h3></c:if>
       <c:if test="${not empty param.LoginNoSuccess}"><h3 style="color: green;">Kirjautuminen epäonnistui!</h3></c:if>
            
            	
          </div>
        </li>
      </ul>
    </div>
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
     <br>
     <br>
     <p>
     <table>
     <c:forEach items="${tiedotelista}" var="tiedote">
                    
        
                        	<c:if test="${!tiedote.piilossa}">
                                
                            </c:if>                            
                            <c:if test="${tiedote.piilossa}">
                            <tr>
                            <td>
                                <c:out value="${tiedote.tiedote}" />
                                </td>
                                </tr>
                            </c:if>                            
                        
                        
                        </c:forEach>
                        </table>
  
    
 </div>
<br>


<!-- Myynti kikka laatikot alkavat täsäää!!!! -->

<div class="usp">
	<div class="marginblock">
	   <div id="laatikko1">
	   <img src="kuvat/autojpg.jpg" alt="AutoKuljetus" style="width:300px;height:150px;">
	 		<p> Nopeat kuljetukset
	 			Yli 20 € tilauksille ilmainen kotiin kuljetus</p>
	 	</div>
	 	
	  	<div id="laatikko1">
	  		<p> Unique Selling Proposition (USP)</p>
	 	</div>
	 	
	  	<div id="laatikko1">
	  		<p> Unique Selling Proposition (USP)</p>
	  </div>
  </div>	
</div>
<!-- loppuu tähän -->














 <footer class="footer">
     <div class="container">
        <ul id="sosiaalinenmedia">
        
			<li id="facebook"><a href="http://facebook.com/"><i class="fa fa-facebook"></i></a></li>
			<li id="linkedin"><a href="http://linkedin.com/"><i class="fa fa-linkedin"></i></a></li>
			<li id="twitter"><a href="http://twitter.com/"><i class="fa fa-twitter"></i></a></li>
			
			<div class="clr"></div>

		</ul>
 	 </div>
   
 </footer>
  
     <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    
    
</body>

</html>