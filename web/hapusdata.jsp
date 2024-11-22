<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body>
<%
String id=request.getParameter("d");
int no=Integer.parseInt(id);
try {
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:8080/jsp", "root", "");
  Statement st = conn.createStatement();
  st.executeUpdate("DELETE FROM biodata WHERE kode = '"+no+"'");
  response.sendRedirect("index.jsp");
} catch(Exception e){}
%>
</body>
</html>