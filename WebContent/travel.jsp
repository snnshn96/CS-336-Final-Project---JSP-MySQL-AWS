<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Travel</title>
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
					<li><a href="./home.jsp">Home</a></li>
					<li class="active"><a href="./travel.jsp">Travel</a></li>
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
				if (status.equals("IDE")) {
					out.print("<h1 style=\"color:red\">You do not have enough of this item</h1>");
				} else if (status.equals("NEG")){
					out.print("<h1 style=\"color:red\">You do not have enough gold</h1>");
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
	    String DATABASE_NAME="dbName";
	    String USERNAME="someusername";
	    String PASSWORD="someurl";
			Connection con = DriverManager.getConnection(URL + DATABASE_NAME, USERNAME, PASSWORD);
			Statement st = con.createStatement();
			// --

			ResultSet rs;
			rs = st.executeQuery("SELECT U.location, U.gold, L.name FROM users U, locations L WHERE U.uid='" + uid
					+ "' AND L.id = U.location");
			rs.next();
			int LocationID = rs.getInt("location");

			out.print("<h1>");
			out.print("Current Location: " + rs.getString("name") + "<br/>Gold: " + rs.getString("gold"));
			out.print("</h1>");

		%>
		<%
			if (LocationID > 4 && LocationID < 9) {
		%>

		<h1>Travel:</h1>
		<form action="travelHandlerTravel.jsp" method="post">
			<select class="form-control form-control-lg" name="location">
				<option value=<%out.print(((LocationID == 5) ? 1 : 5));%>><%out.print(((LocationID == 5) ? "Go to Market" : "cloth"));%></option>
				<option value=<%out.print(((LocationID == 6) ? 2 : 6));%>><%out.print(((LocationID == 6) ? "Go to Market" : "leather"));%></option>
				<option value=<%out.print(((LocationID == 7) ? 3 : 7));%>><% out.print(((LocationID == 7) ? "Go to Market" : "metal"));%></option>
				<option value=<%out.print(((LocationID == 8) ? 4 : 8));%>><%out.print(((LocationID == 8) ? "Go to Market" : "wood"));%></option>
				</select>
				<INPUT TYPE="HIDDEN" NAME="market" value=<%out.print("'" + LocationID + "'");%>>
				<input type="submit" class="btn btn-primary" value="Travel (1g)">
		</form>
		<form action="resourceGain.jsp" method="post">
		<%
		rs = st.executeQuery("SELECT I.id, I.name FROM items I INNER JOIN resources R ON R.type = I.type WHERE R.id=" + LocationID);
		out.print("<h1>");
		out.print("Gather Resources:");
		out.print("</h1>");
		out.print(
				"<div class=\"bs-example\"><div class=\"table-responsive\"><table class=\"table table-bordered\">");
		out.print("<thead><tr>");
		%>
		<td>
		<input type="hidden" NAME="resource" value=<%out.print("'" + LocationID + "'");%>>
		<input type="submit" class="btn btn-primary" value=gather>
		</td>
		<%
		out.print("<td>");
		out.print("item_id");
		out.print("</td>");
		out.print("<td>");
		out.print("name");
		out.print("</td>");

		out.print("</tr></thead><tbody>");

		while (rs.next()) {
			out.print("<tr>");
			out.print("<td><input class=\"form-check-input\" type=\"radio\" name=\"gainRadios\" id=\"gainRadios" + rs.getString("id") + "'\" value=\"" + rs.getString("id") + "\" checked></td><td>");
			out.print(rs.getString("id"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("name"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</tbody></div></div></table>");
		%>
		</form>
		<!--
			----------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------------------------
			-->
		<%
			} else {
		%>
		<div class="container">
			<div class="col-xs-12 col-xs-offset-0 col-sm-offset-3 col-sm-6">
				<form action="travelHandlerBackToResources.jsp" method="post">
					<INPUT TYPE="HIDDEN" NAME="market"
						value=<%out.print("'" + LocationID + "'");%>> <input
						type="submit" class="btn btn-default"
						value="Go back to resource">
				</form>
			</div>
		</div>
		<form action="marketBuy.jsp" method="post">
		<%
		rs = st.executeQuery(
				"SELECT T.item_id, I.name, T.price FROM items I, market_trades T WHERE T.market_id='" + LocationID + "' AND T.item_id=I.id AND T.trade_type='B'");
		out.print("<h1>");
		out.print("Buy:");
		out.print("</h1>");
		out.print(
				"<div class=\"bs-example\"><div class=\"table-responsive\"><table class=\"table table-bordered\">");
		out.print("<thead><tr>");
		%>
		<td>
		<input type="hidden" NAME="market" value=<%out.print("'" + LocationID + "'");%>>
		<input type="submit" class="btn btn-primary" value="buy">
		</td>
		<%
		out.print("<td>");
		out.print("item_id");
		out.print("</td>");
		out.print("<td>");
		out.print("name");
		out.print("</td>");
		out.print("<td>");
		out.print("price");
		out.print("</td>");

		out.print("</tr></thead><tbody>");

		while (rs.next()) {
			out.print("<tr>");
			out.print("<td><input class=\"form-check-input\" type=\"radio\" name=\"buyRadios\" id=\"buyRadios" + rs.getString("item_id") + "'\" value=\"" + rs.getString("item_id") + "\" checked></td><td>");
			out.print(rs.getString("item_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("name"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("price"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</tbody></div></div></table>");
		%>
		</form>
		<!-- ---------------------------------------------- -->
		<form action="marketSell.jsp" method="post">
		<%
		//rs = st.executeQuery("SELECT T.item_id, I.name, T.price FROM items I, market_trades T WHERE T.market_id='" + LocationID + "' AND T.item_id=I.id AND T.trade_type='S'");
		rs = st.executeQuery("SELECT T.item_id, I.name, T.price FROM items I INNER JOIN market_trades T ON T.item_id = I.id WHERE T.market_id='" + LocationID + "' AND T.trade_type='S'");
		out.print("<h1>");
		out.print("Sell:");
		out.print("</h1>");
		out.print(
				"<div class=\"bs-example\"><div class=\"table-responsive\"><table class=\"table table-bordered\">");
		out.print("<thead><tr>");
		%>
		<td>
		<input type="hidden" NAME="market" value=<%out.print("'" + LocationID + "'");%>>
		<input type="submit" class="btn btn-primary" value="sell">
		</td>
		<%
		out.print("<td>");
		out.print("item_id");
		out.print("</td>");
		out.print("<td>");
		out.print("name");
		out.print("</td>");
		out.print("<td>");
		out.print("price");
		out.print("</td>");

		out.print("</tr></thead><tbody>");

		while (rs.next()) {
			out.print("<tr>");
			out.print("<td><input class=\"form-check-input\" type=\"radio\" name=\"sellRadios\" id=\"sellRadios" + rs.getString("item_id") + "'\" value=\"" + rs.getString("item_id") + "\" checked></td><td>");
			out.print(rs.getString("item_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("name"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("price"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</tbody></div></div></table>");
		%>
		</form>
		<%
			}
			con.close();
		%>

	</div>
</body>
</html>
