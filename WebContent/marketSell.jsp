<%@ page import="java.sql.*, java.util.*"%>
<%
	int market = Integer.parseInt(request.getParameter("market"));
	int item = Integer.parseInt(request.getParameter("sellRadios"));


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

	rs = st.executeQuery("SELECT T.price FROM market_trades T WHERE T.market_id='" + market + "' AND T.item_id=" + item + " AND T.trade_type='S'");
	rs.next();
	int ItemCost = rs.getInt("price");


	rs = st.executeQuery("SELECT quantity FROM inventories WHERE uid='" + uid + "' AND item_id = " + item);
	if(rs.next()){
		int usersQuantity = rs.getInt("quantity");
		if(usersQuantity - 1 >= 0){

				// Give Gold
				PreparedStatement ps = null;
				String sql="Update users set gold = gold + ? where uid = '"+uid+"'";
				ps = con.prepareStatement(sql);
				ps.setInt(1,(ItemCost));
				try {
					int i = ps.executeUpdate();
					if (i > 0) {
						// Remove from Inventory


						sql="Update inventories set quantity = (quantity - 1) where uid = '"+uid+"' AND item_id = " + item;
						int z = st.executeUpdate(sql);
						if (z > 0) {
							PreparedStatement pst = null;
							pst = con.prepareStatement("delete from inventories where quantity < ?");
					        pst.setInt(1,1);

					        pst.executeUpdate();
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
				}finally{
			        ps.close();
			        con.close();
			    }
		} else {
	        con.close();
		}
	} else {
		con.close();
		response.sendRedirect("travel.jsp?status=IDE");
	}

%>
