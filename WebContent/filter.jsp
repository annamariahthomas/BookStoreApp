<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String database = "books";
	String userid = "root";
	String password = "password";
	String sql="";
	String name="";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor="olive">
	<h1 style="text-align:center">BookStore</h1>
	<table border="1" align="center">
		<tr>
			<td>BOOK_ID</td>
			<td>BOOK_NAME</td>
			<td>BOOK_AUTHOR</td>
			<td>BOOK_PRICE</td>
		</tr>
		<%
			try {
				connection = DriverManager.getConnection(connectionUrl + database, userid, password);
				statement = connection.createStatement();
				if (request.getParameter("nameLis")!=null){
					name = request.getParameter("nameLis");
					name=((char)34+name+(char)34);
					sql = "select * from Books where BOOK_NAME="+name;
					
				} else if (request.getParameter("authorLis")!=null) {
					name = request.getParameter("authorLis");
					name=((char)34+name+(char)34);
					sql = "select * from Books where BOOK_AUTHOR="+name;
					
				} else if (request.getParameter("priceLis")!=null) {
					name = request.getParameter("priceLis");
					sql = "select * from Books where BOOK_PRICE=" + name;
				} else if((request.getParameter("nameLis")!=null)&&(request.getParameter("authorLis")!=null)) {
					name = request.getParameter("nameLis");
					name=((char)34+name+(char)34);
					sql = "select * from Books where BOOK_NAME="+name;
				}else if((request.getParameter("authorLis")!=null)&&(request.getParameter("priceLis")!=null)) {
					name = request.getParameter("authorLis");
					name=((char)34+name+(char)34);
					sql = "select * from Books where BOOK_AUTHOR="+name;
				} else if((request.getParameter("priceLis")!=null)&&(request.getParameter("nameLis")!=null)) {
					name = request.getParameter("nameLis");
					name=((char)34+name+(char)34);
					sql = "select * from Books where BOOK_NAME="+name;
				}else {
					name = request.getParameter("nameLis");
					name=((char)34+name+(char)34);
					sql = "select * from Books where BOOK_NAME="+name;
				}
				resultSet = statement.executeQuery(sql);
				while (resultSet.next()) {
		%>
		<tr>
			<td><%=resultSet.getString("BOOK_ID")%></td>
			<td><%=resultSet.getString("BOOK_NAME")%></td>
			<td><%=resultSet.getString("BOOK_AUTHOR")%></td>
			<td><%=resultSet.getString("BOOK_PRICE")%></td>
		</tr>

		<%
			}
				connection.close();
				statement.close();
				resultSet.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</table>
</body>
</html>