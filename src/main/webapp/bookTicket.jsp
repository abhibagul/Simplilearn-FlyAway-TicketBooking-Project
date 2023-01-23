<%@page import="java.util.UUID"%>
<%@page import="flyaway.entities.Route"%>
<%@page import="flyaway.entities.Airlines"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Ticket</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="bg-light">

<%@ include file="../navbar.jsp" %>
<%

Customer customer_session = (Customer)session.getAttribute("user");

if(customer_session != null){
	
}else{
	response.sendRedirect(request.getContextPath() + "/");
}

if(request.getParameter("bookId") != null && request.getParameter("bookSeats") != null){
	
}else{
	response.sendRedirect(request.getContextPath() + "/");
	return;
}

%>

<h2 class="my-3 container mt-3">Book Ticket</h2>


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
	
  Query qAirLine = s.createQuery("FROM Airlines where id=:id");
  Query qAirports = s.createQuery("FROM Airports where id=:id");
  
  Session routeFactory = FactoryProvider.getFactory().openSession();
  Query routeDetails = routeFactory.createQuery("FROM Route WHERE id=:routeId");
  routeDetails.setParameter("routeId",  Integer.parseInt(request.getParameter("bookId")));
  Route route = (Route) routeDetails.uniqueResult();
  %>
  
  <%
				
		qAirLine.setParameter("id", route.getAirline());
		Airlines arline = (Airlines) qAirLine.uniqueResult();
		
		qAirports.setParameter("id", route.getSource());
		Airports sourceAirport = (Airports) qAirports.uniqueResult();
		
		qAirports.setParameter("id", route.getDestination());
		Airports destAirport = (Airports) qAirports.uniqueResult();
					
	%>
	<div class="container p-3 bg-primary rounded shadow-sm my-2" >
		<div class="row text-white">
					<div class="col-sm-3 text-center">
						<span class="display-6"><%= route.getDeparture() %></span>
						<br/>
						<span class=" fw-bold"><%= sourceAirport.getCode() %></span>
						<br/>
						<span class=""><%= sourceAirport.getName() %></span>
					</div>
					<div class="col-sm-6 text-center my-2">
					<div class="fw-bold"><%= arline.getName() %></div>
						<hr/>
						<div class="fw-bold"><%= route.getDate() %></div>
					</div>
					<div class="col-sm-3 text-center">
						<span class="display-6"><%= route.getArrival() %></span>
						<br/>
						<span class=" fw-bold"><%= destAirport.getCode() %></span>
						<br/>
						<span class=""><%= destAirport.getName() %></span>
					</div>
					
				</div>
	</div>
	<div class="container my-3 p-3 bg-body rounded shadow-sm">
<form action="<%= request.getContextPath() %>/paymentGateway.jsp" method="post">
	<input type="hidden" name="bookId" value="<%= request.getParameter("bookId") %>"/>
	<input type="hidden" name="bookSeats" value="<%= request.getParameter("bookSeats") %>"/>
	
	<h6>Passenger Details</h6>
	
	
	<div class="alert alert-light">

		<% 
		
		for(int i=1; i <= Integer.parseInt(request.getParameter("bookSeats")); i++){
			
		%>
		<!-- Person Details -->
		<div class=" p-3 bg-body rounded shadow-sm my-2" >
			<div class="row">
				<div class="col-sm-2">
					<h6 class="mb-0 mt-2">Passenger <%= i %></h6>
				</div>
				<div class="col-sm-4">
					<input required class="form-control" name="bookFirstName<%= i %>" type="text" placeholder="First Name"/>
				</div>
				<div class="col-sm-3">
					<input required class="form-control" name="bookLastName<%= i %>" type="text" placeholder="Last Name"/>
				</div>
				<div class="col-sm-3">
					<input required class="form-control" name="bookAge<%= i %>" type="number" placeholder="Age"/>
				</div>
			</div>
		</div>
		
		<% 
		} 
		%>
		
	</div>

	<% 
		int total = Integer.parseInt(request.getParameter("bookSeats")) * route.getPrice();
				%>
		

	<div class="col-sm-12">
	
	<h3>Total Amount: &#x20B9;<%= total %>/-</h3>
	<div class="summery">
	<label class="text-secondary">Ticket Amount: &#x20B9;<%= route.getPrice() %>/-</label><br/>
	<label class="text-secondary">Total Persons: <%= request.getParameter("bookSeats") %></label>
	</div>
	<hr/>
	<div class="col-sm-12 my-3">
	
	<label>Payment Method: &nbsp;&nbsp;&nbsp;</label>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" checked type="radio" name="payment_mode" id="inlineRadio1" value="credit_debit_card">
	  <label class="form-check-label" for="inlineRadio1">Credit Card / Debit Card</label>
	</div>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="payment_mode" id="inlineRadio2" value="UPI">
	  <label class="form-check-label" for="inlineRadio2">UPI</label>
	</div>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="payment_mode" id="inlineRadio3" value="net_banking">
	  <label class="form-check-label" for="inlineRadio3">Net Banking</label>
	</div>
	</div>
  <input class="btn btn-primary" type="submit" value="Proceed to Payment"/>
  </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>