<%@page import="flyaway.entities.Route"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="flyaway.helper.FactoryProvider"%>
<%@page import="flyaway.entities.Airlines"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Route</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<style>
    .block-btn{width: 100%;
    height: 100%;
    justify-content: center;
    align-items: center;
    display: flex;
    }
    </style>
</head>
<body class="bg-light">

<%@ include file="navbar.jsp" %>
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

<div class="container">

<div class="row mt-4">
<div class="col-sm-8">
<h2>Manage Route</h2>
</div>

<div class="col-sm-4">
<div class="row">
<div class="col-sm-8">
<form id="dateFilterForm" method="get" action="<%= request.getContextPath() %>/manageRoute.jsp">
	<div class="form-floating">
			  <input type="date" name="q" onchange="document.getElementById('dateFilterForm').submit();" class="form-control" id="floatingPassword"  placeholder="Search Airline"  <% if(request.getParameter("q") != null){%> value="<%= request.getParameter("q") %>" <% }else{ %> value="<%= dateStr %>" <% } %> >
			  <label for="floatingPassword">Filter Route by Dates</label>
			</div>
	
</form>
</div>
<div class="col-sm-4 text-end">

<a href="<%= request.getContextPath() %>/manageRoute/createRoute.jsp" class="btn btn-outline-primary block-btn">+ New Route</a>
</div>
</div>
</div>
</div>
<hr/>

<%
	Session s = FactoryProvider.getFactory().openSession();
	
	Query qAirLine = s.createQuery("FROM Airlines where id=:id");
	Query qAirports = s.createQuery("FROM Airports where id=:id");
	String nameQuery = "";
	if(request.getParameter("q") != null){
		nameQuery = " where date=:date";
	}
	
	Query q = s.createQuery("FROM Route " + nameQuery);
	if(request.getParameter("q") != null){
		q.setParameter("date",  request.getParameter("q"));
	}
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
						<h3 class="text-end">&#x20B9; <%= route.getPrice() %></h3>
						<form method="post" action="<%= request.getContextPath() %>/manageRoute/modifyRoute.jsp">
							<input type="hidden" name="routeId" value="<%= route.getId() %>"/>
							<input type="submit" class="btn btn-outline-primary btn-sm my-1" value="Edit Route"/>
						</form>
						
						<form method="post" action="<%= request.getContextPath() %>/removeRouteServlet">
							<input type="hidden" name="routeId" value="<%= route.getId() %>"/>
							<input type="submit" class="btn btn-outline-danger btn-sm my-1" value="Delete Route"/>
						</form>
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
    <h3 class="display-5 fw-bold mt-5">No Routes Exist</h3>
    <div class="col-lg-6 mx-auto">
      <p class="lead mb-4">You seems to be new here, lets get started by creating a route.</p>
      <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
      <a href="<%= request.getContextPath() %>/manageRoute/createRoute.jsp" class="btn btn-outline-primary btn-lg px-4 gap-3">+ New Route</a>
       
      </div>
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