<%@page import="flyaway.entities.Route"%>
<%@page import="flyaway.entities.Airlines"%>
<%@page import="flyaway.entities.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight Search - Flyaway</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="bg-light">
<%

Customer customer_session = (Customer)session.getAttribute("user");

%>
<%@ include file="navbar.jsp" %>
<div class="container">

<%
	Session s = FactoryProvider.getFactory().openSession();
	
	Query qAirLine = s.createQuery("FROM Airlines where id=:id");
	Query qAirports = s.createQuery("FROM Airports where id=:id");
	String nameQuery = "";
	nameQuery = " ";
	
	
	Query q = s.createQuery("FROM Route WHERE date=:date and source=:source and destination=:destination " + nameQuery);
	q.setParameter("date",  request.getParameter("fsDate"));
	q.setParameter("source", Integer.parseInt( request.getParameter("fsSource")));
	q.setParameter("destination",  Integer.parseInt(request.getParameter("fsDest")));
	
	List<Route> allRoutes = q.list();
	
	if(allRoutes.size() > 0){
		
		%>
		
		<div class="row">
		
		<%
		
		for(Route route:allRoutes){
			
			%>
			<%
				
					qAirLine.setParameter("id", route.getAirline());
					Airlines arline = (Airlines) qAirLine.uniqueResult();
					
					qAirports.setParameter("id", route.getSource());
					Airports sourceAirport = (Airports) qAirports.uniqueResult();
					
					qAirports.setParameter("id", route.getDestination());
					Airports destAirport = (Airports) qAirports.uniqueResult();
					
				%>
			<div class=" mb-3 mt-2 col-sm-12">
			<div class="p-3 bg-body shadow-sm">
				<div class="row">
					<div class="col-sm-3 text-center">
						<span class="display-6"><%= route.getDeparture() %></span>
						<br/>
						<span class=" fw-bold"><%= sourceAirport.getCode() %></span>
						<br/>
						<span class=""><%= sourceAirport.getName() %></span>
					</div>
					<div class="col-sm-3 text-center my-2">
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
					
					<div class="col-sm-3 text-end">
						<h3 class="text-end">&#x20B9; <%= route.getPrice() %>/- each</h3><br/>
						<% if(customer_session != null){
							
							%>
							<form method="post" action="<%= request.getContextPath() %>/bookTicket.jsp">
								<input type="hidden" name="bookId" value="<%= route.getId() %>"/>
								<input type="hidden" name="bookSeats" value="<%= fsSeats %>"/>
								<input type="submit" class="btn btn-primary my-1" value="Book Ticket"/>
							</form>
							<%
						}else{
							
							%>
							<a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-primary">Login to book ticket</a>
						<%
						} %>
					
					</div>
					
				
				</div>
			
				
				</div>
			</div>
			
			<%
		}
		
		%>
		
		</div>
		
		<%
	}else{
		%>
		<div class="bg-body shadow-sm mb-3 p-3 mt-2">
		<div class="px-4 py-5 my-5 text-center">
    <h3 class="display-5 fw-bold mt-5">No Flights on this route :(</h3>
    <div class="col-lg-6 mx-auto">
      <p class="lead mb-4">There seems to be no flights scheduled on this route, on this date.</p>
     
    </div>
  </div>
  </div>
		
		<%
	}
	
	s.close();
	
%>


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</html>