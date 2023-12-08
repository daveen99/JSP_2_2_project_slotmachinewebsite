<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.BoardDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DB.JdbcUtil" %>

<%
    String pointParameter = request.getParameter("point");
    int point = 0;
    if (pointParameter != null && !pointParameter.isEmpty()) {
        try {
            point = Integer.parseInt(pointParameter);
        } catch (NumberFormatException e) {
        	System.out.println("숫자로 변환 실패");
        }
    }

    Connection con = null;
    try {
    	HttpSession Hsession = request.getSession();
		Integer up = (Integer) Hsession.getAttribute("userPoint");
		if (up != null) {
			if (point == 100 || point >= 100000){
				int newPoint = up - point;
				Hsession.setAttribute("userPoint", newPoint);
			} else {
				int newPoint = up + point;
				Hsession.setAttribute("userPoint", newPoint);
			}
		}

    	
        con = JdbcUtil.getConnection();
        BoardDAO dao = BoardDAO.getInstance();
        dao.setCon(con);
        String id = (String)session.getAttribute("id");
      	int a = dao.minusPoint(id, point);
    } catch (Exception e) {
    	e.printStackTrace();
    } finally {
        JdbcUtil.close(con);
    }
%>