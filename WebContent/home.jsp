<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Welcome</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.navBar {
	margin: 0px;
}
</style>
</head>

<body>
	<%
		String uid = (String) session.getAttribute("uid");

		//redirect user to login page if not logged in
		if (uid == null) {
			response.sendRedirect("index.jsp");
		} else {

		}
	%>
	<div class="navBar">
		<nav class="navbar navbar-inverse">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" data-target="#navbarCollapse"
					data-toggle="collapse" class="navbar-toggle">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="./home.jsp" class="navbar-brand"><%=uid%></a>
			</div>
			<!-- Collection of nav links, forms, and other content for toggling -->
			<div id="navbarCollapse" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="./travel.jsp">Travel</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./logout.jsp">Logout</a></li>
				</ul>
			</div>
		</nav>
	</div>
	<div class=col-md-2></div>
	<div class="col-md-8">
	<%
			String status = request.getParameter("status");
			if (status != null) {
				if (status.equals("INF")) {
					out.print("<h1 style=\"color:red\">You do not have required item(s)!</h1>");
				}
				else {
					out.print("Some error occurred!");
				}
			}
		%>
<%
    // -- Connection
    Class.forName("com.mysql.jdbc.Driver");
    String URL="jdbc:mysql://[databaseurl]/";
    String DATABASE_NAME="mycs336db";
    String USERNAME="someusername";
    String PASSWORD="somepassword";
    Connection con =DriverManager.getConnection(URL+DATABASE_NAME,USERNAME,PASSWORD);
    Statement st = con.createStatement();
    // --
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM users WHERE uid='" + uid + "'");
    rs.next();
    out.print("<h1>");
    	out.print("Name: " + rs.getString("name") + "<br/>Gold: " + rs.getString("gold"));
    out.print("</h1>");
    //rs = st.executeQuery("SELECT item_id, name, quantity FROM inventories, items WHERE uid='" + uid + "' AND item_id=id");

    rs = st.executeQuery("SELECT I.item_id, name, type, I.quantity FROM (SELECT item_id, quantity FROM inventories WHERE uid='" + uid + "') AS I, items WHERE I.item_id=id");

    out.print("<h1>");
		out.print("Inventory:");
	out.print("</h1>");
    out.print("<div class=\"bs-example\"><div class=\"table-responsive\"><table class=\"table table-bordered\">");
	out.print("<thead><tr>");
		out.print("<td>");
			out.print("item_id");
		out.print("</td>");
		out.print("<td>");
			out.print("name");
		out.print("</td>");
		out.print("<td>");
			out.print("quantity");
		out.print("</td>");
		out.print("<td>");
			out.print("type");
		out.print("</td>");

	out.print("</tr></thead><tbody>");

	while (rs.next()) {
		out.print("<tr>");
			out.print("<td>");
				out.print(rs.getString("item_id"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("name"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("quantity"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("type"));
			out.print("</td>");
		out.print("</tr>");
	}
	out.print("</tbody></div></div></table>");


	/////////////////
	//////////// RECIPES
	//////////////////////////////
    String complexQuery = "SELECT * FROM (((((recipes R LEFT JOIN (SELECT id, name as clth_name FROM items) AS C ON R.clth_id = C.id)";
    complexQuery += (" LEFT JOIN (SELECT id, name as lthr_name FROM items) AS L ON R.lthr_id = L.id)");
    complexQuery += (" LEFT JOIN (SELECT id, name as mtl_name FROM items) AS M ON R.mtl_id = M.id)");
    complexQuery += (" LEFT JOIN (SELECT id, name as wd_name FROM items) AS W ON R.wd_id = W.id)");
    complexQuery += (" LEFT JOIN (SELECT * FROM makes) AS z ON R.id = z.recipe_id)");
    complexQuery += (" LEFT JOIN (SELECT id, name as itemName FROM items) AS I ON z.item_id = I.id");
    //rs = st.executeQuery("SELECT * FROM (((recipes R LEFT JOIN (SELECT name as clth_name) AS C ON recipes.clth_id = C.id) LEFT JOIN (SELECT name as lthr_name) AS L ON recipes.lthr_id = L.id) LEFT JOIN (SELECT name as mtl_name) AS M ON recipes.mtl_id = M.id) LEFT JOIN (SELECT name as wd_name) AS W ON recipes.wd_id = W.id");
	rs = st.executeQuery(complexQuery);
    out.print("<h1>");
		out.print("Recipes:");
	out.print("</h1>");
    out.print("<div class=\"bs-example\"><div class=\"table-responsive\"><table class=\"table table-bordered\">");
	out.print("<thead><tr>");
		%>
		<form action="build.jsp" method="post">
		<td>
		<input type="submit" class="btn btn-primary" value=build>
		</td>
		<%
		out.print("<td>");
			out.print("recipe_id");
		out.print("</td>");
		out.print("<td>");
			out.print("makes");
		out.print("</td>");
		out.print("<td>");
			out.print("clth_name");
		out.print("</td>");
		out.print("<td>");
			out.print("clth_qntty");
		out.print("</td>");
		out.print("<td>");
			out.print("lthr_name");
		out.print("</td>");
		out.print("<td>");
			out.print("lthr_qntty");
		out.print("</td>");
		out.print("<td>");
			out.print("mtl_name");
		out.print("</td>");
		out.print("<td>");
			out.print("mtl_qntty");
		out.print("</td>");
		out.print("<td>");
			out.print("wd_name");
		out.print("</td>");
		out.print("<td>");
			out.print("wd_qntty");
		out.print("</td>");

	out.print("</tr></thead><tbody>");

	while (rs.next()) {
		out.print("<tr>");
			String val = rs.getString("id") +
					"/" + rs.getString("item_id") +
					"/" + rs.getString("clth_qntty") +
					"/" + rs.getString("clth_id") +
					"/" + rs.getString("lthr_qntty") +
					"/" + rs.getString("lthr_id") +
					"/" + rs.getString("mtl_qntty") +
					"/" + rs.getString("mtl_id") +
					"/" + rs.getString("wd_qntty") +
					"/" + rs.getString("wd_id");
			out.print("<td><input class=\"form-check-input\" type=\"radio\" name=\"buildRadios\" id=\"buildRadios" + rs.getString("id") + "'\" value=\"" + val + "\" checked></td><td>");
				out.print(rs.getString("id"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("itemName") + "-" + rs.getString("item_id"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("clth_name"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("clth_qntty"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("lthr_name"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("lthr_qntty"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("mtl_name"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("mtl_qntty"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("wd_name"));
			out.print("</td>");
			out.print("<td>");
				out.print(rs.getString("wd_qntty"));
			out.print("</td>");
		out.print("</tr>");
	}
	out.print("</tbody></div></div></table>");

	con.close();
%>
	</form>
	</div>
</body>
</html>
