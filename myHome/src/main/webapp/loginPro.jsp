<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		request.setCharacterEncoding("utf-8"); 
	
		String id = request.getParameter("id");
		String pass = request.getParameter("password");
	
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/myweb";
		String driver = "com.mysql.jdbc.Driver";
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "root", "1234");
			sql = "select * from member where id = ? && password = ?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, id);
			ps.setString(2, pass);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				session.setAttribute("id", id);
				session.setAttribute("name", rs.getString("name"));
				
				String userId = rs.getString("id");
				HttpSession Hsession = request.getSession();
				Hsession.setAttribute("isAdmin", userId);
				
				Hsession.setAttribute("userPoint", rs.getInt("point"));
				
				out.println("<script>");
				out.println("location.href = 'index.jsp'");
				out.println("</script>");
			}
			out.println("<script>");
			out.println("alert('로그인 정보가 일치하지 않습니다.')");
			out.println("history.go(-1)");
			out.println("</script>");
		}
		catch(SQLException e) {
			e.printStackTrace();

		}
		
	%>
</body>
</html>