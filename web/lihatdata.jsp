<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body>
<div id="con">
<h3 align="center">CRUD Application with JSP and MySQL</h3>
<a href="tambah.jsp">Add</a>
<p></p>

<form action="lihatdata.jsp" method="get">
  <input type="text" name="search" placeholder="Search by name">
  <input type="submit" value="Search">
</form>

<%
try {
  String Host = "jdbc:mysql://localhost:8080/jsp";
  Connection connection = null;
  Statement statement = null;
  ResultSet rs = null;
  Class.forName("com.mysql.jdbc.Driver");
  connection = DriverManager.getConnection(Host, "root", "");
  statement = connection.createStatement();

  int page = 1;
  int recordsPerPage = 5;
  if (request.getParameter("page") != null)
    page = Integer.parseInt(request.getParameter("page"));
  int start = (page - 1) * recordsPerPage;

  String searchQuery = request.getParameter("search");
  String Data = "select * from biodata";
  if (searchQuery != null && !searchQuery.isEmpty()) {
    Data += " where nama like '%" + searchQuery + "%'";
  }

  String sortColumn = request.getParameter("sort");
  if (sortColumn != null && !sortColumn.isEmpty()) {
    Data += " order by " + sortColumn;
  }

  Data += " limit " + start + ", " + recordsPerPage;
  rs = statement.executeQuery(Data);
%>
<table border="1" cellspacing="0" cellpadding="0" width="100%">
<tr>
  <th><a href="lihatdata.jsp?sort=kode">Code</a></th>
  <th><a href="lihatdata.jsp?sort=nama">Name</a></th>
  <th>Parent's Name</th>
  <th><a href="lihatdata.jsp?sort=kelamin">Gender</a></th>
  <th><a href="lihatdata.jsp?sort=alamat">Address</a></th>
  <th>Action</th>
</tr>
<%
  while (rs.next()) {
%>
<tr>
  <td><%=rs.getString("kode")%></td>
  <td><%=rs.getString("nama")%></td>
  <td><%=rs.getString("ortu")%></td>
  <td><%=rs.getString("kelamin")%></td>
  <td><%=rs.getString("alamat")%></td>
  <td><a href="update.jsp?u=<%=rs.getString("kode")%>" >edit</a> / <a href="hapusdata.jsp?d=<%=rs.getString("kode")%>" > delete</a></td>
</tr>
<% } %>
</table>
<%
  rs.close();
  statement.close();
  connection.close();

  int totalRecords = 0;
  ResultSet rsCount = statement.executeQuery("select count(*) from biodata");
  if (rsCount.next()) {
    totalRecords = rsCount.getInt(1);
  }
  int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
  for (int i = 1; i <= totalPages; i++) {
    out.print("<a href='lihatdata.jsp?page=" + i + "'>" + i + "</a> ");
  }
} catch (Exception ex) {
  out.println("Can't connect to database.");
}
%>
</div>
</body>
</html>