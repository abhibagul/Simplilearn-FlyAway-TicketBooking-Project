<%@page import="java.util.List"%>
<%@page import="flyaway.entities.Airports"%>
<%@page import="org.hibernate.Query"%>
<%@page import="flyaway.helper.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="flyaway.entities.Customer"%>
<%

Customer customer_session_nav = (Customer)session.getAttribute("user");

		
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/navbar.css"/>
<header class="p-3 text-bg-white shadow-sm">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="<%= request.getContextPath() %>/" class="d-flex align-items-center mb-lg-0 text-white text-decoration-none">
        	<img src="<%= request.getContextPath() %>/assets/logo.png" alt="" height="57">
        </a>
		
        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0 px-3">
          <li><a href="#" class="nav-link px-2">Search Flights</a></li>
    
          <%
          if(customer_session_nav != null){
        		  
          	if(customer_session_nav.getUserRole().equals("Admin")){
          		%>
          		
          		
		          <li><a href="<%= request.getContextPath() %>/manageAirlines.jsp" class="nav-link px-2">Manage Airlines</a></li>
		          <li><a href="<%= request.getContextPath() %>/manageRoute.jsp" class="nav-link px-2 ">Manage Routes</a></li>
		          <li><a href="<%= request.getContextPath() %>/manageAirports.jsp" class="nav-link px-2 ">Manage Airports</a></li>
          		
          		<%
          	}
          	if(customer_session_nav.getUserRole().equals("Customer")){
          		%>
          			<li><a href="<%= request.getContextPath() %>/myBookings.jsp" class="nav-link px-2">My Bookings</a></li>
          		
          		<%
          	}
          	
          }
          %>
          
        </ul>

        	<div class="text-end">
               <%
		       if(customer_session_nav != null){
		    	   %>
		    	   <a href="" class="btn btn-primary me-2 btn-sm">My Profile</a>
		    	   <a href="<%= request.getContextPath() %>/logout.jsp" class="btn btn-primary me-2 btn-sm">Logout</a>
		    	   <%
		       }else{
		    	   
		    	   %>
		    	   <a href="<%= request.getContextPath() %>/login.jsp" class="btn  btn-outline-primary me-2 btn-sm">Login</a>
          			<a href="<%= request.getContextPath() %>/signup.jsp" class="btn btn-primary btn-sm">Sign-up</a>
          <%
		       }
	       
       		%>
        
          
        </div>
      </div>
    </div>
  </header>
  <%
  Session sAirList = FactoryProvider.getFactory().openSession();
  Query airList = sAirList.createQuery("FROM Airports ");
  List<Airports> allAirportsList = airList.list();
  
  
  
  %>
  <div class="nav-scroller bg-body shadow-sm mb-3 p-3">
  <div class="container">
 	<div class="row">
 		<div class="col-sm-3">
 			<div class="form-floating">
			  <select class="form-select" id="floatingSelect" aria-label="Floating label select example">
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
			  <label for="floatingSelect">Source</label>
			</div>
 		</div>
 		<div class="col-sm-3">
 			<div class="form-floating">
			  <select class="form-select" id="floatingSelect" aria-label="Floating label select example">
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
			  <label for="floatingSelect">Destination</label>
			</div>
 		</div>
 		<div class="col-sm-2">
 		<%
			java.sql.Date dateStr=new java.sql.Date(System.currentTimeMillis());
		    			
		
		%>
 			 <div class="form-floating">
			     <input type="date" min="<%= dateStr %>" class="form-control last" value="<%= dateStr %>" name="regPhone" id="regPhone" required placeholder="<%= dateStr %>">
			     <label for="regPhone">Travel Date</label>
			   </div>
 		</div>
 		<div class="col-sm-2">
 			<div class="form-floating">
			  <input type="number" class="form-control" id="floatingPassword"  value="1">
			  <label for="floatingPassword">Number of Persons</label>
			</div>
 		</div>
 		
 		<div class="col-sm-2 text-end">
 			<input type="submit" class="btn btn-primary block-btn" value="Search Flights" />
 		</div>
 	</div>
 	</div>
	</div><!-- tour details picker -->