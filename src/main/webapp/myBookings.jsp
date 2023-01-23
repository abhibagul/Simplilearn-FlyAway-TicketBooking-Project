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
 
   
  Query allTicket = s.createQuery("FROM Ticket WHERE bookingUID=:bookingUID group by transaction_id ORDER BY id DESC");
  allTicket.setParameter("bookingUID",  customer_session.getId());  
  
  List<Ticket> ticketList = allTicket.list();
   
  //to fetch required data
  for(Ticket t:ticketList){
	  
	 int routeId = t.getRouteId();
	 String paymentMethod = t.getPaymentMethod();
	 String transaction_amount = t.getTransaction_amount();
	 String transaction_status = t.getTransaction_status();
	 String txnid = t.getTransaction_id();
	 
	  
	Session routeFactory = FactoryProvider.getFactory().openSession();
	Query routeDetails = routeFactory.createQuery("FROM Route WHERE id=:routeId");
	routeDetails.setParameter("routeId",  routeId);
	Route route = (Route) routeDetails.uniqueResult();
		  
		 
						
	qAirLine.setParameter("id", route.getAirline());
	Airlines arline = (Airlines) qAirLine.uniqueResult();
	
	qAirports.setParameter("id", route.getSource());
	Airports sourceAirport = (Airports) qAirports.uniqueResult();
	
	qAirports.setParameter("id", route.getDestination());
	Airports destAirport = (Airports) qAirports.uniqueResult();

	%>
		
			<div class="col-sm-12">				
				<div class="container my-3 p-3 bg-body rounded shadow-sm">
				
	<div class="container p-3 rounded my-2 alert <%  if(transaction_status.equals("success")){ %> alert-success <% }else{ %> alert-danger <% } %>" >
		<div class="row">
		<div class="col-sm-8">
		<h6 class="my-3 ">Transaction ID: <%= t.getTransaction_id() %></h6>
		<h6 class="my-3 ">Payment Status: <span class="<%  if(transaction_status.equals("success")){ %> text-success <% }else{ %> text-danger <% } %>"><%= t.getTransaction_status() %></span></h6>
	</div>
	<div class="col-sm-4 text-end">
		<a class="btn btn-primary mt-4" href="<%= request.getContextPath() %>/viewBooking.jsp?txnid=<%= t.getTransaction_id() %>">View Details</a>
	</div>
	</div>
	</div>
	<div class="container p-3 rounded my-2 alert " >
		<div class="row ">
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
				</div>				
			</div>
		
	<% 

  }//ticket for

%>

	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>