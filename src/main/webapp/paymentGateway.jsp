<%@page import="java.util.UUID"%>
<%@page import="flyaway.entities.Route"%>
<%@page import="flyaway.entities.Airlines"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Ticket Payment</title>
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
<form action="<%= request.getContextPath() %>/createTicketServlet" method="post">
	<input type="hidden" name="bookId" value="<%= request.getParameter("bookId") %>"/>
	<input type="hidden" name="bookSeats" value="<%= request.getParameter("bookSeats") %>"/>
	<input type="hidden" name="payment_mode" value="<%=request.getParameter("payment_mode") %>"/>
	<%
		//create a random txn id
		String txnid = UUID.randomUUID().toString();
	%>
	<input type="hidden" name="txnid" value="<%= txnid %>"/>
	
	
	
	
	
	
		<% 
		
		for(int i=1; i <= Integer.parseInt(request.getParameter("bookSeats")); i++){
			
		%>
		
		<%
			//values
			String fname = "bookFirstName" + i;
			String lname = "bookLastName" + i;
			String age = "bookAge" + i;
		
		%>
		<!-- Person Details -->		
		<input required class="form-control" name="bookFirstName<%= i %>" value="<%= request.getParameter(fname) %>" type="hidden" placeholder="First Name"/>	
		<input required value="<%= request.getParameter(lname) %>" class="form-control" name="bookLastName<%= i %>" type="hidden" placeholder="Last Name"/>	
		<input required value="<%= request.getParameter(age) %>" class="form-control" name="bookAge<%= i %>" type="hidden" placeholder="Age"/>
		
		
		<% 
		} 
		%>
		
	

	<% 
		int total = Integer.parseInt(request.getParameter("bookSeats")) * route.getPrice();
				%>
		<div class="row">
		<div class="col-sm-8">
	<%
	
	//credit_debit_card
	
	if(request.getParameter("payment_mode").equals("credit_debit_card")){
		
		%>
		<div class="alert alert-light col-sm-12">
			<div class="p-3 bg-white rounded shadow-sm ">
				
				
				<div class="row mt-1 p-1">
					<div class="col-sm-12 mb-1">
						<label class="text-dark  fw-bold">Name on Card:</label>
					</div>
					<div class="col-sm-12">
						<input type="text" class="form-control" value="Your Name"/>
					</div>
				</div>
				<div class="row mt-0 p-1 mt-1">
					<div class="col-sm-12 mb-1">
						<label class="text-dark  fw-bold">Card Number:</label>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="1234"/>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="5678"/>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="1234"/>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="5678"/>
					</div>
				</div>
				
				<div class="row mt-1 p-1">
					<div class="col-sm-6 mb-1">
						<label class="text-dark  fw-bold">Card Expiry:</label>
					</div>
					<div class="col-sm-6 mb-1">
						<label class="text-dark fw-bold">CVV:</label>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="12"/>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="2023"/>
					</div>
					<div class="col-sm-3">
						<input type="number" class="form-control text-center" value="123"/>
					</div>
				</div>
				<br/>
			</div>
		</div>
		
		<%		
				
			}
	
	


		if(request.getParameter("payment_mode").equals("UPI")){
				
				%>
				<div class="alert alert-light col-sm-12">
					<div class="p-3 bg-white rounded shadow-sm ">
						
						
						<div class="row mt-1 p-1">
							<div class="col-sm-12 mb-1">
								<label class="text-dark  fw-bold">VPA:</label>
							</div>
							<div class="col-sm-12">
								<input type="text" class="form-control" value="<%= customer_session.getFirstName().toLowerCase() %><%= customer_session.getLastName().toLowerCase() %>@okbank"/>
							</div>
						</div>
						<br/>
					</div>
				</div>
				
				<%
		}
		
		
		if(request.getParameter("payment_mode").equals("net_banking")){
			
			%>
			<div class="alert alert-light col-sm-12">
				<div class=" ">
					
					
					<div class="row mt-1 p-1">
						<div class="col-sm-12 mb-1">
							<p class="text-dark  fw-bold text-center">Flyaway wants &#x20B9; <%= total %>,<br/>  Select the account for payment.</p>
						</div>
						<div class="col-sm-12">
							<div class="form-check form-check p-3 bg-white rounded shadow-sm m-1 mt-2">
							  <input class="form-check-input mx-2" name="ignore" checked type="radio">
							  <label class="form-check-label" for="inlineRadio2">xxxx xxxx xxxx 1234 / Savings</label>
							</div>
							<div class="form-check form-check p-3 bg-white rounded shadow-sm m-1 mt-2">
							  <input class="form-check-input mx-2"  name="ignore"  type="radio">
							  <label class="form-check-label" for="inlineRadio2">xxxx xxxx xxxx 5678 / Current</label>
							</div>
							<div class="form-check form-check p-3 bg-white rounded shadow-sm m-1 mt-2">
							  <input class="form-check-input mx-2"  name="ignore"  type="radio">
							  <label class="form-check-label" for="inlineRadio2">xxxx xxxx xxxx 9999 / Savings</label>
							</div>
						</div>
					</div>
					<br/>
				</div>
			</div>
			
			<%
	}
	%>
	
</div>
		

	<div class="col-sm-4">
	
	<h3>Total Amount: &#x20B9;<%= total %>/-</h3>
	<input type="hidden" name="total_amount" value="<%=total %>"/>
	<div class="summery mb-1">
	<label class="text-secondary">Ticket Amount: &#x20B9;<%= route.getPrice() %>/-</label><br/>
	<label class="text-secondary">Total Persons: <%= request.getParameter("bookSeats") %></label>
	</div>
	<div class="alert alert-primary mt-2">
	<p class="text-dark">For the development Purpose select the transaction should be:</p>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" checked type="radio" name="payment_status" id="inlineRadio2" value="success">
	  <label class="form-check-label" for="inlineRadio2">Approved</label>
	</div>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="payment_status" id="inlineRadio3" value="failed">
	  <label class="form-check-label" for="inlineRadio3">Rejected</label>
	</div>
	</div>
  	<input class="btn btn-primary mt-1" type="submit" value="Pay &#x20B9; <%= total %>/-"/>
  </div>
  </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</html>