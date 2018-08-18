<%@page import="java.util.stream.Stream"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
	String data = request.getParameter("buildRadios");


	// -- Connection
	Class.forName("com.mysql.jdbc.Driver");
	String URL = "jdbc:mysql://[yourdatabaseurl]/";
	String DATABASE_NAME = "mycs336db";
	String USERNAME = "someusername";
	String PASSWORD = "somepassword";
	Connection con = DriverManager.getConnection(URL + DATABASE_NAME, USERNAME, PASSWORD);
	Statement st = con.createStatement();
	// --

	String uid = (String) session.getAttribute("uid");
	String[] params = data.split("/");
	//[0] -  recipe id
	//[1] -  made item id
	//[2] -  clth qntty
	//[3] -  clth id
	//[4] -  lthr qntty
	//[5] -  lthr id
	//[6] -  mtl qntty
	//[7] -  mtl id
	//[8] -  wd qntty
	//[9] -  wd id

	try{
	ResultSet rs;
	int missing = 0;

	if(missing == 0 && !params[3].equals("null")){
		System.out.println("clth");
		rs = st.executeQuery("SELECT quantity FROM inventories WHERE uid='" + uid + "' AND item_id = " + Integer.parseInt(params[3]));
		if(rs.next()){
			int quantity = rs.getInt("quantity");
			if(quantity - Integer.parseInt(params[2]) >= 0){
				// -- Has enough
			}else {
				missing++;
			}
		} else {
			missing++;
		}
	}

	if(missing == 0 && !params[5].equals("null")){
		System.out.println("lthr");
		rs = st.executeQuery("SELECT quantity FROM inventories WHERE uid='" + uid + "' AND item_id = " + Integer.parseInt(params[5]));
		if(rs.next()){
			int quantity = rs.getInt("quantity");
			if(quantity - Integer.parseInt(params[4]) >= 0){
				// -- Has enough
			}else {
				missing++;
			}
		} else {
			missing++;
		}
	}

	if(missing == 0 && !params[7].equals("null")){
		System.out.println("mtl");
		rs = st.executeQuery("SELECT quantity FROM inventories WHERE uid='" + uid + "' AND item_id = " + Integer.parseInt(params[7]));
		if(rs.next()){
			int quantity = rs.getInt("quantity");
			if(quantity - Integer.parseInt(params[6]) >= 0){
				// -- Has enough
			}else {
				missing++;
			}
		} else {
			missing++;
		}
	}

	if(missing == 0 && !params[9].equals("null")){
		System.out.println("wd");
		rs = st.executeQuery("SELECT quantity FROM inventories WHERE uid='" + uid + "' AND item_id = " + Integer.parseInt(params[9]));
		if(rs.next()){
			int quantity = rs.getInt("quantity");
			if(quantity - Integer.parseInt(params[8]) >= 0){
				// -- Has enough
			}else {
				missing++;
			}
		} else {
			missing++;
		}
	}

	if(missing != 0){
		response.sendRedirect("home.jsp?status=INF");
	} else {
		int cq = Integer.parseInt(params[2]);
		int lq = Integer.parseInt(params[4]);
		int mq = Integer.parseInt(params[6]);
		int wq = Integer.parseInt(params[8]);
		if (cq > 0){
			String sql="Update inventories set quantity = (quantity - " + cq + ") where uid = '"+uid+"' AND item_id = " + Integer.parseInt(params[3]);
			int z = st.executeUpdate(sql);
		}
		if (lq > 0){
			String sql="Update inventories set quantity = (quantity - " + lq + ") where uid = '"+uid+"' AND item_id = " + Integer.parseInt(params[5]);
			int z = st.executeUpdate(sql);
		}
		if (mq > 0){
			String sql="Update inventories set quantity = (quantity - " + mq + ") where uid = '"+uid+"' AND item_id = " + Integer.parseInt(params[7]);
			int z = st.executeUpdate(sql);
		}
		if (wq > 0){
			String sql="Update inventories set quantity = (quantity - " + wq + ") where uid = '"+uid+"' AND item_id = " + Integer.parseInt(params[9]);
			int z = st.executeUpdate(sql);
		}

		PreparedStatement pst = null;
		pst = con.prepareStatement("delete from inventories where quantity < ?");
		pst.setInt(1,1);
		pst.executeUpdate();

		String qry = "INSERT INTO inventories (uid, item_id, quantity) VALUES ('" + uid+ "', " + Integer.parseInt(params[1]) + ", 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;";

    	int i = st.executeUpdate(qry);
    	if (i > 0) {
        	response.sendRedirect("home.jsp");
    	} else {
    		response.sendRedirect("home.jsp?status=false");
    	}
	}
	}catch(Exception ex){
		response.sendRedirect("home.jsp?status=false");
		System.out.print(ex.getLocalizedMessage());
	} finally {
		con.close();
	}
%>
