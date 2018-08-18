<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>CS336: Final Project</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.main-content {
	padding: 15px;
	font-size: 18px;
	/* min-height: 300px; */
	/* background: #dbdfe5; */
	margin-bottom: 10px;
}

.main-content.bg-alt {
	background: #6699CC;
}
</style>
</head>
<body>
<div class="container">
<!--Row with three columns divided in 1:4:1 ratio-->
	<div class="row">
	<hr>
		<div class="col-md-2">
			<div class="main-content"></div>
		</div>
		<div class="col-md-8">
			<div class="main-content bg-alt">
				<form action="loginRequestHandler.jsp" method="post">
					<h1 style="color: white;">CS:336 Final Project</h1>
					<div class="row">
					<div class="col-md-12">
                		<div class="input-group">
                    		<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                    		<input type="text" class="form-control" placeholder="Username" name="uid" required>
                		</div>
            		</div>
            		</div>
            		<div class="row">
            		<div class="col-md-12">
                		<div class="input-group">
                    		<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                    		<input type="password" class="form-control" placeholder="Password" name="pass" required>
                		</div>
            		</div>
            		</div>
					<br/>
					<center>
						<a href="./register.jsp" class="btn btn-success">Register</a>
						<button type="submit" class="btn btn-primary" value="submit">Login</button>
					</center>
				</form>
				<%
				String uid = (String) session.getAttribute("uid");

				//redirect user to home page if already logged in
				if (uid != null) {
					response.sendRedirect("home.jsp");
				}

				String status = request.getParameter("status");

				if (status != null) {
					if (status.equals("false")) {
						out.print("Incorrect login details!");
					} else {
						out.print("Some error occurred!");
					}
				}
				%>
			</div>
		</div>
		<div class="col-md-2">
			<div class="main-content"></div>
		</div>
	</div>
	<hr>
</div>
</body>
</html>