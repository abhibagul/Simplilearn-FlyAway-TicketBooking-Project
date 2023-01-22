<%@page import="flyaway.entities.Airlines"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Route</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="bg-light">

<%@ include file="../navbar.jsp" %>
<%

Customer customer_session = (Customer)session.getAttribute("user");

if(customer_session != null){
	if(!customer_session.getUserRole().equals("Admin")){
		response.sendRedirect(request.getContextPath() + "/");
	}
}else{
	response.sendRedirect(request.getContextPath() + "/");
}

%>

<h2 class="my-3 container mt-3">New Route</h2>
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
  Session sAirLines = FactoryProvider.getFactory().openSession();
  Query airLineList = sAirLines.createQuery("FROM Airlines ");
  List<Airlines> allAirlinesList = airLineList.list();
  %>
<form action="<%= request.getContextPath() %>/createRouteServlet" method="post">
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Airline:</label>
    <div class="col-sm-10">
        <select class="form-select" name="rtAirline" id="floatingSelect" aria-label="Floating label select example">
			     <%
			    
			    if(allAirlinesList.size() > 0){
			  	  for(Airlines airline:allAirlinesList){
			  		  %>
			  		  <option value="<%= airline.getId() %>"> <%= airline.getName() %> </option>			  		  
			  		  <%			  		 
			  	  }
			  	  
			    }
			    
			    %>
		</select>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="airCode" class="col-sm-2 col-form-label">Source:</label>
    <div class="col-sm-10">
      <select class="form-select" name="rtSource"  id="floatingSelect" aria-label="Floating label select example">
			     <%
			    
			    if(allAirportsList.size() > 0){
			  	  for(Airports airport:allAirportsList){
			  		  %>
			  		  <option value="<%= airport.getId() %>"> <%= airport.getCode() %> -  <%= airport.getName() %> </option>			  		  
			  		  <%			  		 
			  	  }
			  	  
			    }
			    
			    %>
		</select>
    </div>
  </div>
  
  <div class="mb-3 row">
    <label for="airCountry" class="col-sm-2 col-form-label">Destination:</label>
    <div class="col-sm-10">
        <select class="form-select" name="rtDestination"  id="floatingSelect" aria-label="Floating label select example">
			     <%
			    
			    if(allAirportsList.size() > 0){
			  	  for(Airports airport:allAirportsList){
			  		  %>
			  		  <option value="<%= airport.getId() %>"> <%= airport.getCode() %> -  <%= airport.getName() %> </option>			  		  
			  		  <%			  		 
			  	  }
			  	  
			    }
			    
			    %>
		</select>
    </div>
  </div>
   <div class="mb-3 row">
    <label for="airCountry" class="col-sm-2 col-form-label">Departure Time:</label>
    <div class="col-sm-10">
        <input type="time" required class="form-control" name="rtDeparture" id="airCode">
    </div>
  </div>
   <div class="mb-3 row">
    <label for="airCountry" class="col-sm-2 col-form-label">Destination Time:</label> <!-- arrival at destination -->
    <div class="col-sm-10">
        <input type="time" required class="form-control" name="rtArrival" id="airCode">
    </div>
  </div>
   <div class="mb-3 row">
    <label for="airCountry" class="col-sm-2 col-form-label">Date:</label>
    <div class="col-sm-10">
        <input type="date" min="<%= dateStr %>" value="<%= dateStr %>" required class="form-control" name="rtDate"  id="airCode">
    </div>
  </div>
  <div class="mb-3 row">
    <label for="airCountry" class="col-sm-2 col-form-label">Ticket Price:</label>
    <div class="col-sm-10">
        <div class="input-group mb-3">
		  <span class="input-group-text">&#x20B9;</span>
		  <input type="number" class="form-control" name="rtTicketPrice"  aria-label="Amount (to the nearest Rupee)">
		</div>
    </div>
  </div>
  
  <div class="mb-3 row">
    <label for="airCountry" class="col-sm-2 col-form-label">Total Seats:</label>
    <div class="col-sm-10">
        <input type="number" required class="form-control" name="rtSeats" id="airCode">
    </div>
  </div>
  <input class="btn btn-primary" type="submit" value="Create Route"/>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>