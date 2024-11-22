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
  var kode = document.forms["myForm"]["kode"].value;
  var nama = document.forms["myForm"]["nama"].value;
  var ortu = document.forms["myForm"]["ortu"].value;
  var kelamin = document.forms["myForm"]["kelamin"].value;
  var alamat = document.forms["myForm"]["alamat"].value;
  if (kode == "" || nama == "" || ortu == "" || kelamin == "" || alamat == "") {
    alert("All fields must be filled out");
    return false;
  }
}
</script>
</head>
<body>
<div id="con2">
<h3 align="center">Add Data</h3><p></p>
<form name="myForm" action="" method="post" onsubmit="return validateForm()">
<p>
<label>Code</label><input type="text" name="kode"/>
</p>
<p>
<label>Name</label><input type="text" name="nama"/>
</p>
<p>
<label>Parent's Name</label><input name="ortu" type="text" />
</p>
<p>
<label>Gender</label>
<input type="radio" name="kelamin" value="Male"/> Male
<input type="radio" name="kelamin" value="Female"/> Female
</p>
<p>
<label>Address</label><input type="text" name="alamat"/>
</p>
<p>
<label></label><input type="submit" name="submit" value="Save"/>
<a href="index.jsp">Back</a>
</p>
</form>
</div>
</body>
</html>
<%
String a=request.getParameter("kode");
String b=request.getParameter("nama");
String d=request.getParameter("kelamin");
String c=request.getParameter("ortu");
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
      String query="insert into biodata(kode,nama,kelamin,alamat,ortu) values(?,?,?,?,?)";
      ps=conn.prepareStatement(query);
      ps.setString(1,a);
      ps.setString(2,b);
      ps.setString(3,c);
      ps.setString(4,d);
      ps.setString(5,e);
      updateQuery=ps.executeUpdate();
      if(updateQuery!=0){
        JOptionPane.showMessageDialog(null, "Data Added Successfully");
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