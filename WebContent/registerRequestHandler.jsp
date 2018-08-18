<%@ page import ="java.sql.*, java.util.*" %>
<%
    String user = request.getParameter("uid");
    String pwd = request.getParameter("pass");
    String name = request.getParameter("name");

 	// -- Connection
    Class.forName("com.mysql.jdbc.Driver");
    String URL="jdbc:mysql://[databaseurl]/";
    String DATABASE_NAME="dbName";
    String USERNAME="someusername";
    String PASSWORD="someurl";
    Connection con =DriverManager.getConnection(URL+DATABASE_NAME,USERNAME,PASSWORD);
    Statement st = con.createStatement();
    // --
    Random r = new Random();
    int randomLocationId = r.nextInt(4) + 5;
    // password is not salted or hashed or encrypted in any form for simplicity
    String qry = "INSERT INTO users (uid, name, pass, gold, location) VALUES ('" + user + "', '" + name + "', '" + pwd + "', 100, " + randomLocationId + ")";
    try{
    int i = st.executeUpdate(qry);
    if (i > 0) {
        response.sendRedirect("index.jsp");
    } else {
    	response.sendRedirect("register.jsp?status=false");
    }
    } catch (Exception ex){
    	response.sendRedirect("register.jsp?status=false");
    } finally {
    	con.close();
    }
%>
