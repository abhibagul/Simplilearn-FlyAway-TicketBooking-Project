<%@page import="java.util.UUID"%>
<%@page import="flyaway.entities.Route"%>
<%@page import="flyaway.entities.Airlines"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="bg-light">

<%@ include file="../navbar.jsp" %>
<%

Customer customer_session = (Customer)session.getAttribute("user");

if(customer_session != null){
	
}else{
	response.sendRedirect(request.getContextPath() + "/");
	return;
}



%>

<h2 class="my-3 container mt-3">My Profile</h2>


<%
    if(request.getParameter("error") != null){
    	%>
    	
    	<div class="container alert alert-danger" role="alert">
		 <%= request.getParameter("error")  %>
		</div>
    	
    	<%

    }
    
    %>

	<div class="container">
	  <div class="row">
	  	<div class="col-sm-7">
		  	<div class="container my-3 p-3 bg-body rounded shadow-sm">
		  		<h6 class="mt-2">Personal Information</h6>
		  		<hr/>
				<form method="post" action="<%= request.getContextPath() %>/modifyProfileServlet">
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-2 col-form-label">First Name:</label>
				    <div class="col-sm-10">
				      <input type="text" required class="form-control" name="cusFirstName" id="cusName" value="<%= customer_session.getFirstName() %>">
				    </div>
				  </div>
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-2 col-form-label">Last Name:</label>
				    <div class="col-sm-10">
				      <input type="text" required class="form-control" name="cusLastName" id="cusName" value="<%= customer_session.getLastName() %>">
				    </div>
				  </div>
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-2 col-form-label">Email:</label>
				    <div class="col-sm-10">
				      <span class="form-control alert alert-light p-2 mb-0"><%= customer_session.getEmail() %> (Can not be changed.)</span>
				    </div>
				  </div>
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-2 col-form-label">Phone:</label>
				    <div class="col-sm-10">
				      <input type="text" required class="form-control" name="cusPhone" id="cusName" value="<%= customer_session.getPhone() %>">
				    </div>
				  </div>
				  <input type="submit" value="Update Profile" class="btn btn-primary"/>
				</form>
			</div>
	  	</div>
	  	<div class="col-sm-5">
	  		<div class="container my-3 p-3 bg-body rounded shadow-sm">
	  			<h6 class="mt-2">Change Password</h6>
		  		<hr/>
				<form method="post" action="<%= request.getContextPath() %>/modifyPasswordServlet">
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-4 col-form-label">Current Password:</label>
				    <div class="col-sm-8">
				      <input type="password" required class="form-control" name="oldPass" id="cusName" >
				    </div>
				  </div>
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-4 col-form-label">New Password:</label>
				    <div class="col-sm-8">
				      <input type="password" required class="form-control" name="newPass" id="cusName" >
				    </div>
				  </div>
				  <div class="mb-3 row">
				    <label for="cusName" class="col-sm-4 col-form-label">Confirm New Password:</label>
				    <div class="col-sm-8">
				      <input type="password" required class="form-control" name="newPassC" id="cusName" >
				    </div>
				  </div>
				<input type="submit" value="Update Password" class="btn btn-primary"/>
				</form>
			</div>
	  	</div>
	  </div>
	</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>