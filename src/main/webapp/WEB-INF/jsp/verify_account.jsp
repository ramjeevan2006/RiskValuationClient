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
	<title>Verify Account</title>
	
	<style type="text/css">
		.invalid{
			border: 1px solid #D03B3B;
		}
	</style>
	
</head>
<body>


	<%@ include file="/WEB-INF/jsp/header.jsp" %>

	<div class="container-container ">
		<h1 class="header_welcome_text">Please enter the following to verify your account...</h1>
		<form:form action="verify" method="post" id="customer_reg_det" name="customer_reg_det">
			<table>
				<tr>
					<td><span class="register_labels">Email Id: </span></td>
					<td><input id="email_id" name="email_id" class="register_fields"/></td>
				</tr>	
			
				<tr>
					<td><span class="register_labels">Activation Key: </span></td>
					<td><input id="act_key" name="act_key" class="register_fields"/></td>
				</tr>
				<tr>
					<td></td>
					<td style="float: right;margin-top: 7px;">
						<div class="submit_btn">
							<input type="button" value="Verify" onclick="return submitForm();" />
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
			if($('#email_id').val() == "" || $('#email_id').val().length <= 0){
				alert("Please enter your Registered Email Id.");
				$('#email_id').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#email_id').removeClass('invalid');
			}
			
			var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	        if (reg.test($('#email_id').val()) == false){
	            alert("Please enter Valid Email");
	            $('#email_id').addClass('invalid');
				showError = true;
				return false;
	        }else{
				$('#email_id').removeClass('invalid');
			}
			
			if($('#act_key').val() == "" || $('#act_key').val().length <= 0){
				alert("Please enter the Activation Key.");
				$('#act_key').addClass('invalid');
				showError = true;
				return false;
			}else{
				$('#act_key').removeClass('invalid');
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