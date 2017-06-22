<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="_core" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="<_core:url value="/resources/css/style.css" />"	rel="stylesheet">
	<title>Welcome</title>
</head>
<body>
	
	<%@ include file="/WEB-INF/jsp/header.jsp" %>
	
	<div class="container-container ">
		<div class="header_welcome_text">Please select an option</div>
		<div class="buttons_parent">
			<form method="get" action="/RiskValuationClient/register">
				<div class="submit_btn">
					<input type="submit" value="Register" />
				</div>
			</form>
			<form method="get" action="/RiskValuationClient/verify">
				<div class="submit_btn">
					<input type="submit" value="Verify" />
				</div>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/footer.jsp" %>
</body>
</html>