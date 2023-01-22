<%@page import="flyaway.entities.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flyaway</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="bg-light">
<%

Customer customer_session = (Customer)session.getAttribute("user");

%>
<%@ include file="navbar.jsp" %>
<div class="container">

<div class="px-4 py-5 my-5 text-center">
    <img src="<%= request.getContextPath() %>/assets/logo.png" alt="" height="57">
    <h1 class="display-5 fw-bold">
    <%
    
    if(customer_session != null){
    	%>
    	Welcome <%= customer_session.getFirstName() %>,
    	<%
    }else{
    	%>
    	Book your Flight Tickets
    	<%
    }
    
    %>    
    </h1>
    <div class="col-lg-6 mx-auto">
      
       <%
    
    if(customer_session != null){
    	%>
    	
    	<%
    	
    	if(customer_session.getUserRole().equals("Admin")){
    		
    		
    	%>
    	
    	<p class="lead mb-4">Let's setup new routes for booking !</p>
    	<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
        <a href="<%= request.getContextPath() %>/manageAirlines.jsp" class="btn btn-primary btn-lg px-4 gap-3">Manage Airlines</a>
        <a href="<%= request.getContextPath() %>/manageAirlines.jsp" class="btn btn-primary btn-lg px-4 gap-3">Manage Destinations</a>
        <a href="<%= request.getContextPath() %>/manageAirlines.jsp" class="btn btn-primary btn-lg px-4 gap-3">Manage Routes</a>
      </div>
      <% 
      
    	}else{
    		%>
        	
        	<p class="lead mb-4">Ready for the next trip or want to see your bookings?</p>
        	<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
            <a href="<%= request.getContextPath() %>/myBookings.jsp" class="btn btn-primary btn-lg px-4 gap-3">My Bookings</a>
          </div>
          <% 
    		
    	}
    	
    	%>
      
    	<%
    }else{
    	%>
    	<p class="lead mb-4">With flyaway book your tickets with ease</p>
    	<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-primary btn-lg px-4 gap-3">Login</a>
        <a href="<%= request.getContextPath() %>/signup.jsp" class="btn btn-outline-secondary btn-lg px-4">Register</a>
      </div>
    	<%
    }
    
    %>  
      
    </div>
  </div>


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</html>