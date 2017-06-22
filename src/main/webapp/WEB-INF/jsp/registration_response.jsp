<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="_core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%-- 		<link href="<_core:url value="/resources/css/style.css" />" rel="stylesheet"> --%>
		<spring:url value="/resources/css/style.css" var="styleCSS" />
		<link href="${styleCSS}" rel="stylesheet" />
		<title>Result</title>
	</head>
	<body>
	
		<%@ include file="/WEB-INF/jsp/header.jsp" %>
	
		<div class="container-container ">
			<_core:if test="${not empty successMessage}">
				<div class="success_msg" style="float: left;margin-bottom: 10px;">
				   Success: ${successMessage}
				</div>
			</_core:if>
			
			<_core:if test="${not empty errorMessage}">
				<div class="error_msg">
				   Error : ${errorMessage}
				</div>
			</_core:if>
			
		</div>
		
		<%@ include file="footer.jsp" %>
		
	</body>
</html>