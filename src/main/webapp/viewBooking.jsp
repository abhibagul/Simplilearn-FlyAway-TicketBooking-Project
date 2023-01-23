<%@page import="flyaway.entities.Ticket"%>
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

if(request.getParameter("txnid") != null){
	
}else{
	response.sendRedirect(request.getContextPath() + "/");
	return;
}

%>



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
 
   
  Query allTicket = s.createQuery("FROM Ticket where transaction_id=:txnid and bookingUID=:bookingUID");
  allTicket.setParameter("txnid",  request.getParameter("txnid"));
  allTicket.setParameter("bookingUID",  customer_session.getId());  
  
  List<Ticket> ticketList = allTicket.list();
  
  int routeId = 0;
  String paymentMethod = "";
  String transaction_amount = "";
  String transaction_status = "";
  
  //to fetch required data
  for(Ticket t:ticketList){
	  routeId = t.getRouteId();
	  paymentMethod = t.getPaymentMethod();
	  transaction_amount = t.getTransaction_amount();
	  transaction_status = t.getTransaction_status();
  }
  
  Session routeFactory = FactoryProvider.getFactory().openSession();
  Query routeDetails = routeFactory.createQuery("FROM Route WHERE id=:routeId");
  routeDetails.setParameter("routeId",  routeId);
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
	
	<h3 class="text-center my-3  <%  if(transaction_status.equals("success")){ %> text-success <% }else{ %> text-danger <% } %>"> Your Ticket is  <%  if(transaction_status.equals("success")){ %> Confirmed <% }else{ %> Failed <% } %></h3>
	
	<div class="container p-3 <%  if(transaction_status.equals("success")){ %> bg-success <% }else{ %> bg-danger <% } %> rounded shadow-sm my-2" >
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
<div >
	
	<h6>Passenger Details</h6>
	
	
	<div class="alert alert-light">
		<div class=" p-3 bg-primary shadow-sm " >
			<div class="row">
				<div class="col-sm-4">
				<h6 class="mb-0 text-white text-center">First Name</h6>
					
				</div>
				<div class="col-sm-3">
				<h6 class="mb-0 text-white text-center">Last Name</h6>
					
				</div>
				<div class="col-sm-3">
				<h6 class="mb-0  text-white text-center">Age</h6>
					
				</div>
				
				<div class="col-sm-2">
					<h6 class="mb-0 text-white text-center">Seat No</h6>
				</div>
			</div>
		</div>
		<% 
		
		for(Ticket ticket:ticketList){
			
		%>
		<!-- Person Details -->
		<div class=" p-3 bg-body shadow-sm" >
			<div class="row">
				
				<div class="col-sm-4 text-center">
					<%= ticket.getPassangerFirstName() %>
				</div>
				<div class="col-sm-3 text-center">
					<%= ticket.getPassangerLastName() %>
				</div>
				<div class="col-sm-3 text-center">
					<%= ticket.getPassangerAge() %>
				</div>
				<div class="col-sm-2">
					<h6 class="mb-0 mt-2 text-center fw-bold text-dark"><%= ticket.getSeatNo() %></h6>
				</div>
				
			</div>
		</div>
		
		<% 
		} 
		%>
		
	</div>

	<% 
		int perPrice = Integer.parseInt(transaction_amount) / ticketList.size();
				%>
		

	<div class="col-sm-12">
	
	<h3>Total Amount: &#x20B9; <%= transaction_amount %>/-</h3>
	<div class="summery">
	<label class="text-secondary"><b>Ticket Amount:</b> &#x20B9; <%= perPrice %>/-</label><br/>
	<label class="text-secondary"><b>Total Persons:</b> <%= ticketList.size() %></label><br/>
	<label class="text-secondary"><b>Payment Method:</b> <%= paymentMethod %></label><br/>
	<label class="text-secondary"><b>Transaction Id:</b> <%= request.getParameter("txnid") %></label><br/>
	<label class="text-secondary"><b>Transaction status:</b> <%= transaction_status %></label><br/>
	</div>
	
	
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>