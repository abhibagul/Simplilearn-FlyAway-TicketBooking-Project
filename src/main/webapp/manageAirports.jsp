<%@page import="flyaway.entities.Airports"%>
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
<title>Manage Airports</title>
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
<h2>Manage Airports</h2>
</div>

<div class="col-sm-4">
<div class="row">
<div class="col-sm-8">
<form method="get" action="<%= request.getContextPath() %>/manageAirports.jsp">
	<div class="form-floating">
			  <input type="text" name="q" class="form-control" id="floatingPassword"  placeholder="Search Airline"  <% if(request.getParameter("q") != null){%> value="<%= request.getParameter("q") %>" <% } %> >
			  <label for="floatingPassword">Search Airports</label>
			</div>
	
</form>
</div>
<div class="col-sm-4 text-end">

<a href="<%= request.getContextPath() %>/manageAirports/createAirport.jsp" class="btn btn-outline-primary block-btn">+ New Airport</a>
</div>
</div>
</div>
</div>
<hr/>

<%
	Session s = FactoryProvider.getFactory().openSession();
	String nameQuery = "";
	if(request.getParameter("q") != null){
		nameQuery = " where name LIKE :name";
	}
	
	Query q = s.createQuery("FROM Airports " + nameQuery);
	if(request.getParameter("q") != null){
		q.setParameter("name", "%" + request.getParameter("q") + "%");
	}
	List<Airports> allAirports = q.list();
	
	if(allAirports.size() > 0){
		
		%>
		
		<div class="row">
		
		<%
		
		for(Airports airport:allAirports){
			
			%>
			
			<div class=" mb-3 mt-2 col-sm-4">
			<div class="p-3 bg-body shadow-sm">
				<h3 class="display-8 fw-bold"><%= airport.getCode() %></h3>
				<hr/>
				<span> <b> <%= airport.getName() %></b> <br/> <%= airport.getCountry() %></span>
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
    <h3 class="display-5 fw-bold mt-5">No Airports Exist</h3>
    <div class="col-lg-6 mx-auto">
      <p class="lead mb-4">You seems to be new here, lets get started by adding a airport.</p>
      <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
      <a href="<%= request.getContextPath() %>/manageAirports/createAirport.jsp" class="btn btn-outline-primary btn-lg px-4 gap-3">+ New Airport</a>
       
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