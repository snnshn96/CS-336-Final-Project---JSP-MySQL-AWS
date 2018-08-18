<%@ page import="java.sql.*, java.util.*"%>
<%
	int market = Integer.parseInt(request.getParameter("market"));
	int item = Integer.parseInt(request.getParameter("buyRadios"));


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

	System.out.println("marketid = " + market);
	System.out.println("item = " + item);


	ResultSet rs;
	rs = st.executeQuery("SELECT gold FROM users WHERE uid='" + uid + "'");
	rs.next();
	int UserGold = rs.getInt("gold");

	rs = st.executeQuery("SELECT T.price FROM market_trades T WHERE T.market_id='" + market + "' AND T.item_id=" + item + " AND T.trade_type='B'");
	rs.next();
	int ItemCost = rs.getInt("price");

	if (ItemCost < UserGold){
		// Take Gold
		PreparedStatement ps = null;
		String sql="Update users set gold=? where uid='"+uid+"'";
		ps = con.prepareStatement(sql);
		ps.setInt(1,(UserGold - ItemCost));
		try {
			int i = ps.executeUpdate();
			if (i > 0) {
				// Add To Inventory

				String qry = "INSERT INTO inventories (uid, item_id, quantity) VALUES ('" + uid+ "', " + item + ", 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;";

			    	i = st.executeUpdate(qry);
			    	if (i > 0) {
			        	response.sendRedirect("travel.jsp");
			    	} else {
			    		response.sendRedirect("travel.jsp?status=false");
			    	}

			} else {
				response.sendRedirect("travel.jsp?status=false");
			}
		} catch (Exception ex) {
			response.sendRedirect("travel.jsp?status=false");
			System.out.print(ex.getLocalizedMessage());
		} finally {
	    	con.close();
	    }
	} else {
		con.close();
		response.sendRedirect("travel.jsp?status=NEG");
	}
%>
