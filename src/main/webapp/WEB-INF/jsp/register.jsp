<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="_core" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="<_core:url value="/resources/css/style.css" />" rel="stylesheet">
	<script type='text/javascript' src="<_core:url value="/resources/js/jquery.min.js" />"></script>
	<title>Registration</title>
	
	<style type="text/css">
		.invalid{
			border: 1px solid #D03B3B;
		}
	</style>
	
</head>
<body>


	<%@ include file="/WEB-INF/jsp/header.jsp" %>

	<div class="container-container ">
		<h1 class="header_welcome_text">Please enter the following fields...</h1>
		<form:form action="register" method="post" id="customer_reg_det" name="customer_reg_det">
			<table>
				<tr>
					<td><span class="register_labels"> First Name: </span></td>
					<td><form:input id="firstName" class="register_fields" path="firstName" /></td>
				</tr>
				<tr>
					<td><span class="register_labels"> Last Name: </span></td>
					<td><form:input id="lastName" class="register_fields" path="lastName" /></td>
				</tr>
				<tr>
					<td><span class="register_labels"> Organization Name: </span></td>
					<td><form:input id="organizationName" class="register_fields" path="organizationName" /></td>
				</tr>
				<tr>
					<td><span class="register_labels"> Email Id: </span></td>
					<td><form:input id="emailId" class="register_fields" path="emailId" /></td>
				</tr>
				<tr>
					<td><span class="register_labels">Phone Number:</span></td>
					<td><form:input maxlength="10" id="phoneNumber" onkeypress='return event.charCode >= 48 && event.charCode <= 57' class="register_fields" path="phoneNumber" /></td>
				</tr>
				<tr>
					<td></td>
					<td style="float: right;margin-top: 7px;">
						<div class="submit_btn">
							<input type="button" value="Save" onclick="return submitForm();" />
						</div>
					</td>
				</tr>
			</table>
		</form:form>
	</div>
	
	<%@ include file="footer.jsp" %>
	
	
	<script type="text/javascript">
		function submitForm(){
			
			var showError = false;
			
			if($('#firstName').val() == "" || $('#firstName').val().length <= 0){
				alert("Please enter your First Name");
				$('#firstName').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#firstName').removeClass('invalid');
			}
			
			if($('#lastName').val() == "" || $('#lastName').val().length <= 0){
				alert("Please enter your Last Name");
				$('#lastName').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#lastName').removeClass('invalid');
			}
			
			if($('#organizationName').val() == "" || $('#organizationName').val().length <= 0){
				alert("Please enter your Organization Name");
				$('#organizationName').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#organizationName').removeClass('invalid');
			}
			
			if($('#emailId').val() == "" || $('#emailId').val().length <= 0){
				alert("Please enter your Email Id");
				$('#emailId').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#emailId').removeClass('invalid');
			}
			
			
			var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	        if (reg.test($('#emailId').val()) == false){
	            alert("Please enter Valid Email");
	            $('#emailId').addClass('invalid');
				showError = true;
				return false;
	        }else{
				$('#emailId').removeClass('invalid');
			}
			
			
			if($('#phoneNumber').val() == "" || $('#phoneNumber').val().length <= 0){
				alert("Please enter your Phone Number");
				$('#phoneNumber').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#phoneNumber').removeClass('invalid');
			}
			
			
			if(showError){
				return false;
			}else{
				document.customer_reg_det.submit();
			}
		}
	</script>
</body>
</html>