<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    

    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="LoginKontrolleri">
        Kayttajatunnus:<input type="text" name="kayttajatunnus"   /><br/>
        salasana:<input type="password" name="salasana" /><br/>
        <input type="submit" value="kirjaudu" />
        </form>
        <c:if test="${ empty param.removedPizza}"><h3>Pizzan poisto onnistui!</h3></c:if>
       <c:if test="${not empty param.LoginSuccess}"><h3 style="color: green;">onnistu</h3></c:if>
       <c:if test="${not empty param.LoginSuccess}"><h3 style="color: green;">Haista Vittu</h3></c:if>
</body>
</html>