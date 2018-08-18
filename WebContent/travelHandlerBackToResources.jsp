<%@ page import="java.sql.*, java.util.*"%>
<%
	int marketLocation = Integer.parseInt(request.getParameter("market"));

	// -- Connection
	Class.forName("com.mysql.jdbc.Driver");
	String URL="jdbc:mysql://[databaseurl]/";
	String DATABASE_NAME="dbName";
	String USERNAME="someusername";
	String PASSWORD="someurl";
	Connection con = DriverManager.getConnection(URL + DATABASE_NAME, USERNAME, PASSWORD);
	Statement st = con.createStatement();
	// --

	String uid = (String) session.getAttribute("uid");
	int newLoc = marketLocation + 4;
	System.out.println("NEW LOC" + newLoc);

	PreparedStatement ps = null;
	String sql="Update users set location=? where uid='"+uid+"'";
	ps = con.prepareStatement(sql);
	ps.setInt(1,newLoc);
	try {
		int i = ps.executeUpdate();
		if (i > 0) {
			//session.setAttribute("userid", user);
			response.sendRedirect("travel.jsp");
			// out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
		} else {
			response.sendRedirect("travel.jsp?status=false");
		}
	} catch (Exception ex) {
		response.sendRedirect("travel.jsp?status=false");
		System.out.print(ex.getLocalizedMessage());
	} finally {
    	con.close();
    }
%>
