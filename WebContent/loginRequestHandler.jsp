<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("uid");
    String pwd = request.getParameter("pass");
    // -- Connection
    Class.forName("com.mysql.jdbc.Driver");
    String URL="jdbc:mysql://[databaseurl]/";
    String DATABASE_NAME="dbName";
    String USERNAME="someusername";
    String PASSWORD="someurl";
    Connection con =DriverManager.getConnection(URL+DATABASE_NAME,USERNAME,PASSWORD);
    Statement st = con.createStatement();
    // --
    ResultSet rs;
    // password is not salted or hashed or encrypted in any form for simplicity
    rs = st.executeQuery("select * from users where uid='" + userid + "' and pass='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("uid", userid);
        response.sendRedirect("home.jsp");
    } else {
        response.sendRedirect("index.jsp?status=false");
    }
    con.close();
%>
