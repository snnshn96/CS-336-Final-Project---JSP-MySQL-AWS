<%@ page import="java.sql.*, java.util.*"%>
<%
	int resource = Integer.parseInt(request.getParameter("resource"));
	int item = Integer.parseInt(request.getParameter("gainRadios"));


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

	System.out.println("resourceid = " + resource);
	System.out.println("item = " + item);


	ResultSet rs;
	String qry = "INSERT INTO inventories (uid, item_id, quantity) VALUES ('" + uid+ "', " + item + ", 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;";
	int i = st.executeUpdate(qry);
	if (i > 0) {
		response.sendRedirect("travel.jsp");
	} else {
		response.sendRedirect("travel.jsp?status=false");
	}
	con.close();

%>
