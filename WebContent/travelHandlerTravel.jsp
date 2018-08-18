<%@ page import="java.sql.*, java.util.*"%>
<%
	int newLocation = Integer.parseInt(request.getParameter("location"));

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
	int newLoc = newLocation;
	System.out.println("NEW LOC" + newLoc);

	ResultSet rs;
	rs = st.executeQuery("SELECT gold, location FROM users WHERE uid='" + uid + "'");
	rs.next();
	int UserGold = rs.getInt("gold");
	int UserCurrentLocation = rs.getInt("location");
	if (UserCurrentLocation - 4 == newLocation){
		// FREE
	}else {
		// 1 Gold
		PreparedStatement ps = null;
		String sql="Update users set gold=? where uid='"+uid+"'";
		ps = con.prepareStatement(sql);
		ps.setInt(1,(UserGold - 1));
		try {
			int i = ps.executeUpdate();
		}catch(Exception e){

		}
	}

	PreparedStatement ps = null;
	String sql="Update users set location=? where uid='"+uid+"'";
	ps = con.prepareStatement(sql);
	ps.setInt(1,newLoc);
	try {
		int i = ps.executeUpdate();
		if (i > 0) {
			response.sendRedirect("travel.jsp");
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
