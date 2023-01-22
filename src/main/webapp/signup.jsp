<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">


<style>
	html,
	body {
	  height: 100%;
	}
	
	body {
	  display: flex;
	  align-items: center;
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #f5f5f5;
	}
	
	.form-signin {
	  max-width: 330px;
	  padding: 15px;
	}
	
	.form-signin .form-floating:focus-within {
	  z-index: 2;
	}
	
	.form-signin input.first {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	
	.form-signin input.middle {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;	  
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
	
	.form-signin input.last {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
</style>
</head>
<body class="text-center">

<main class="form-signin w-100 m-auto">
  <form action="<%= request.getContextPath() %>/createCustomerServlet" method="post">
    <img class="mb-4" src="<%= request.getContextPath() %>/assets/logo.png" alt="" height="57">
    <h1 class="h3 mb-3 fw-normal">Create a new Account</h1>
    
    <%
    if(request.getParameter("error") != null){
    	%>
    	
    	<div class="alert alert-danger" role="alert">
		 <%= request.getParameter("error")  %>
		</div>
    	
    	<%

    }
    
    %>

	 <div class="form-floating">
      <input type="text" class="form-control first" name="regFName" id="regFName" required placeholder="First Name">
      <label for="regEmail">First Name</label>
    </div>
     <div class="form-floating">
      <input type="text" class="form-control middle" name="regLName" id="regLName" required placeholder="Last Name">
      <label for="regEmail">Last Name</label>
    </div>
    <div class="form-floating">
      <input type="email" class="form-control middle" name="regEmail" id="regEmail" required placeholder="name@example.com">
      <label for="regEmail">Email address</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control middle" name="regPass" id="regPass" required placeholder="Password">
      <label for="regPass">Password</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control middle" name="regCPass" id="regCPass" required placeholder="Password">
      <label for="regCPass">Confirm Password</label>
    </div>
    <div class="form-floating">
      <input type="number" class="form-control last" name="regPhone" id="regPhone" required placeholder="1234567890">
      <label for="regPhone">Phone</label>
    </div>

 
    <button class="w-100 btn btn-lg btn-primary" type="submit">Create New Account</button>

  </form>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</body>
</html>