<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="beans.Member" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<jsp:useBean id="m" class="beans.Member" />
	<jsp:setProperty property="*" name="m" />
	
	<%
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/myweb";
		String driver = "com.mysql.jdbc.Driver";
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "root", "1234");
			sql = "select * from member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, m.getId());
			rs = ps.executeQuery();
			
			if (!rs.next()) {
				ps.close();
				rs.close();
				con = DriverManager.getConnection(url, "root", "1234");
				sql = "insert into member values(?,?,?,?,?,?, 5000)";
				ps = con.prepareStatement(sql);
				ps.setString(1, m.getId());
				ps.setString(2, m.getPassword());
				ps.setString(3, m.getName());
				ps.setInt(4, m.getAge());
				ps.setString(5, m.getGender());
				ps.setString(6, m.getEmail());
				
				int a = ps.executeUpdate();
				if (a == 1) {
					response.sendRedirect("index.jsp");
				}
				else { %>
					<script>
						history.go(-1);
					</script>
	   	<%}
				
			} else {
				out.println("<script>");
				out.println("alert('동일한 아이디가 존재합니다. ')");
				out.println("history.go(-1)");
				out.println("</script>");
			}
			
		} catch(Exception e) {
			System.out.println("연결 실패");
			e.printStackTrace();
		}
	%>
</body>
</html>