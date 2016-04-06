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
<link rel="stylesheet" type="text/css" href="tyylit/rekisterointi.css">
<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
<title>Asiakassivu</title>

</head>
<body>

<ul>
<li><a href="index.jsp">Etusivu</a></li>
<li><a href="asiakasKontrolleri">Menu</a></li>
<li><a class="active" href="rekisterointi.jsp">Rekisteröinti</a></li>
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
		Password
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

	
	
        <!-- Rekisteröitymis lomake -->
        
    <div id="laatikko">
    <h2>Homot tervetuloa</h2>
      <div id="rek">
         <form method="post" action="registration.jsp">
            <table>
                <thead>
                    <tr>
                        <th colspan="2">Täytä tietosi tähän</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Etunimi</td>
                        <td><input type="text" name="fname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Sukunimi</td>
                        <td><input type="text" name="lname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Sähköposti</td>
                        <td><input type="text" name="email" value="" /></td>
                    </tr>
                    <tr>
                        <td>Käyttäjätunnus</td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Salasana</td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Submit" /></td>
                        <td><input type="reset" value="Reset" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
	</div>
</div>

</body>
</html>
