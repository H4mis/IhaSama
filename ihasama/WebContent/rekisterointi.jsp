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

<!-- sosiaalinen media kuvat -->
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="tyylit/Index.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<title>Rekisteröinti</title>

</head>
<body>
<nav class="navbar navbar-inverse">
 
    <div>
      <ul class="nav navbar-nav">
      
     	<li><a  href="index.jsp">Etusivu</a></li>
		<li><a href="asiakasKontrolleri">Menu</a></li>
		<li><a class="active" href="rekisterointi.jsp">Rekisteröinti</a></li>
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

	
	
        <!-- Rekisteröitymis lomake -->
        
    <div id="laatikko">
    	<c:if test="${empty param.registrationSuccess}">
	    <h2>Rekisteröinti</h2>
	         <form method="post" action="RekisterointiKontrolleri">
	            <table>
	                <thead>
	                    <tr>
	                        <th colspan="2">Täytä tietosi tähän, * on pakollinen kohta</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>Etunimi</td>
	                        <td><input type="text" name="etunimi" value="" />*</td>
	                    </tr>
	                    <tr>
	                        <td>Sukunimi</td>
	                        <td><input type="text" name="sukunimi" value="" />*</td>
	                    </tr>
	                    <tr>
	                        <td>Sähköposti</td>
	                        <td><input type="text" name="sahkoposti" value="" />*</td>
	                    </tr>
	                    <tr>
	                        <td><br></td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                        <td>Käyttäjätunnus</td>
	                        <td><input type="text" name="kayttajatunnus" value="" />*</td>
	                    </tr>
	                    <tr>
	                        <td>Salasana</td>
	                        <td><input type="password" name="salasana" value="" />*</td>
	                    </tr>
	                    <tr>
	                        <td><br></td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                    	<td></td>
	                    	<td><input type="submit" value="Vahvista" /></td>
	                    	<td><input type="reset" value="Tyhjennä" /></td>                     
	                    </tr>
	                </tbody>
	            </table>
	        </form>
        </c:if>
        <c:if test="${not empty param.registrationNoSuccess}"><h3 style="color: red;">Täytä kaikki kentät!</h3><br></c:if>
     	<c:if test="${not empty param.userExists}"><h3 style="color: red;">Käyttäjätunnus on jo olemassa, kokeile jotain muuta!</h3><br></c:if>
     
        <c:if test="${not empty param.registrationSuccess}"><h3 style="color: green; text-align: center;">Rekisteröinti onnistui! </h3><br>
	        
	        <form method="post" action="login.jsp">
	        	<table>
		        	<tr>
		        		<td>
		        			Käyttäjätunnus: 
		        		</td>
		        		<td>
		        			<input type="text" name="kayttajatunnus" value="" />
		        		</td>
		        	</tr>
					<tr>
		        		<td>
		        			Salasana: 
		        		</td>
		        		<td>
						<input type="password" name="salasana" value="" />
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			Kirjaudu
		        		</td>
		        		<td>
						<input type="submit" value="Kirjaudu" />
		        		</td>
		        	</tr>
		    	</table>
			</form>
        </c:if>
	</div>
<div id="footer"><li><a href="Kontrolleri">Admin</a></li></div>

 <footer class="footer">
     <div class="container">
        <ul id="sosiaalinenmedia">
        
			<li id="facebook"><a href="http://facebook.com/"><i class="fa fa-facebook"></i></a></li>
			<li id="linkedin"><a href="http://linkedin.com/"><i class="fa fa-linkedin"></i></a></li>
			<li id="twitter"><a href="http://twitter.com/"><i class="fa fa-twitter"></i></a></li>
			<li id="googleplus"><a href="http://plus.google.com/"><i class="fa fa-google-plus"></i> </a></li>
			<div class="clr"></div>

		</ul>
 	 </div>
   
 </footer>
</body>
</html>
