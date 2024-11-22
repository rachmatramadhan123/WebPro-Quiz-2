<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
<style type="text/css">
*{margin:auto;padding:0;}
#con2{width:500px;padding:30px;}
p{margin-bottom:10px;}
label{display:inline-block;width:150px;}
</style>
<script>
function validateForm() {
  var nama = document.forms["myForm"]["nama"].value;
  var ortu = document.forms["myForm"]["ortu"].value;
  var kelamin = document.forms["myForm"]["kelamin"].value;
  var alamat = document.forms["myForm"]["alamat"].value;
  if (nama == "" || ortu == "" || kelamin == "" || alamat == "") {
    alert("All fields must be filled out");
    return false;
  }
}
</script>
</head>
<body>
<div id="con2">
<h3 align="center">Update Data</h3><p></p>
<form name="myForm" action="" method="post" onsubmit="return validateForm()">
<%
try {
  String Host = "jdbc:mysql://localhost:8080/jsp";
  Connection connection = null;
  Statement statement = null;
  ResultSet rs = null;
  Class.forName("com.mysql.jdbc.Driver");
  connection = DriverManager.getConnection(Host, "root", "");
  statement = connection.createStatement();
  String u=request.getParameter("u");
  int num=Integer.parseInt(u);
  String Data = "select * from biodata where kode='"+num+"'";
  rs = statement.executeQuery(Data);
  while (rs.next()) {
%>
<p>
<label></label><input type="hidden" name="kode" value='<%=rs.getString("kode")%>'/>
</p>
<p>
<label>Name</label><input type="text" name="nama" value='<%=rs.getString("nama")%>'/>
</p>
<p>
<label>Parent's Name</label><input name="ortu" type="text" value='<%=rs.getString("ortu")%>'/>
</p>
<p>
<label>Gender</label>
<input type="radio" name="kelamin" value="Male"/> Male
<input type="radio" name="kelamin" value="Female"/> Female
</p>
<p>
<label>Address</label><input type="text" name="alamat" value='<%=rs.getString("alamat")%>'/>
</p>
<p>
<label></label><input type="submit" name="submit" value="Update"/>
<a href="index.jsp">Back</a>
</p>
<% }
  rs.close();
  statement.close();
  connection.close();
} catch (Exception ex) {
  out.println("Can't connect to database.");
}
%>
</form>
</div>
</body>
</html>
<%
String a=request.getParameter("kode");
String b=request.getParameter("nama");
String c=request.getParameter("ortu");
String d=request.getParameter("kelamin");
String e=request.getParameter("alamat");
// Create a variable to store the address for database access later.
String url="jdbc:mysql://localhost:8080/jsp";
// Create a connection to the database with jdbc
Connection conn=null;
PreparedStatement ps=null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
int updateQuery=0;
// Check that the name, city, and phone textboxes are not empty
if(a!=null && b!=null && c!=null && d!=null && e!=null){
  if(a!="" && b!="" && c!="" && d!="" && e!=""){
    try{
      conn=DriverManager.getConnection(url,"root","");
      String query="update biodata set nama=?,ortu=?,kelamin=?,alamat=? where kode='"+a+"'";
      ps=conn.prepareStatement(query);
      ps.setString(1,b);
      ps.setString(2,c);
      ps.setString(3,d);
      ps.setString(4,e);
      updateQuery=ps.executeUpdate();
      if(updateQuery!=0){
        JOptionPane.showMessageDialog(null, "Data Updated Successfully");
        response.sendRedirect("index.jsp");
      }
    }catch(Exception ex){
      out.println("Connection problem");
    }finally{
      ps.close();
      conn.close();
    }
  }
}
%>