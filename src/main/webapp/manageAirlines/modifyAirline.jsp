<%@page import="flyaway.entities.Airlines"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Airlines</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="bg-light">

<%@ include file="../navbar.jsp" %>
<%

Customer customer_session = (Customer)session.getAttribute("user");

if(customer_session != null){
	if(!customer_session.getUserRole().equals("Admin")){
		response.sendRedirect(request.getContextPath() + "/");
		return;
	}
}else{
	response.sendRedirect(request.getContextPath() + "/");
	return;
}

if(request.getParameter("airlineId") != null){
	
}else{
	response.sendRedirect(request.getContextPath() + "/manageAirlines.jsp");
	return;
}

%>

<h2 class="my-3 container mt-3">Modify Airline</h2>
<div class="container my-3 p-3 bg-body rounded shadow-sm">

<%
    if(request.getParameter("error") != null){
    	%>
    	
    	<div class="alert alert-danger" role="alert">
		 <%= request.getParameter("error")  %>
		</div>
    	
    	<%

    }
    
    %>
<%
    
    Session s = FactoryProvider.getFactory().openSession();
    Query airlineDate = s.createQuery("FROM Airlines WHERE id=:airlineId");
    airlineDate.setParameter("airlineId",  Integer.parseInt(request.getParameter("airlineId")));
    
    Airlines airline = (Airlines) airlineDate.uniqueResult();
    
    %>
<form action="<%= request.getContextPath() %>/modifyAirlineServlet" method="post">
	<input type="hidden" name="airlineId" value="<%= request.getParameter("airlineId") %>"/>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Airline Name:</label>
    <div class="col-sm-10">
      <input type="text" required class="form-control" name="airName" id="airName" value="<%= airline.getName() %>">
    </div>
  </div>
  <div class="mb-3 row">
    <label for="airEmail" class="col-sm-2 col-form-label">Airline Email:</label>
    <div class="col-sm-10">
      <input type="email" required class="form-control" name="airEmail" id="airEmail" value="<%= airline.getEmail() %>">
    </div>
  </div>
  <div class="mb-3 row">
    <label for="airPhone" class="col-sm-2 col-form-label">Airline Phone:</label>
    <div class="col-sm-10">
      <input type="text" required class="form-control" name="airPhone" id="airPhone" value="<%= airline.getPhone() %>">
    </div>
  </div>
  <input class="btn btn-primary" type="submit" value="Update Airline"/>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>